import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:theo/styles/colors.dart';

class GalleryImagePicker extends StatefulWidget {
  @override
  _GalleryImagePickerState createState() => _GalleryImagePickerState();
}

class _GalleryImagePickerState extends State<GalleryImagePicker> {
  final List<Widget> _mediaList = [];
  int currentPage = 0;
  late int lastPage;
  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
  }

  void _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia();
      }
    }
  }

  void _onCloseTap() {
    Navigator.of(context).pop();
  }

  Future<void> _fetchNewMedia() async {
    lastPage = currentPage;
    var albums = await PhotoManager.getAssetPathList(onlyAll: true);
    var media = await albums[0].getAssetListPaged(currentPage, 60);
    var temp = <Widget>[];

    for (var asset in media) {
      if (asset.type != AssetType.image) {
        continue;
      }

      temp.add(
        FutureBuilder(
          future: asset.thumbDataWithSize(200, 200),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent, width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Image.memory(
                  snapshot.data as Uint8List,
                  fit: BoxFit.cover,
                ),
              );
            }
            return Container();
          },
        ),
      );
    }
    setState(() {
      _mediaList.addAll(temp);
      currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scroll) {
        _handleScrollEvent(scroll);
        return true;
      },
      child: _content,
    );
  }

  Widget get _content => SafeArea(
        child: Container(
          color: TheoColors.secondary,
          margin:
              EdgeInsets.fromLTRB(0, AppBar().preferredSize.height + 30, 0, 0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, left: 9, bottom: 25),
                child: _actions,
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.all(3),
                child: _grid,
              )),
            ],
          ),
        ),
      );

  Widget get _actions => Container(
        child: Row(
          children: [
            InkWell(
              onTap: _onCloseTap,
              child: Icon(
                FeatherIcons.x,
                size: 30,
                color: TheoColors.primary,
              ),
            ),
            Text(
              'Cancelar',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 14,
                    color: TheoColors.primary,
                  ),
            )
          ],
        ),
      );

  Widget get _grid => GridView.builder(
        itemCount: _mediaList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return _mediaList[index];
        },
      );
}