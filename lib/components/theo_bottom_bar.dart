import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/states/navigation_store.dart';

class TheoBottomBar extends StatefulWidget {
  TheoBottomBar({required this.navigationStore});

  @override
  _TheoBottomBarState createState() => _TheoBottomBarState();

  final NavigationStore navigationStore;
}

class _TheoBottomBarState extends State<TheoBottomBar> {
  void _onBottomBarItemTap(int index) {
    widget.navigationStore.setCurrentPageIndex(TabPagesIndexes.values[index]);

    if (widget.navigationStore.currentNamedRoute != Routes.home) {
      widget.navigationStore.navigator.popUntil((route) => route.isFirst);
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
              unselectedFontSize: 15.0,
              onTap: _onBottomBarItemTap,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    homeIcon,
                    height: 27,
                  ),
                  label: 'Início',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    learningIcon,
                    height: 27,
                  ),
                  label: 'Aprender',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    discoverIcon,
                    height: 27,
                  ),
                  label: 'Descobrir',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    tellIcon,
                    height: 27,
                  ),
                  label: 'Contar',
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
