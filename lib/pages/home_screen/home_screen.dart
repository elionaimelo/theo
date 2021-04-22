import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:theo/components/theoAppBar.dart';

import 'package:theo/pages/home_screen/components/body.dart';
import 'package:theo/pages/home_screen/home_screen_controller.dart';
import 'package:theo/pages/learning_screen/learningScreen.dart';
import 'package:theo/pages/tell_game_screen/tell_game_screen.dart';
import 'package:theo/pages/tell_screen/tellScreen.dart';
import 'package:theo/states/navigation.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.controller}) : super(key: key);

  final HomeScreenController controller;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      vsync: this,
      length: _tabs.length,
      initialIndex: widget.controller.currentPageIndex.index,
    );

    reaction((_) => widget.controller.currentPageIndex, (_) {
      _tabController.animateTo(widget.controller.currentPageIndex.index);
    });

    // Handle the manually tab change by the user
    _tabController.addListener(() {
      if (_tabController.index != widget.controller.currentPageIndex.index) {
        widget.controller
            .setCurrentPageIndex(TabPagesIndexes.values[_tabController.index]);
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    GetIt.I.get<NavigationStore>().withBottomNavigationBar = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(46), child: _appBar),
      body: TabBarView(
        controller: _tabController,
        children: _tabs,
      ),
    );
  }

  Widget get _appBar => Observer(
        builder: (_) => TheoAppBar(
          withBackButton:
              widget.controller.currentPageIndex != TabPagesIndexes.HOME,
          withMenu: true,
          withProfile: true,
          onBackPressed: _onBackPressed,
        ),
      );

  void _onBackPressed() {
    if (widget.controller.currentPageIndex != TabPagesIndexes.HOME) {
      setState(() {
        widget.controller.setCurrentPageIndex(TabPagesIndexes.HOME);
      });
    }
  }

  List<Widget> get _tabs {
    return [
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
  }
}
