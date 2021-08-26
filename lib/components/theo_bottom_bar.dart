import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:theo/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TheoBottomBar extends StatefulWidget {
  TheoBottomBar({required this.navigationStore});

  @override
  _TheoBottomBarState createState() => _TheoBottomBarState();

  final NavigationStore navigationStore;
}

class _TheoBottomBarState extends State<TheoBottomBar> {
  AppLocalizations get _locale => AppLocalizations.of(context)!;

  void _onBottomBarItemTap(int index) {
    widget.navigationStore.setCurrentPageIndex(TabPagesIndexes.values[index]);

    if (widget.navigationStore.currentNamedRoute != Routes.home) {
      widget.navigationStore.navigator
          .popUntil((route) => route.settings.name == Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Observer(builder: (_) {
        final pageIndex = widget.navigationStore.currentTabPageIndex;

        final homeIcon = pageIndex == TabPagesIndexes.HOME
            ? 'assets/icons/icon-feather-home-active.svg'
            : 'assets/icons/icone-feather-home.svg';

        final learningIcon = pageIndex == TabPagesIndexes.LEARNING
            ? 'assets/icons/icon-aprender-active.svg'
            : 'assets/icons/icon-aprender.svg';

        final discoverIcon = pageIndex == TabPagesIndexes.DISCOVER
            ? 'assets/icons/icon-descobrir-active.svg'
            : 'assets/icons/icon-descobrir.svg';

        final tellIcon = pageIndex == TabPagesIndexes.TELL
            ? 'assets/icons/icon-contar-active.svg'
            : 'assets/icons/icon-contar.svg';

        return Visibility(
          visible: widget.navigationStore.withBottomNavigationBar,
          child: Observer(
            builder: (_) => BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: widget.navigationStore.currentTabPageIndex.index,
              selectedFontSize: 15.0,
              selectedItemColor: TheoColors.primary,
              unselectedFontSize: 15.0,
              onTap: _onBottomBarItemTap,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    homeIcon,
                    height: 27,
                  ),
                  label: _locale.home,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    learningIcon,
                    height: 27,
                  ),
                  label: _locale.learn,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    discoverIcon,
                    height: 27,
                  ),
                  label: _locale.discover,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    tellIcon,
                    height: 27,
                  ),
                  label: _locale.tell,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
