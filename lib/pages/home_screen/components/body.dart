import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:theo/components/error_alert_dialog.dart';
import 'package:theo/components/result_status/loading_status.dart';
import 'package:theo/components/subTitleText.dart';

import 'package:theo/components/title_text.dart';
import 'package:theo/pages/home_screen/components/categoryCard.dart';
import 'package:theo/pages/home_screen/home_screen_controller.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/types/enums.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.controller}) : super(key: key);

  final HomeScreenController controller;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void _learnButtonTap() {
    GetIt.I
        .get<NavigationStore>()
        .setCurrentPageIndex(TabPagesIndexes.LEARNING);
  }

  void _discoverButtonTap() {
    GetIt.I
        .get<NavigationStore>()
        .setCurrentPageIndex(TabPagesIndexes.DISCOVER);
  }

  void _tellButtonTap() {
    GetIt.I.get<NavigationStore>().setCurrentPageIndex(TabPagesIndexes.TELL);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (widget.controller.eResultStatus == EResultStatus.LOADING) {
        return LoadingStatus();
      } else if (widget.controller.eResultStatus ==
          EResultStatus.REQUEST_ERROR) {
        return ErrorAlertDialog(content: widget.controller.errorMessage!);
      }

      return _content;
    });
  }

  Widget get _content => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child: TitleText(title: 'O que você quer explorar hoje?'),
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
              ),
              _button(
                context: context,
                text: 'Aprender a contar',
                icon: 'assets/icons/icone-como-contar.svg',
                onTap: _learnButtonTap,
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
              ),
              _button(
                context: context,
                text: 'Descobrir histórias',
                icon: 'assets/icons/icone-descobrir-historias.svg',
                onTap: _discoverButtonTap,
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
              ),
              _button(
                  context: context,
                  text: 'Contar uma história',
                  icon: 'assets/icons/icone-contar-historia.svg',
                  onTap: _tellButtonTap,
                  subtitle: 'Compartilhe suas histórias'),
              Container(
                margin: EdgeInsets.only(top: 37),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TitleText(title: 'Categorias'),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SubTitleText(
                            subTitle: 'O que você não pode perder',
                          ),
                        )
                      ],
                    ),
                    SvgPicture.asset(
                        'assets/icons/icone-feather-arrow-right.svg'),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.controller.storyCategories
                      .map(
                        (e) => CategoryCard(
                          storyCategory: e,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _button({
    required BuildContext context,
    required String text,
    required String icon,
    String subtitle = '',
    required Function() onTap,
  }) =>
      InkWell(
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 6,
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 17, horizontal: 30),
            child: Row(
              children: [
                SvgPicture.asset(icon),
                Container(
                  margin: EdgeInsets.only(left: 30),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 18,
                            color: TheoColors.six,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    if (subtitle != '')
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 15,
                              color: TheoColors.seven,
                            ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
