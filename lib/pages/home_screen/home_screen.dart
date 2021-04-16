import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theo/components/theoAppBar.dart';

import 'package:theo/pages/home_screen/components/body.dart';
import 'package:theo/pages/learning_screen/learningScreen.dart';
import 'package:theo/pages/tell_game_screen/tellGameScreen.dart';
import 'package:theo/pages/tell_screen/tellScreen.dart';
import 'package:theo/styles/colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum HomePagesIndex {
  HOME,
  LEARNING,
  DISCOVER,
  TELL,
  TELL_GAME,
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(46),
        child: TheoAppBar(
          withBackButton: pageIndex != 0,
          withMenu: true,
          withProfile: true,
          onBackPressed: _onBackPressed,
        ),
      ),
      body: getBody(),
      bottomNavigationBar: bottomNavigator(),
    );
  }

  void _onBackPressed() {
    print(pageIndex);
    if (pageIndex != HomePagesIndex.HOME.index) {
      setState(() {
        pageIndex = HomePagesIndex.HOME.index;
      });
    }
  }

  Widget getBody() {
    var pages = [
      Body(),
      LearningScreen(),
      Center(
        child: Text(
          'Descobrir',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      TellScreen(),
      TellGameScreen()
    ];
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget bottomNavigator() {
    var bottomItens = [
      pageIndex == 0
          ? 'assets/icons/icon-feather-home-active.svg'
          : 'assets/icons/icone-feather-home.svg',
      pageIndex == 1
          ? 'assets/icons/icon-aprender-active.svg'
          : 'assets/icons/icon-aprender.svg',
      pageIndex == 2
          ? 'assets/icons/icon-descobrir-active.svg'
          : 'assets/icons/icon-descobrir.svg',
      pageIndex == 3
          ? 'assets/icons/icon-contar-active.svg'
          : 'assets/icons/icon-contar.svg',
    ];
    var title = ['Início', 'Aprender', 'Descobrir', 'Contar'];

    return Container(
      width: double.infinity,
      height: 75,
      decoration: BoxDecoration(color: TheoColors.eight),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomItens.length, (index) {
            return Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border(
                top: pageIndex == index
                    ? BorderSide(width: 3.0, color: TheoColors.primary)
                    : BorderSide(width: 3.0, color: Colors.transparent),
              )),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: InkWell(
                      onTap: () {
                        selectedTab(index);
                      },
                      child: SvgPicture.asset(
                        bottomItens[index],
                        height: 27,
                      ),
                    ),
                  ),
                  Text(
                    title[index],
                    style: pageIndex == index
                        ? TextStyle(color: TheoColors.primary)
                        : TextStyle(color: TheoColors.nine),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  void selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
