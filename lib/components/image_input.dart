import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:theo/components/gallery_image_picker.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/utils/formatter.dart';

class ImageInput extends StatefulWidget {
  ImageInput({
    required this.label,
    required this.minImageLength,
  });

  final String label;
  final String minImageLength;

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  AssetEntity? selectedImage;
  String? imageSize;

  void _onTapRemoveImage() {
    setState(() {
      imageSize = null;
      selectedImage = null;
    });
  }

  Future<void> _onImageSelected(AssetEntity assetImage) async {
    var originBytes = (await assetImage.originBytes)!;

    setState(() {
      selectedImage = assetImage;
      imageSize = Formatter.formatBytes(originBytes.lengthInBytes, 0);
    });
  }

  void _onTap() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return GalleryImagePicker(
          onSelectedImage: _onImageSelected,
        );
      },
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label,
          _input,
          _minLengthText,
          if (selectedImage != null) _selectedImage
        ],
      ),
    );
  }

  Widget get _selectedImage => Container(
        decoration: BoxDecoration(
          border: Border.all(color: TheoColors.primary, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(
                FeatherIcons.image,
                color: TheoColors.eleven,
              ),
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: StrutStyle(fontSize: 14.0),
                  text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 14),
                    text: selectedImage!.title.toString() + ' ',
                  ),
                ),
              ),
              Text(
                '($imageSize)',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: _onTapRemoveImage,
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      'remover',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: TheoColors.primary),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget get _label => Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Text(
          widget.label,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: TheoColors.seven,
              ),
        ),
      );

  Widget get _input => Container(
        decoration: BoxDecoration(
          border: Border.all(color: TheoColors.seven, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: InkWell(
          onTap: _onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 9, top: 10, bottom: 10),
                child: _icon,
              ),
              _text,
            ],
          ),
        ),
      );

  Widget get _icon => Icon(
        FeatherIcons.image,
        color: TheoColors.seven,
      );

  Widget get _text => Text(
        'Inserir Imagem',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: TheoColors.seven,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
      );

  Widget get _minLengthText => Text(
        'Tamanho mínimo de ${widget.minImageLength} KB',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 15,
              color: TheoColors.seven,
            ),
      );
}
