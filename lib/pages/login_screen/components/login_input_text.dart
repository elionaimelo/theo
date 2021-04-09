import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constant.dart';

class LoginInputText extends StatelessWidget {
  const LoginInputText({
    this.hintText = '',
    this.label = '',
    @required this.onTextChanged,
  });

  final String hintText;
  final String label;
  final Function(String) onTextChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: Text(
              label,
              style: GoogleFonts.muli(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: kprimaryColor,
              ),
            ),
          ),
          TextField(
            onChanged: onTextChanged,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }
}
