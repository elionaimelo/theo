import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/adult_content_tag.dart';
import 'package:theo/components/text_icon_button.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    Key? key,
    required this.text,
    required this.author,
    required this.adultContent,
  }) : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();

  final String text;
  final String author;
  final bool adultContent;
}

class _ExpandableTextState extends State<ExpandableText> {
  bool expanded = false;

  void _onTapButton() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
          color: TheoColors.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: TheoMetrics.paddingScreen.copyWith(top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _text,
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            _author,
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            _adultContentTag,
            _button,
          ],
        ),
      ),
    );
  }

  Widget get _text => Text(
        widget.text,
        maxLines: expanded ? null : 6,
        overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
      );

  Widget get _author =>
      expanded ? Text('Autoria: ' + widget.author) : Container();

  Widget get _adultContentTag => expanded ? AdultContentTag() : Container();

  Widget get _button => Container(
        alignment: Alignment.centerRight,
        child: TextIconButton(
          text: _buttonText,
          onTap: _onTapButton,
          direction: TextDirection.rtl,
          textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 14,
                color: TheoColors.seven,
                fontWeight: FontWeight.w600,
              ),
          icon: Icon(
            _buttonIcon,
            color: TheoColors.seven,
          ),
        ),
      );

  String get _buttonText => !expanded ? 'Visualizar mais' : 'Visualizar menos';

  IconData get _buttonIcon => expanded ? FeatherIcons.minus : FeatherIcons.plus;
}
