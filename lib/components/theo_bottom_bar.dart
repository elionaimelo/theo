import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/states/navigation.dart';

class TheoBottomBar extends StatefulWidget {
  TheoBottomBar({required this.navigationStore, this.visible = true});

  @override
  _TheoBottomBarState createState() => _TheoBottomBarState();

  final NavigationStore navigationStore;
  final bool visible;
}

class _TheoBottomBarState extends State<TheoBottomBar> {
  void _onBottomBarItemTap(int index) {
    widget.navigationStore.setCurrentPageIndex(TabPagesIndexes.values[index]);

    if (ModalRoute.of(context)!.settings.name != Routes.home) {
      Navigator.pushReplacementNamed(context, Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
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

        return Offstage(
          offstage: !widget.visible,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: pageIndex.index,
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
        );
      },
    );
  }
}