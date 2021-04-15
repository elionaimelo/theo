import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/styles/colors.dart';

class TheoAppBar extends StatelessWidget {
  TheoAppBar({
    this.withBackButton = false,
    this.withProfile = false,
    this.withMenu = false,
    this.onBackPressed,
  });

  final bool withBackButton;
  final bool withProfile;
  final bool withMenu;
  final Function onBackPressed;

  Widget _backButton(BuildContext context) => Container(
        child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () => onBackPressed?.call(),
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
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w600,
                          color: TheoColors.primary,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            )),
      );

  Widget _leftAction(BuildContext context) => withBackButton
      ? _backButton(context)
      : Image.asset('assets/icons/simbolo-app.png', fit: BoxFit.cover);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
        if (withProfile)
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
        if (withMenu)
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
