import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theo/styles/colors.dart';

class ProfileBar extends StatelessWidget {
  const ProfileBar({
    Key? key,
    this.avatarImage,
    this.name,
    this.avatarSize = 35,
  }) : super(key: key);

  final String? avatarImage;
  final String? name;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 8),
            child: _avatar,
          ),
          if (name != null)
            Text(
              name!,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                    color: TheoColors.seven,
                    fontWeight: FontWeight.w700,
                  ),
            ),
        ],
      ),
    );
  }

  Widget get _noImage => Container(
        height: avatarSize,
        width: avatarSize,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              TheoColors.forth,
              TheoColors.primary,
            ],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.all(5),
        child: Align(
          child: Text(
            name != null ? _reducedName : '',
            style: GoogleFonts.muli(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      );

  Widget get _profileImage => CircleAvatar(
        radius: avatarSize / 2,
        backgroundColor: Colors.transparent,
        child: ClipOval(
          child: Image.asset(
            avatarImage!,
          ),
        ),
      );

  Widget get _avatar => avatarImage != null ? _profileImage : _noImage;

  String get _reducedName =>
      name!.length > 2 ? name!.substring(0, 2).toUpperCase() : name!;
}
