import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:theo/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CorfirmImageScreen extends StatefulWidget {
  CorfirmImageScreen({required this.mediaAsset, required this.onConfirmImage});

  @override
  _CorfirmImageScreenState createState() => _CorfirmImageScreenState();

  final AssetEntity mediaAsset;

  final Function(AssetEntity mediaAsset) onConfirmImage;
}

class _CorfirmImageScreenState extends State<CorfirmImageScreen> {
  AppLocalizations get _locale => AppLocalizations.of(context)!;

  void _onCancelTap() {
    Navigator.of(context).pop();
  }

  void _onConfirmTap() {
    widget.onConfirmImage(widget.mediaAsset);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: widget.mediaAsset.thumbDataWithSize(200, 200),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Center(
                  child: Image.memory(
                    snapshot.data as Uint8List,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _bottomContent,
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget get _bottomContent => Container(
        color: TheoColors.fiftteen,
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: _onCancelTap,
              child: Text(
                _locale.cancel,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16,
                      color: TheoColors.sixteen,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            TextButton(
              onPressed: _onConfirmTap,
              child: Text(
                _locale.choose,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16,
                      color: TheoColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ],
        ),
      );
}
