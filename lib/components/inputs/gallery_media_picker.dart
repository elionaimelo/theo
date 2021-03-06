import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:theo/components/close_top_bar_button.dart';
import 'package:theo/pages/confirm_image_screen/confirm_image_screen.dart';
import 'package:theo/styles/colors.dart';

class GalleryMediaPicker extends StatefulWidget {
  GalleryMediaPicker({
    required this.onSelectedMedia,
    required this.assetType,
  });

  @override
  _GalleryMediaPickerState createState() => _GalleryMediaPickerState();

  final Function(AssetEntity mediaAsset) onSelectedMedia;
  final AssetType assetType;

  static Future<void> showGalleryBottomSheet(
      BuildContext context,
      Function(AssetEntity mediaAsset) onSelectedMedia,
      AssetType assetType) async {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return GalleryMediaPicker(
          onSelectedMedia: onSelectedMedia,
          assetType: assetType,
        );
      },
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
    );
  }
}

class _GalleryMediaPickerState extends State<GalleryMediaPicker> {
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

  void _onImageTap(AssetEntity mediaAsset) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => CorfirmImageScreen(
          mediaAsset: mediaAsset,
          onConfirmImage: (AssetEntity image) {
            widget.onSelectedMedia(image);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Future<void> _fetchNewMedia() async {
    lastPage = currentPage;
    var albums = await PhotoManager.getAssetPathList(onlyAll: true);
    var media = await albums[0].getAssetListPaged(currentPage, 60);
    var temp = <Widget>[];

    for (var asset in media) {
      if (asset.type != widget.assetType) {
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
                child: InkWell(
                  onTap: () => _onImageTap(asset),
                  child: Image.memory(
                    snapshot.data as Uint8List,
                    fit: BoxFit.cover,
                  ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topButton,
              Expanded(
                  child: Container(
                margin: EdgeInsets.all(3),
                child: _grid,
              )),
            ],
          ),
        ),
      );

  Widget get _topButton => Container(
        margin: EdgeInsets.only(top: 10, left: 9, bottom: 25),
        child: CloseTopBarButton(
          foregroundColor: TheoColors.primary,
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
