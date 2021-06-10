import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:theo/components/close_top_bar_button.dart';
import 'package:theo/components/story_progress.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/pages/concluded_screen/concluded_screen_controller.dart';
import 'package:theo/pages/quiz_story_screen/components/answer_input.dart';
import 'package:theo/components/question_tab.dart';
import 'package:theo/pages/quiz_story_screen/quiz_story_screen_controller.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

class QuizStoryScreen extends StatefulWidget {
  const QuizStoryScreen({Key? key, required this.controller}) : super(key: key);

  @override
  _QuizStoryScreenState createState() => _QuizStoryScreenState();

  final QuizStoryScreenController controller;
}

class _QuizStoryScreenState extends State<QuizStoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(vsync: this, length: widget.controller.questionsCount);

    _tabController.addListener(() {
      widget.controller.tabIndex = _tabController.index;
    });
  }

  void _onTapCorrect() {
    widget.controller.eAnswerInputState = EAnswerInputState.NONE;
  }

  void _onTapAnswer() {
    if (widget.controller.isCorrectAnswer(_tabController.index)) {
      widget.controller.eAnswerInputState = EAnswerInputState.SUCCESS;
    } else {
      widget.controller.eAnswerInputState = EAnswerInputState.ERROR;
    }
  }

  void _onConcludedTap() {
    widget.controller.storyStore.finishStory(widget.controller.story.id);
    GetIt.I.get<NavigationStore>().popUntil(Routes.home);
  }

  void _onTapSucess() {
    if (_tabController.index >= _tabController.length - 1) {
      Navigator.of(context).pushNamed(
        Routes.concluded,
        arguments: ConcludedScreenController(
          title: 'Parabéns, Astrogilda!',
          message: 'Primeira parte concluída.',
          withAvaliations: true,
          total: 5,
          progress: 1,
          onNextButtonTap: _onConcludedTap,
        ),
      );
      return;
    }

    var nextIndex = _tabController.index + 1;

    if (nextIndex < _tabController.length) {
      widget.controller.eAnswerInputState = EAnswerInputState.NONE;
      _tabController.animateTo(nextIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: TheoMetrics.paddingScreen.copyWith(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CloseTopBarButton(
                    foregroundColor: TheoColors.primary,
                  ),
                  Observer(
                    builder: (_) => StoryProgress(
                      progress: widget.controller.tabIndex + 1,
                      total: 4,
                      hasThunder: false,
                      hasTitle: false,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                  ),
                  _questionView,
                ],
              ),
            ),
          ),
          Observer(
            builder: (_) => AnswerInput(
              onTapAnswer: _onTapAnswer,
              onTapSuccess: _onTapSucess,
              onTapCorrect: _onTapCorrect,
              onTapJump: _onTapSucess,
              eAnswerInputState: widget.controller.eAnswerInputState,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _questionView => Expanded(
        child: Container(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: _tabs,
          ),
        ),
      );

  List<Widget> get _tabs => [_tab1, _tab2, _tab3, _tab4];

  Widget get _tab1 => QuestionTab(
        question:
            'Lorem ipsum dolor sit amet consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna?',
        options: [
          'Resposta 1 lorem ipsum dolore magna at vero eos rebum',
          'Resposta 2 lorem ipsum dolore',
          'Resposta 3 lorem ipsum dolore magna at vero eos rebum',
          'Resposta 4 lorem ipsum dolore magna at vero',
        ],
        onSelectedIndex: (int index) => widget.controller.selectAnswer(index),
      );

  Widget get _tab2 => QuestionTab(
        question:
            'Lorem ipsum dolor sit amet consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna?',
        options: [
          'Verdadeiro',
          'Falso',
        ],
        onSelectedIndex: (int index) => widget.controller.selectAnswer(index),
      );

  Widget get _tab3 => QuestionTab(
        question:
            'Lorem ipsum dolor sit amet consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna?',
        options: [
          'Resposta 1 lorem ipsum dolore magna at vero eos rebum',
          'Resposta 2 lorem ipsum dolore',
          'Resposta 3 lorem ipsum dolore magna at vero eos rebum',
          'Resposta 4 lorem ipsum dolore magna at vero',
        ],
        onSelectedIndex: (int index) => widget.controller.selectAnswer(index),
      );

  Widget get _tab4 => QuestionTab(
        question:
            'Lorem ipsum dolor sit amet consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna?',
        options: [
          'Resposta 1 lorem ipsum dolore magna at vero eos rebum',
          'Resposta 2 lorem ipsum dolore',
          'Resposta 3 lorem ipsum dolore magna at vero eos rebum',
          'Resposta 4 lorem ipsum dolore magna at vero',
        ],
        onSelectedIndex: (int index) => widget.controller.selectAnswer(index),
      );
}
