import 'package:flutter/material.dart';
import 'package:theo/components/titleText.dart';

class NewTellScreen extends StatefulWidget {
  @override
  _NewTellScreenState createState() => _NewTellScreenState();
}

class _NewTellScreenState extends State<NewTellScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TitleText(
            title: 'Josadasdasdasdgosasdd',
          ),
        ],
      ),
    );
  }
}
