import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/styles/colors.dart';

class ImageCarrossel extends StatefulWidget {
  const ImageCarrossel({
    Key? key,
    required this.imageAssets,
    required this.title,
  }) : super(key: key);

  final List<String> imageAssets;
  final String title;

  @override
  _ImageCarrosselState createState() => _ImageCarrosselState();
}

class _ImageCarrosselState extends State<ImageCarrossel> {
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
          children: [...widget.imageAssets.map((e) => _imageItem(asset: e))],
        ),
      );

  Widget _imageItem({required String asset}) => Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.hardEdge,
        width: 260,
        child: Image(
          image: AssetImage(asset),
          fit: BoxFit.cover,
        ),
      );
}
