import 'package:flutter/material.dart';
import 'package:theo/components/line_text_button.dart';
import 'package:theo/styles/colors.dart';

class ProfileDataField extends StatelessWidget {
  const ProfileDataField({
    Key? key,
    required this.textLabel,
    required this.textValue,
    required this.onTap,
    this.obscureText = false,
  }) : super(key: key);

  final String textLabel;
  final String textValue;
  final Function onTap;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    var label = Text(
      textLabel,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 14,
            color: TheoColors.twentyOne,
          ),
    );

    var value = TextField(
      decoration: InputDecoration.collapsed(
        hintText: '',
        border: InputBorder.none,
      ),
      obscureText: obscureText,
      readOnly: true,
      controller: TextEditingController(text: textValue),
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 16,
            color: TheoColors.seven,
          ),
    );

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: value),
              LineTextButton(
                text: 'editar',
                onTap: onTap,
              )
            ],
          )
        ],
      ),
    );
  }
}
