import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theo/components/bottom_button/bottom_button.dart';
import 'package:theo/constant.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar,
      body: _body,
    );
  }

  Widget get _body => Container(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 71, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _text,
            _inputText(
                hintText: 'Escreva seu email aqui', label: 'Endereço de Email'),
            BottomButton(
              text: 'Continuar',
              onPressed: () {},
            )
          ],
        ),
      );

  Widget _inputText({String hintText = '', String label = ''}) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: hintText,
              ),
            ),
          ],
        ),
      );

  Widget get _text => Text(
        'Bem-vindo de volta!',
        style: GoogleFonts.muli(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: kthirdColor,
        ),
      );

  Widget get _backButton => Container(
        margin: EdgeInsets.only(left: 5),
        child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: _onBackPressed,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.arrow_back,
                color: kprimaryColor,
                size: 30,
              ),
            )),
      );

  AppBar get _appBar => AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            _backButton,
            Text(
              'Voltar',
              style: GoogleFonts.muli(
                fontWeight: FontWeight.w600,
                color: kprimaryColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
        elevation: 0,
      );
}
