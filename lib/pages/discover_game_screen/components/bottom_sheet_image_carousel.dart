import 'package:flutter/material.dart';
import 'package:theo/components/close_top_bar_button.dart';
import 'package:theo/components/lazy_image.dart';
import 'package:theo/models/file.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

class BottomSheetImageCarousel extends StatefulWidget {
  const BottomSheetImageCarousel({Key? key, required this.imageFiles})
      : super(key: key);

  @override
  _BottomSheetImageCarouselState createState() =>
      _BottomSheetImageCarouselState();

  final List<File> imageFiles;

  static Future<void> showImageCarouselBottomSheet(
    BuildContext context, {
    required List<File> imageFiles,
  }) async {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetImageCarousel(
          imageFiles: imageFiles,
        );
      },
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
    );
  }
}

class _BottomSheetImageCarouselState extends State<BottomSheetImageCarousel> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: TheoMetrics.paddingScreen.copyWith(top: 0),
        color: TheoColors.secondary,
        child: Container(
          margin: EdgeInsets.only(top: AppBar().preferredSize.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _button,
              _list,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _list => Expanded(
        child: Container(
          margin: EdgeInsets.only(
            top: 50,
            bottom: 100,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget.imageFiles
                  .map(
                    (e) => _imageItem(e),
                  )
                  .toList(),
            ),
          ),
        ),
      );

  Widget get _button => CloseTopBarButton(foregroundColor: TheoColors.primary);

  Widget _imageItem(File image) => Container(
        margin: EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: LazyImage(
            file: image,
          ),
        ),
      );
}
