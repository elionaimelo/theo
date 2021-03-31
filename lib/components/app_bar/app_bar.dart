import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theo/constant.dart';

class TheoAppBar extends StatelessWidget {
  void _onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        'Voltar',
        style: GoogleFonts.muli(
          fontWeight: FontWeight.w600,
          color: kprimaryColor,
          fontSize: 16,
        ),
      ),
      leadingWidth: 30,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: kprimaryColor,
          size: 30,
        ),
        onPressed: () => _onBackPressed(context),
      ),
      elevation: 0,
    );
  }
}
