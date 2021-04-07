import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theo/components/story_progress/story_progress.dart';

class LearningScreen extends StatefulWidget {
  @override
  _LearningScreenState createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 16),
                child: _title,
              ),
              StoryProgress(
                progress: 4,
                total: 5,
              ),
              // Expanded(child: _list),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _list => ListView.builder(
        itemBuilder: (_, int index) => Container(),
      );

  Widget get _title => Text(
        'Como contar?',
        style: GoogleFonts.muli(fontSize: 20),
      );
}
