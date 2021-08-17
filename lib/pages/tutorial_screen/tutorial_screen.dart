import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/text_icon_button.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/pages/tutorial_screen/tutorial_screen_controller.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/utils/assets_path.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _TutorialScreenState createState() => _TutorialScreenState();

  final TutorialScreenController controller;

  static Future<bool> isFirstShow() async {
    const key = 'isFirstShow';

    var prefs = await SharedPreferences.getInstance();

    var isFirst = prefs.getBool(key) ?? true;

    if (isFirst) {
      await prefs.setBool(key, false);
    }

    return isFirst;
  }
}

class _TutorialScreenState extends State<TutorialScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  double currentTabIndex = 0;
  AppLocalizations get _locale => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 6);

    _tabController.addListener(_tabEventListener);
  }

  void _tabEventListener() {
    setState(() {
      currentTabIndex = _tabController.index.toDouble();
    });
  }

  void _defaultSkipButtonTap() {
    Navigator.of(context).pushReplacementNamed(Routes.home);
  }

  void _nextButtonTap() {
    if (_isLastIndex) {
      if (widget.controller.onSkipButtonTap != null) {
        widget.controller.onSkipButtonTap!();
      } else {
        _defaultSkipButtonTap();
      }
    } else {
      _tabController.animateTo(_tabController.index + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TheoMetrics.paddingScreenWithTopMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(bottom: 30),
            child: _jumpButton,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabs,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            alignment: Alignment.center,
            child: DotsIndicator(
              dotsCount: _tabController.length,
              position: currentTabIndex,
              decorator: DotsDecorator(
                activeColor: TheoColors.eleven,
                color: TheoColors.thirtyThree,
              ),
            ),
          ),
          BottomButton(
            text: _bottomButtonText,
            icon: _bottomButtonIcon,
            onPressed: _nextButtonTap,
          )
        ],
      ),
    );
  }

  String get _bottomButtonText =>
      _isLastIndex ? _locale.concluded : _locale.nextTutorial;

  IconData? get _bottomButtonIcon =>
      _isLastIndex ? null : FeatherIcons.arrowRight;

  bool get _isLastIndex => _tabController.index + 1 == _tabController.length;

  Widget get _jumpButton => !_isLastIndex
      ? TextIconButton(
          onTap: widget.controller.onSkipButtonTap ?? _defaultSkipButtonTap,
          foregroundColor: TheoColors.primary,
          textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                color: TheoColors.primary,
              ),
          text: _locale.jumpTutorial,
          direction: TextDirection.rtl,
          icon: Icon(
            FeatherIcons.chevronRight,
            color: TheoColors.primary,
            size: 35,
          ),
        )
      : Container(
          height: 40,
        );

  List<Widget> get _tabs => [
        Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _locale.tutorial1Title,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: TheoColors.primary,
                    ),
              ),
            ),
            _image(AssetsPath.tutorial1Png),
            Text(
              _locale.tutorial1Description,
              style: _textStyle,
            )
          ],
        ),
        Column(
          children: [
            _image(AssetsPath.tutorial2Png),
            Text(
              _locale.tutorial2Description,
              style: _textStyle,
            )
          ],
        ),
        Column(
          children: [
            _image(AssetsPath.tutorial3Png),
            Text(
              _locale.tutorial3Description,
              style: _textStyle,
            )
          ],
        ),
        Column(
          children: [
            _image(AssetsPath.tutorial4Png),
            Text(
              _locale.tutorial4Description,
              style: _textStyle,
            )
          ],
        ),
        Column(
          children: [
            _image(AssetsPath.tutorial5Png),
            Text(
              _locale.tutorial5Description,
              style: _textStyle,
            )
          ],
        ),
        Column(
          children: [
            _image(AssetsPath.tutorial6Png),
            Text(
              _locale.tutorial6Description,
              style: _textStyle,
            )
          ],
        ),
      ];

  TextStyle get _textStyle => Theme.of(context).textTheme.bodyText1!.copyWith(
        fontSize: 16,
        color: TheoColors.seven,
        fontWeight: FontWeight.w600,
      );

  Widget _image(String assetPath) => Expanded(
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Image(
            fit: BoxFit.fill,
            image: AssetImage(assetPath),
          ),
        ),
      );
}
