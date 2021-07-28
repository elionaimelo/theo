import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/lazy_image.dart';
import 'package:theo/models/file.dart';
import 'package:theo/pages/discover_game_screen/components/bottom_sheet_image_carousel.dart';
import 'package:theo/styles/colors.dart';

class ImageCarrossel extends StatefulWidget {
  const ImageCarrossel({
    Key? key,
    required this.imageFiles,
    required this.title,
  }) : super(key: key);

  final List<File> imageFiles;
  final String title;

  @override
  _ImageCarrosselState createState() => _ImageCarrosselState();
}

class _ImageCarrosselState extends State<ImageCarrossel> {
  void _onTapImage() {
    BottomSheetImageCarousel.showImageCarouselBottomSheet(
      context,
      imageFiles: widget.imageFiles,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _title,
              _arrowRight,
            ],
          ),
          _imageList,
        ],
      ),
    );
  }

  Widget get _title => Text(
        widget.title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 16,
              color: TheoColors.six,
              fontWeight: FontWeight.w700,
            ),
      );

  Widget get _arrowRight => IconButton(
        icon: Icon(
          FeatherIcons.arrowRight,
          color: TheoColors.primary,
        ),
        onPressed: () {},
      );

  Widget get _imageList => Container(
        height: 140,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [...widget.imageFiles.map((e) => _imageItem(image: e))],
        ),
      );

  Widget _imageItem({required File image}) => Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.hardEdge,
        width: 260,
        child: InkWell(
          onTap: _onTapImage,
          child: LazyImage(
            file: image,
          ),
        ),
      );
}
