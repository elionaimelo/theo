import 'package:flutter/material.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/inputs/text_input.dart';
import 'package:theo/components/question_tab.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/pages/concluded_screen/concluded_screen_controller.dart';
import 'package:theo/pages/tutorial_screen/tutorial_screen.dart';
import 'package:theo/pages/tutorial_screen/tutorial_screen_controller.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  double currentBarValue = 0;

  void _onNameTextChanged(String p1) {}

  void _onNextButtonTap() {
    var index = _tabController.index;
    if (index + 1 >= _tabController.length /*- 1*/) {
      Navigator.of(context).pushNamed(
        Routes.concluded,
        arguments: ConcludedScreenController(
          message: 'O seu perfil já está pronto.',
          title: 'Concluído!',
          onNextButtonTap: _navigateToTutorialOrHome,
        ),
      );
      return;
    }

    _tabController.animateTo(index + 1);

    setState(() {
      currentBarValue =
          (index.toDouble() + 1) / (_tabController.length.toDouble() - 1);
    });
  }

  Future<void> _navigateToTutorialOrHome() async {
    Navigator.of(context).popUntil((route) => route.isFirst);

    if (await TutorialScreen.isFirstShow()) {
      await Navigator.of(context).pushNamed(
        Routes.tutorial,
        arguments: TutorialScreenController(),
      );
    } else {
      await Navigator.of(context).pushNamed(Routes.home);
    }
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: TheoMetrics.paddingScreen,
      child: SafeArea(
        child: Column(
          children: [
            _progressBar,
            _body,
            BottomButton(
              text: 'Continuar',
              icon: Icons.arrow_forward,
              onPressed: _onNextButtonTap,
            )
          ],
        ),
      ),
    );
  }

  Widget get _progressBar => Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: LinearProgressIndicator(
          minHeight: 15,
          value: currentBarValue,
          backgroundColor: TheoColors.twelve,
          valueColor: AlwaysStoppedAnimation<Color>(TheoColors.eleven),
        ),
      );

  Widget get _body => Expanded(
        child: Container(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: _tabs,
          ),
        ),
      );

  List<Widget> get _tabs => [
        _nameTab,
        _countryTab,
        _roleTab,
        _ageTab,
        _passwordTab,
        // TermTab(),
      ];

  Widget get _nameTab => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInput(
            hintText: 'Escreva seu nome aqui',
            label: 'Qual seu nome?',
            onTextChanged: _onNameTextChanged,
          ),
        ],
      );

  Widget get _countryTab => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInput(
            hintText: 'Escreva o nome do país aqui',
            label: 'Qual o seu país?',
            onTextChanged: _onNameTextChanged,
          ),
        ],
      );

  Widget get _roleTab => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuestionTab(
              options: ['Professor', 'Aluno', 'Outro'],
              onSelectedIndex: _onSelectedIndex,
              question: 'Você é...',
              crossAxisAlign: CrossAxisAlignment.start,
              questionStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: TheoColors.primary,
                  ),
            ),
          ],
        ),
      );

  Widget get _ageTab => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuestionTab(
              options: [
                'Até 19 anos',
                '20 a 29 anos',
                '30 a 39 anos',
                '40 a 49 anos',
                '50 anos ou mais'
              ],
              onSelectedIndex: _onSelectedIndex,
              question: 'Qual a sua faixa etária?',
              crossAxisAlign: CrossAxisAlignment.start,
              questionStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: TheoColors.primary,
                  ),
            ),
          ],
        ),
      );

  Widget get _passwordTab => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInput(
            hintText: 'Escreva aqui',
            label: 'Crie uma senha',
            onTextChanged: _onNameTextChanged,
            obscureText: true,
          ),
          Container(
            margin: EdgeInsets.only(top: 80),
          ),
          TextInput(
            hintText: 'Escreva aqui',
            label: 'Repita a sua senha',
            onTextChanged: _onNameTextChanged,
            obscureText: true,
          ),
        ],
      );

  void _onSelectedIndex(int index) {}
}
