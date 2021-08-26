import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorAlertDialog extends StatefulWidget {
  ErrorAlertDialog({
    Key? key,
    this.title,
    required this.content,
    this.withButton = true,
  }) : super(key: key);

  @override
  _ErrorAlertDialogState createState() => _ErrorAlertDialogState();

  final String? title;
  final String content;
  final bool withButton;

  static void showAlertDialog({
    String? title,
    required String content,
    bool withButton = true,
  }) {
    showDialog(
      context: GetIt.I.get<NavigationStore>().currentContext,
      builder: (BuildContext context) {
        return ErrorAlertDialog(
          content: content,
          title: title,
          withButton: withButton,
        );
      },
    );
  }
}

class _ErrorAlertDialogState extends State<ErrorAlertDialog> {
  AppLocalizations get _locale => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title ?? _locale.error),
      content: Text(widget.content),
      actions: [
        if (widget.withButton) _okButton,
      ],
    );
  }

  Widget get _okButton => TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(_locale.ok),
      );
}
