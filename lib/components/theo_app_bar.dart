import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:theo/components/top_sheet_menu.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/utils/assets_path.dart';

class TheoAppBar extends StatefulWidget {
  TheoAppBar({
    this.onBackPressed,
    required this.navigationStore,
  });

  final Function? onBackPressed;
  final NavigationStore navigationStore;

  @override
  _TheoAppBarState createState() => _TheoAppBarState();
}

class _TheoAppBarState extends State<TheoAppBar> {
  void _onMenuPressed() {
    TopSheetMenu.showTopSheetMenu(context);
  }

  void _onTapProfile() {
    if (widget.navigationStore.currentNamedRoute != Routes.profile) {
      widget.navigationStore.navigator.pushNamed(Routes.profile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        var settings = widget.navigationStore.appBarSettings;
        return Visibility(
          visible: settings.visible,
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _leftAction(context),
              ],
            ),
            actions: [
              if (settings.withProfile) _profile,
              if (settings.withMenu)
                IconButton(
                  iconSize: 35,
                  icon: Icon(
                    Icons.menu,
                    color: TheoColors.primary,
                  ),
                  onPressed: () => _onMenuPressed(),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget get _profile => IconButton(
        icon: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: Image.asset(
              'assets/images/avataaars.jpg',
              width: 30,
              height: 30,
            ),
          ),
        ),
        onPressed: _onTapProfile,
      );

  Widget _backButton(BuildContext context) => Container(
        child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () => widget.onBackPressed?.call(),
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  Icon(
                    FeatherIcons.arrowLeft,
                    color: TheoColors.primary,
                    size: 30,
                  ),
                  Text(
                    'Voltar',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: TheoColors.primary,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            )),
      );

  Widget _leftAction(BuildContext context) =>
      widget.navigationStore.appBarSettings.withBackButton
          ? _backButton(context)
          : Image.asset(AssetsPath.appSymbolPng, fit: BoxFit.cover);
}
