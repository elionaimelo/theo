import 'package:flutter/material.dart';
import 'package:theo/components/titleText.dart';

class TellGameScreen extends StatefulWidget {
  @override
  _TellGameScreenState createState() => _TellGameScreenState();
}

class _TellGameScreenState extends State<TellGameScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TitleText(
            title: 'Jogo',
          ),
        ],
      ),
    );
  }
}
