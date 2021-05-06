import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:theo/components/text_icon_button.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/utils/assets_path.dart';

class TopSheetMenu extends StatefulWidget {
  const TopSheetMenu({Key? key, required this.navigationStore})
      : super(key: key);

  @override
  _TopSheetMenuState createState() => _TopSheetMenuState();

  final NavigationStore navigationStore;

  static Future<void> showTopSheetMenu(BuildContext context) async {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 300),
      barrierLabel: MaterialLocalizations.of(context).dialogLabel,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, _, __) {
        return TopSheetMenu(
          navigationStore: GetIt.I.get(),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ).drive(Tween<Offset>(
            begin: Offset(0, -1.0),
            end: Offset.zero,
          )),
          child: child,
        );
      },
    );
  }
}

class _TopSheetMenuState extends State<TopSheetMenu> {
  void navigateToRoute(String route) {
    Navigator.of(context).pop();

    print(widget.navigationStore.currentNamedRoute);

    if ([Routes.about, Routes.contact]
        .contains(widget.navigationStore.currentNamedRoute)) {
      widget.navigationStore.navigator.pushReplacementNamed(route);
    } else {
      widget.navigationStore.navigator.pushNamed(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: TheoColors.primary,
        child: SafeArea(
          child: Column(
            children: [
              _topMenu,
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: _menu,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get _appButton => Container(
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Image.asset(
            AssetsPath.appSymbolPng,
            width: 40,
            height: 40,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      );

  Widget get _topMenu => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _appButton,
            TextIconButton(
              foregroundColor: TheoColors.secondary,
              text: 'Fechar',
              direction: TextDirection.rtl,
              onTap: () => Navigator.of(context).pop(),
              icon: Icon(
                FeatherIcons.x,
                size: 30,
                color: TheoColors.secondary,
              ),
            ),
          ],
        ),
      );

  Widget get _menu => Container(
        margin: EdgeInsets.only(top: 60),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextIconButton(
              foregroundColor: TheoColors.secondary,
              text: 'Sobre o Theo',
              onTap: () => navigateToRoute(Routes.about),
              textStyle: _buttonTextStyle,
            ),
            Container(
              margin: EdgeInsets.only(top: 35),
            ),
            TextIconButton(
              foregroundColor: TheoColors.secondary,
              text: 'Tutorial de uso',
              onTap: () {},
              textStyle: _buttonTextStyle,
            ),
            Container(
              margin: EdgeInsets.only(top: 35),
            ),
            TextIconButton(
              foregroundColor: TheoColors.secondary,
              text: 'Contato',
              onTap: () => navigateToRoute(Routes.contact),
              textStyle: _buttonTextStyle,
            ),
            Container(
              margin: EdgeInsets.only(top: 35),
            ),
            TextIconButton(
              foregroundColor: TheoColors.secondary,
              text: 'Idioma',
              onTap: () {},
              textStyle: _buttonTextStyle,
            ),
            Container(
              margin: EdgeInsets.only(top: 17),
            ),
            TextIconButton(
              foregroundColor: TheoColors.secondary,
              text: 'Português',
              onTap: () {},
              direction: TextDirection.rtl,
              icon: Container(
                margin: EdgeInsets.only(left: 10),
                child: SvgPicture.asset(
                  AssetsPath.brSvg,
                  height: 28,
                ),
              ),
              textStyle: _langButtonTextStyle,
            ),
            Container(
              margin: EdgeInsets.only(top: 14),
            ),
            TextIconButton(
              foregroundColor: TheoColors.secondary,
              text: 'English',
              onTap: () {},
              direction: TextDirection.rtl,
              icon: Container(
                margin: EdgeInsets.only(left: 10),
                child: SvgPicture.asset(
                  AssetsPath.enSvg,
                  height: 28,
                ),
              ),
              textStyle: _langButtonTextStyle,
            ),
            Container(
              margin: EdgeInsets.only(top: 14),
            ),
            TextIconButton(
              foregroundColor: TheoColors.secondary,
              text: 'Español',
              onTap: () {},
              direction: TextDirection.rtl,
              icon: Container(
                margin: EdgeInsets.only(left: 10),
                child: SvgPicture.asset(
                  AssetsPath.espSvg,
                  height: 28,
                ),
              ),
              textStyle: _langButtonTextStyle,
            ),
          ],
        ),
      );

  TextStyle get _buttonTextStyle =>
      Theme.of(context).textTheme.bodyText1!.copyWith(
            color: TheoColors.secondary,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          );

  TextStyle get _langButtonTextStyle =>
      Theme.of(context).textTheme.bodyText1!.copyWith(
            color: TheoColors.secondary,
            fontSize: 16,
          );
}
