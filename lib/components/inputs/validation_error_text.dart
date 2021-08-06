import 'package:flutter/material.dart';

class ValidationErrorText extends StatelessWidget {
  const ValidationErrorText({
    Key? key,
    required this.errorText,
    required this.hasError,
  }) : super(key: key);

  final String? errorText;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return hasError
        ? Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              errorText ?? '-',
              style: TextStyle(color: Colors.red),
            ),
          )
        : Container();
  }
}
