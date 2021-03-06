import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/validators/focus_multi_validator.dart';
import 'package:theo/validators/validator.dart';

class TextSelectorInput extends StatefulWidget {
  TextSelectorInput({
    required this.items,
    required this.onSelectionChanged,
    required this.label,
    this.validators = const [],
    this.autoFocus = false,
  });

  final List<String> items;
  final Function(String?) onSelectionChanged;
  final String label;
  final List<Validator> validators;
  final bool autoFocus;

  @override
  _TextSelectorInputState createState() => _TextSelectorInputState();
}

class _TextSelectorInputState extends State<TextSelectorInput> {
  String? currentValue;
  final FocusNode focusNode = FocusNode();
  void _onSelectionChanged(String? value) {
    setState(() {
      currentValue = value;
    });

    widget.onSelectionChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 8),
          child: _label,
        ),
        DropdownButtonFormField(
          autofocus: widget.autoFocus,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FocusMultiValidator(
            validators: widget.validators,
            focusNode: focusNode,
          ),
          isExpanded: true,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
          value: currentValue,
          onChanged: _onSelectionChanged,
          items: _dropItens,
          icon: Icon(FeatherIcons.chevronDown),
          hint: Text(
            'Selecione aqui',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: TheoColors.fourteen,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ),
      ],
    );
  }

  Widget get _label => Text(
        widget.label,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: TheoColors.seven,
            ),
      );

  List<DropdownMenuItem<String>> get _dropItens => widget.items
      .map(
        (e) => DropdownMenuItem<String>(
          value: e,
          child: Text(
            e,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(),
          ),
        ),
      )
      .toList();
}
