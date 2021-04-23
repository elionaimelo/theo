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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              title: 'Video',
            ),
          ],
        ),
      ),
    );
  }
}
