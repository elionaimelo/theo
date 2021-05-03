import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:theo/components/inputs/gallery_image_picker.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/gerenal.dart';
import 'package:theo/utils/formatter.dart';

enum EFileType {
  IMAGE,
  OTHER,
}

class SelectedFile {
  SelectedFile({required this.title, required this.size});

  final String title;
  final String size;
}

class FileInput extends StatefulWidget {
  FileInput({
    required this.label,
    required this.minFileLength,
    required this.onImageSelected,
    required this.buttonText,
    required this.buttonIcon,
    required this.fileType,
  });

  final String label;
  final String minFileLength;
  final String buttonText;
  final IconData buttonIcon;
  final Function(AssetEntity image) onImageSelected;
  final EFileType fileType;

  @override
  _FileInputState createState() => _FileInputState();
}

class _FileInputState extends State<FileInput> {
  SelectedFile? file;

  void _onTapRemoveFile() {
    setState(() {
      file = null;
    });
  }

  Future<void> _onImageSelected(AssetEntity assetImage) async {
    var originBytes = (await assetImage.originBytes)!;

    setState(() {
      file = SelectedFile(
        title: assetImage.title!,
        size: Formatter.formatBytes(originBytes.lengthInBytes, 0),
      );
    });

    widget.onImageSelected(assetImage);
  }

  Future<void> _onTap() async {
    if (widget.fileType == EFileType.IMAGE) {
      await showModalBottomSheet<void>(
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

      return;
    }

    var result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt', 'pdf', 'doc'],
        allowMultiple: false);

    if (result != null && result.count > 0) {
      var resultFile = result.files.single;

      setState(() {
        file = SelectedFile(
          title: resultFile.name!,
          size: Formatter.formatBytes(resultFile.size!, 0),
        );
      });
    }
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
          if (file != null) _selectedFile
        ],
      ),
    );
  }

  Widget get _selectedFile => Container(
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
                widget.buttonIcon,
                color: TheoColors.eleven,
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: StrutStyle(fontSize: 14.0),
                  text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 14),
                    text: file!.title.toString() + ' ',
                  ),
                ),
              ),
              Text(
                '(${file!.size})',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 14),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: _onTapRemoveFile,
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
          style: TheoStyles.of(context).labelInputStyle,
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
        widget.buttonIcon,
        color: TheoColors.seven,
      );

  Widget get _text => Text(
        widget.buttonText,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: TheoColors.seven,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
      );

  Widget get _minLengthText => Text(
        'Tamanho mínimo de ${widget.minFileLength} KB',
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 15,
              color: TheoColors.seven,
            ),
      );
}
