import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:theo/pages/discover_screen/discorver_screen.dart';

import 'package:theo/pages/home_screen/components/body.dart';
import 'package:theo/pages/home_screen/home_screen_controller.dart';
import 'package:theo/pages/learning_screen/learning_screen.dart';
import 'package:theo/pages/tell_screen/tell_screen.dart';
import 'package:theo/states/navigation_store.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.controller}) : super(key: key);

  final HomeScreenController controller;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      vsync: this,
      length: _tabs.length,
      initialIndex: widget.controller.currentPageIndex.index,
    );

    tabController.addListener(() {
      widget.controller.onTabControllerEvent(tabController);
    });

    reaction((_) => widget.controller.currentPageIndex, (_) {
      tabController.animateTo(widget.controller.currentPageIndex.index);
    });
  }

  Future<bool> _onBackPressed() async {
    if (widget.controller.currentPageIndex != TabPagesIndexes.HOME) {
      widget.controller.setCurrentPageIndex(TabPagesIndexes.HOME);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: TabBarView(
          controller: tabController,
          children: _tabs,
        ),
      ),
    );
  }

  List<Widget> get _tabs {
    return [
      Body(),
      LearningScreen(),
      DiscoverScreen(),
      TellScreen(),
    ];
  }
}
