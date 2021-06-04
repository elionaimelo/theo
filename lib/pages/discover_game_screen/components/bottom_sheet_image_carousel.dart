import 'package:flutter/material.dart';
import 'package:theo/components/close_top_bar_button.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

class BottomSheetImageCarousel extends StatefulWidget {
  const BottomSheetImageCarousel({Key? key, required this.imageAssets})
      : super(key: key);

  @override
  _BottomSheetImageCarouselState createState() =>
      _BottomSheetImageCarouselState();

  final List<String> imageAssets;

  static Future<void> showImageCarouselBottomSheet(
    BuildContext context, {
    required List<String> imageAssets,
  }) async {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetImageCarousel(
          imageAssets: imageAssets,
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
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ...widget.imageAssets.map(
                (e) => _imageItem(e),
              ),
            ],
          ),
        ),
      );

  Widget get _button => CloseTopBarButton(foregroundColor: TheoColors.primary);

  Widget _imageItem(String asset) => Container(
        margin: EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image(
          image: AssetImage(asset),
          fit: BoxFit.cover,
        ),
      );
}
