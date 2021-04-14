import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theo/styles/colors.dart';

class LoginEmailTag extends StatelessWidget {
  LoginEmailTag({
    this.email = '',
  });
  final String email;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 35,
          width: 35,
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
              email.length > 2 ? email.substring(0, 2).toUpperCase() : email,
              style: GoogleFonts.muli(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 9),
        ),
        Text(
          email,
          style: GoogleFonts.muli(
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
