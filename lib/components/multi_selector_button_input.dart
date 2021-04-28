import 'package:flutter/material.dart';
import 'package:theo/styles/colors.dart';

class SelectorItem {
  SelectorItem({
    required this.displayValue,
    this.value,
  });

  final String displayValue;
  final dynamic value;
}

class MultiSelectorButtonInput extends StatefulWidget {
  MultiSelectorButtonInput({
    required this.label,
    required this.values,
    required this.onSelectedValuesChanged,
    this.uniqueSelect = false,
    this.bold = false,
  });

  @override
  _MultiSelectorButtonInputState createState() =>
      _MultiSelectorButtonInputState();

  final String label;
  final List<SelectorItem> values;
  final Function(List<SelectorItem>) onSelectedValuesChanged;
  final bool uniqueSelect;
  final bool bold;
}

class _MultiSelectorButtonInputState extends State<MultiSelectorButtonInput> {
  List<SelectorItem> selectedItems = [];

  @override
  void initState() {
    super.initState();

    selectedItems = widget.values;
  }

  void _onButtonItemTap(SelectorItem item) {
    if (widget.uniqueSelect) {
      setState(() {
        selectedItems = [item];
      });
      return;
    }

    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });

    widget.onSelectedValuesChanged(selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return FormField(builder: (_) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label,
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
      );
    });
  }

  List<Widget> get _list => widget.values
      .map(
        (e) => _buttonItem(item: e),
      )
      .toList();

  Widget _buttonItem({required SelectorItem item}) {
    var selected = selectedItems.contains(item);

    return LayoutBuilder(
      builder: (_, constraints) {
        return Container(
          width: (constraints.maxWidth / 2) - _wrapMargin,
          decoration: BoxDecoration(
            border: Border.all(color: TheoColors.primary, width: _borderWidth),
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
      selected ? TheoColors.secondary : TheoColors.primary;

  double get _wrapMargin => 5;

  Color _backgroundColor(bool selected) =>
      selected ? TheoColors.primary : TheoColors.secondary;

  FontWeight get _fontWeight =>
      widget.bold ? FontWeight.w700 : FontWeight.normal;
}
