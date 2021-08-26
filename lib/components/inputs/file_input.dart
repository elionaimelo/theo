import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:theo/components/error_alert_dialog.dart';
import 'package:theo/components/inputs/gallery_media_picker.dart';
import 'package:theo/components/inputs/validation_error_text.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/gerenal.dart';
import 'package:theo/utils/formatter.dart';
import 'package:theo/validators/focus_multi_validator.dart';
import 'package:theo/validators/validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:theo/values/error_messages.dart';

class SelectedFile {
  SelectedFile({required this.title, required this.size, required this.path});

  final String title;
  final String? size;
  final String path;
}

class FileInputFormFieldProps {
  FileInputFormFieldProps({
    required this.label,
    required this.minFileLength,
    required this.buttonText,
    required this.buttonIcon,
    required this.onFileSelected,
    this.multipleFiles = false,
    required this.focusNode,
    required this.assetType,
    this.validators = const [],
  });

  final String label;
  final String minFileLength;
  final String buttonText;
  final IconData buttonIcon;
  final Function(List<String> filePaths) onFileSelected;
  final bool multipleFiles;

  final AssetType assetType;
  final FocusNode focusNode;

  final List<Validator> validators;
}

class FileInputFormField extends FormField<List<SelectedFile>> {
  FileInputFormField(FileInputFormFieldProps props)
      : super(
          initialValue: [],
          validator: FocusMultiValidator(
            validators: props.validators,
            focusNode: props.focusNode,
          ),
          builder: (state) {
            return _FileInputView(
              props: props,
              formState: state,
            );
          },
        );
}

class _FileInputView extends StatelessWidget {
  _FileInputView({required this.props, required this.formState});

  final FormFieldState<List<SelectedFile>> formState;
  final FileInputFormFieldProps props;

  List<SelectedFile> get files => formState.value ?? [];

  void _onTapRemoveFile(SelectedFile f) {
    formState
        .didChange(files.where((element) => element.path != f.path).toList());
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

      if (props.multipleFiles) {
        formState.didChange([...files, selectedFile]);
      } else {
        formState.didChange([selectedFile]);
      }

      props.onFileSelected(filesPath);
    } catch (err) {
      ErrorAlertDialog.showAlertDialog(
        content: ErrorMessages.of(formState.context).PICK_IMAGE_ERROR,
      );
    }
  }

  List<String> get filesPath => files.map((f) => f.path).toList();

  Future<void> _onTap(BuildContext context) async {
    if (props.assetType == AssetType.video ||
        props.assetType == AssetType.image) {
      await GalleryMediaPicker.showGalleryBottomSheet(
          context, _onImageSelected, props.assetType);

      return;
    }

    var result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt', 'pdf', 'doc'],
        allowMultiple: false);

    if (result != null && result.count > 0) {
      var resultFile = result.files.single;

      var selectedFile = SelectedFile(
        title: resultFile.name!,
        path: resultFile.path!,
        size: Formatter.formatBytes(resultFile.size!, 0),
      );
      if (props.multipleFiles) {
        formState.didChange([...files, selectedFile]);
      } else {
        formState.didChange([selectedFile]);
      }

      props.onFileSelected(filesPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(context),
          ValidationErrorText(
            errorText: formState.errorText,
            hasError: formState.hasError,
          ),
          _input(context),
          _minLengthText(context),
          if (files.isNotEmpty)
            ...files.map(
              (e) => _selectedFile(e, context),
            ),
        ],
      ),
    );
  }

  Widget _selectedFile(SelectedFile sf, BuildContext context) => Container(
        margin: EdgeInsets.only(bottom: 5),
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
                props.buttonIcon,
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
                    text: sf.title.toString() + ' ',
                  ),
                ),
              ),
              if (sf.size != null)
                Text(
                  '(${sf.size})',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 14),
                ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: () => _onTapRemoveFile(sf),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: Text(
                      AppLocalizations.of(context)!.remove,
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

  Widget _label(BuildContext context) => Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Text(
          props.label,
          style: TheoStyles.of(context).labelInputStyle,
        ),
      );

  Widget _input(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: _inputBorderColor, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: InkWell(
          onTap: () => _onTap(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 9, top: 10, bottom: 10, right: 5),
                child: _icon,
              ),
              _text(context),
            ],
          ),
        ),
      );

  Color get _inputBorderColor =>
      formState.hasError ? Colors.red : TheoColors.seven;

  Widget get _icon => Icon(
        props.buttonIcon,
        color: TheoColors.seven,
      );

  Widget _text(BuildContext context) => Text(
        props.buttonText,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: TheoColors.seven,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
      );

  Widget _minLengthText(BuildContext context) => Text(
        AppLocalizations.of(context)!.minFileLength(props.minFileLength),
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 15,
              color: TheoColors.seven,
            ),
      );
}
