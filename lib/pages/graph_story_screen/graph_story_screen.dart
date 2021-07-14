import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/close_top_bar_button.dart';
import 'package:theo/pages/graph_story_screen/graph_story_screen_controller.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/utils/assets_path.dart';

class GraphStoryScreen extends StatefulWidget {
  GraphStoryScreen({Key? key, required this.controller}) : super(key: key);

  @override
  _GraphStoryScreenState createState() => _GraphStoryScreenState();

  final GraphStoryScreenController controller;
}

class _GraphStoryScreenState extends State<GraphStoryScreen> {
  void _onButtonTap() {
    widget.controller.storyStore.finishStory(widget.controller.story.id!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TheoMetrics.paddingScreenWithTopMargin,
      child: ListView(
        children: [
          CloseTopBarButton(foregroundColor: TheoColors.primary),
          Container(
            margin: EdgeInsets.only(top: 20),
          ),
          Card(
            elevation: TheoMetrics.cardElevation,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Container(
              color: TheoColors.thirtyTwo,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Lorem dolor sit amet, consetetur sadipscing elitr',
                style: GoogleFonts.openSans(
                  fontSize: 19,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                  color: TheoColors.primary,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
          ),
          Image(
            image: AssetImage(AssetsPath.graphJpeg),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
          ),
          BottomButton(
            backgroundColor: Colors.transparent,
            text: 'Feito!',
            primaryColor: TheoColors.primary,
            borderColor: TheoColors.primary,
            onPressed: _onButtonTap,
          )
        ],
      ),
    );
  }
}
