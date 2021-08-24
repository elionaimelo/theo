import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/story_progress.dart';

import 'package:theo/pages/concluded_screen/concluded_screen_controller.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/utils/assets_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConcludedScreen extends StatefulWidget {
  const ConcludedScreen({Key? key, required this.controller}) : super(key: key);

  @override
  _ConcludedScreenState createState() => _ConcludedScreenState();

  final ConcludedScreenController controller;
}

class _ConcludedScreenState extends State<ConcludedScreen> {
  AppLocalizations get _locale => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TheoColors.secondary,
      padding: TheoMetrics.paddingScreenWithTopMargin,
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(AssetsPath.concludedPng),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    widget.controller.title,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: TheoColors.primary,
                        ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    widget.controller.message,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: TheoColors.seven,
                        ),
                  ),
                ),
                if (widget.controller.withProgress)
                  Container(
                    margin: EdgeInsets.only(top: 40, left: 30, right: 30),
                    child: StoryProgress(
                      progress: widget.controller.progress!,
                      total: widget.controller.total!,
                      hasTitle: true,
                      hasThunder: false,
                    ),
                  ),
                if (widget.controller.withAvaliations)
                  Container(
                    margin: EdgeInsets.only(top: 75),
                    child: _avaliations,
                  ),
              ],
            ),
          ),
          BottomButton(
            backgroundColor: TheoColors.primary,
            primaryColor: TheoColors.secondary,
            text: _locale.nextButton,
            onPressed: widget.controller.onNextButtonTap,
            icon: FeatherIcons.arrowRight,
          )
        ],
      ),
    );
  }

  Widget get _avaliations => Container(
        child: Column(
          children: [
            Divider(
              thickness: 1,
              height: 2,
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
            ),
            Text(
              _locale.concludedReview,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: TheoColors.twentyTwo,
                  ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _avaliationButton(
                  SvgPicture.asset(
                    AssetsPath.unhappySvg,
                    color: TheoColors.twentyThree,
                  ),
                  _locale.review1,
                ),
                _avaliationButton(
                  Icon(
                    FeatherIcons.frown,
                    color: TheoColors.twentyThree,
                    size: 30,
                  ),
                  _locale.review2,
                ),
                _avaliationButton(
                  Icon(
                    FeatherIcons.frown,
                    color: TheoColors.twentyThree,
                    size: 30,
                  ),
                  _locale.review3,
                ),
                _avaliationButton(
                  Icon(
                    FeatherIcons.frown,
                    color: TheoColors.twentyThree,
                    size: 30,
                  ),
                  _locale.review4,
                ),
                _avaliationButton(
                  SvgPicture.asset(
                    AssetsPath.happySvg,
                    color: TheoColors.twentyThree,
                  ),
                  _locale.review5,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
            ),
            Divider(
              thickness: 1,
              height: 2,
            ),
          ],
        ),
      );

  Widget _avaliationButton(Widget icon, String text) => Container(
        width: 60,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 1,
            color: TheoColors.twelve,
          ),
        ),
        child: InkWell(
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Text(
                text,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: TheoColors.twentyTwo,
                    ),
              )
            ],
          ),
        ),
      );
}
