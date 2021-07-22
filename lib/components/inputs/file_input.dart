import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:theo/components/error_alert_dialog.dart';
import 'package:theo/components/inputs/gallery_media_picker.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/gerenal.dart';
import 'package:theo/utils/formatter.dart';

class SelectedFile {
  SelectedFile({required this.title, required this.size, required this.path});

  final String title;
  final String? size;
  final String path;
}

class FileInput extends StatefulWidget {
  FileInput({
    required this.label,
    required this.minFileLength,
    required this.onFileSelected,
    required this.buttonText,
    required this.buttonIcon,
    required this.assetType,
  });

  final String label;
  final String minFileLength;
  final String buttonText;
  final IconData buttonIcon;
  final Function(String filePath) onFileSelected;

  final AssetType assetType;

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

  Future<void> _onImageSelected(AssetEntity mediaAsset) async {
    try {
      var selectedFile;

      var inputFile = await mediaAsset.file;

      if (mediaAsset.type == AssetType.image ||
          mediaAsset.type == AssetType.other) {
        var originBytes = await mediaAsset.originBytes;

        selectedFile = SelectedFile(
          title: mediaAsset.title!,
          path: inputFile!.absolute.path,
          size: Formatter.formatBytes(originBytes!.lengthInBytes, 0),
        );
      } else {
        selectedFile = SelectedFile(
          title: mediaAsset.title!,
          path: inputFile!.absolute.path,
          size: null,
        );
      }

      setState(() {
        file = selectedFile;
      });

      widget.onFileSelected(file!.path);
    } catch (err) {
      ErrorAlertDialog.showAlertDialog(content: err.toString());
    }
  }

  Future<void> _onTap() async {
    if (widget.assetType == AssetType.video ||
        widget.assetType == AssetType.image) {
      await GalleryMediaPicker.showGalleryBottomSheet(
          context, _onImageSelected, widget.assetType);

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
          path: resultFile.path!,
          size: Formatter.formatBytes(resultFile.size!, 0),
        );
      });

      widget.onFileSelected(file!.path);
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
              Container(
                margin: EdgeInsets.only(right: 5),
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
              if (file!.size != null)
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
                margin: EdgeInsets.only(left: 9, top: 10, bottom: 10, right: 5),
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
