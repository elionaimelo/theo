import 'package:flutter/material.dart';
import 'package:theo/components/inputs/validation_error_text.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/validators/focus_multi_validator.dart';
import 'package:theo/validators/validator.dart';

class SelectorItem {
  SelectorItem({
    required this.key,
    required this.displayValue,
    this.value,
  });

  final ObjectKey key;
  final String displayValue;
  final dynamic value;
}

class MultiSelectorButtonFormField extends FormField<List<SelectorItem>> {
  MultiSelectorButtonFormField({
    required String label,
    required List<SelectorItem> values,
    required Function(List<SelectorItem>) onSelectedValuesChanged,
    bool uniqueSelect = false,
    bool bold = false,
    Color primaryColor = TheoColors.primary,
    List<Validator> validators = const [],
    required FocusNode focusNode,
  }) : super(
          initialValue: [],
          validator: FocusMultiValidator(
            validators: validators,
            focusNode: focusNode,
          ),
          builder: (state) {
            return _MultiSelectorButtonView(
              state,
              uniqueSelect: uniqueSelect,
              bold: bold,
              primaryColor: primaryColor,
              label: label,
              onSelectedValuesChanged: onSelectedValuesChanged,
              values: values,
              focusNode: focusNode,
            );
          },
        );
}

class _MultiSelectorButtonView extends StatefulWidget {
  _MultiSelectorButtonView(
    this.formState, {
    required this.label,
    required this.values,
    required this.onSelectedValuesChanged,
    this.uniqueSelect = false,
    this.bold = false,
    this.primaryColor = TheoColors.primary,
    required this.focusNode,
  });

  @override
  _MultiSelectorButtonInputState createState() =>
      _MultiSelectorButtonInputState();

  final String label;
  final List<SelectorItem> values;
  final Function(List<SelectorItem>) onSelectedValuesChanged;
  final bool uniqueSelect;
  final bool bold;
  final Color primaryColor;
  final FormFieldState<List<SelectorItem>> formState;
  final FocusNode focusNode;
}

class _MultiSelectorButtonInputState extends State<_MultiSelectorButtonView> {
  @override
  void initState() {
    super.initState();
  }

  List<SelectorItem> get selectedItems => widget.formState.value ?? [];

  void _onButtonItemTap(SelectorItem item) {
    if (widget.uniqueSelect) {
      if (_selectedItemsContains(item)) {
        _invokeStateChangeEvent([]);
      } else {
        _invokeStateChangeEvent([item]);
      }

      return;
    }

    var items = <SelectorItem>[];

    if (_selectedItemsContains(item)) {
      items =
          selectedItems.where((element) => element.key != item.key).toList();
    } else {
      items = [...selectedItems, item];
    }

    _invokeStateChangeEvent(items);
  }

  bool _selectedItemsContains(SelectorItem item) =>
      selectedItems.any((element) => element.key == item.key);

  void _invokeStateChangeEvent(List<SelectorItem> items) {
    widget.formState.didChange(items);
    widget.onSelectedValuesChanged(items);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.focusNode,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label,
            ValidationErrorText(
              errorText: widget.formState.errorText,
              hasError: widget.formState.hasError,
            ),
            Container(
              width: double.infinity,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.spaceBetween,
                spacing: _wrapMargin,
                runSpacing: 8,
                children: _list,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> get _list => widget.values
      .map(
        (e) => _buttonItem(item: e),
      )
      .toList();

  Widget _buttonItem({required SelectorItem item}) {
    var selected = _selectedItemsContains(item);

    return LayoutBuilder(
      builder: (_, constraints) {
        return Container(
          width: (constraints.maxWidth / 2) - _wrapMargin,
          decoration: BoxDecoration(
            border: Border.all(color: widget.primaryColor, width: _borderWidth),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            color: _backgroundColor(selected),
          ),
          child: InkWell(
            onTap: () => _onButtonItemTap(item),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: Text(
                  item.displayValue,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 15,
                        fontWeight: _fontWeight,
                        color: _textColor(selected),
                      ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

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

  double get _borderWidth => widget.bold ? 2 : 1;

  Color _textColor(bool selected) =>
      selected ? TheoColors.secondary : widget.primaryColor;

  double get _wrapMargin => 5;

  Color _backgroundColor(bool selected) =>
      selected ? widget.primaryColor : TheoColors.secondary;

  FontWeight get _fontWeight =>
      widget.bold ? FontWeight.w700 : FontWeight.normal;
}
