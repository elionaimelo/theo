import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/error_alert_dialog.dart';
import 'package:theo/components/inputs/text_input.dart';
import 'package:theo/components/question_tab.dart';
import 'package:theo/components/result_status/loading_status.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/pages/concluded_screen/concluded_screen_controller.dart';
import 'package:theo/pages/signup_screen/signup_screen_controller.dart';
import 'package:theo/pages/tutorial_screen/tutorial_screen.dart';
import 'package:theo/pages/tutorial_screen/tutorial_screen_controller.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/types/enums.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key, required this.controller}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();

  final SignupScreenController controller;
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  double currentBarValue = 0;

  Future<bool> _onBackPressed() async {
    if (_tabController.index > 0) {
      _tabController.animateTo(_tabController.index - 1);
      return false;
    }

    Navigator.of(context).pop();

    return true;
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 6);

    widget.controller.fetchData();
  }

  Future<void> _onNextButtonTap() async {
    var index = _tabController.index;
    if (index + 1 >= _tabController.length /*- 1*/) {
      var succeeded = await widget.controller.signUpUser();

      if (succeeded) {
        await Navigator.of(context).pushNamed(
          Routes.concluded,
          arguments: ConcludedScreenController(
            message: 'O seu perfil já está pronto.',
            title: 'Concluído!',
            onNextButtonTap: _navigateToTutorialOrHome,
          ),
        );
      }

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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        color: TheoColors.secondary,
        padding: TheoMetrics.paddingScreen,
        child: SafeArea(
          child: _content,
        ),
      ),
    );
  }

  Widget get _content {
    return Observer(
      builder: (context) {
        if (widget.controller.eResultStatus == EResultStatus.LOADING) {
          return LoadingStatus();
        } else if (widget.controller.eResultStatus ==
            EResultStatus.REQUEST_ERROR) {
          return ErrorAlertDialog(content: widget.controller.errorMessage!);
        }

        return Column(
          children: [
            _progressBar,
            _body,
            BottomButton(
              text: 'Continuar',
              icon: Icons.arrow_forward,
              onPressed: _onNextButtonTap,
            )
          ],
        );
      },
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
        _emailTab,
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
            onTextChanged: widget.controller.onNameTextChanged,
          ),
        ],
      );

  Widget get _emailTab => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInput(
            hintText: 'Escreva seu email aqui',
            label: 'Qual seu e-mail?',
            onTextChanged: widget.controller.onEmailTextChanged,
          ),
        ],
      );

  Widget get _countryTab => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInput(
            hintText: 'Escreva o nome do país aqui',
            label: 'Qual o seu país?',
            onTextChanged: widget.controller.onCountryTextChanged,
          ),
        ],
      );

  Widget get _roleTab => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuestionTab(
              options:
                  widget.controller.roles.map((e) => e.displayName!).toList(),
              onSelectedIndex: widget.controller.onRoleSelected,
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
              onSelectedIndex: widget.controller.onAgeSelected,
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
            onTextChanged: widget.controller.onPasswordTextChanged,
            obscureText: true,
          ),
          Container(
            margin: EdgeInsets.only(top: 80),
          ),
          TextInput(
            hintText: 'Escreva aqui',
            label: 'Repita a sua senha',
            onTextChanged: widget.controller.onPasswordCheckTextChanged,
            obscureText: true,
          ),
        ],
      );
}
