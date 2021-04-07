import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:theo/pages/home_screen/components/body.dart';
import 'package:theo/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBuildAppBar(),
      body: Body(),
      bottomNavigationBar: Container(
        color: TheoColors.eight,
        child: SafeArea(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              icon: 'assets/images/icone-feather-home.svg',
              title: 'Início',
              press: () {},
              isActive: true,
            ),
            NavItem(
              icon: 'assets/images/icone-feather-home.svg',
              title: 'Aprender',
              press: () {},
            ),
            NavItem(
              icon: 'assets/images/icone-feather-home.svg',
              title: 'Descobrir',
              press: () {},
            ),
            NavItem(
              icon: 'assets/images/icone-feather-home.svg',
              title: 'Contar',
              press: () {},
            ),
          ],
        )),
      ),
    );
  }

  AppBar buildBuildAppBar() => buildAppBar();

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/icons/simbolo-app.png', fit: BoxFit.cover)
        ],
      ),
      actions: [
        CircleAvatar(
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
        IconButton(
          iconSize: 35,
          icon: Icon(
            Icons.menu,
            color: TheoColors.primary,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    Key key,
    @required this.icon,
    @required this.title,
    this.isActive = false,
    @required this.press,
  }) : super(key: key);

  final String icon, title;
  final bool isActive;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 65,
      decoration: BoxDecoration(
        border: (isActive
            ? Border(top: BorderSide(width: 3.0, color: TheoColors.primary))
            : Border(top: BorderSide(width: 3.0, color: Colors.transparent))),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SvgPicture.asset(icon),
            SizedBox(
              height: 4,
            ),
            Text(title,
                style: (isActive
                    ? Theme.of(context).textTheme.bodyText1.copyWith(
                        color: TheoColors.primary,
                        fontWeight: FontWeight.normal)
                    : Theme.of(context).textTheme.bodyText1.copyWith(
                        color: TheoColors.nine,
                        fontWeight: FontWeight.normal))),
          ],
        ),
      ),
    );
  }
}
