import 'package:flutter/material.dart';
import 'package:theo/components/close_top_bar_button.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

class QuizStoryScreen extends StatefulWidget {
  @override
  _QuizStoryScreenState createState() => _QuizStoryScreenState();
}

class _QuizStoryScreenState extends State<QuizStoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TheoMetrics.paddingScreen.copyWith(
        top: AppBar().preferredSize.height,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CloseTopBarButton(
            foregroundColor: TheoColors.primary,
          ),
        ],
      ),
    );
  }
}
