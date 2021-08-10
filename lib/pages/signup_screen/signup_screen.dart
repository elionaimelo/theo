import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/error_alert_dialog.dart';
import 'package:theo/components/inputs/text_input.dart';
import 'package:theo/components/question_tab.dart';
import 'package:theo/components/result_status/loading_status.dart';
import 'package:theo/pages/signup_screen/signup_screen_controller.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/types/enums.dart';
import 'package:theo/validators/email_validator.dart';
import 'package:theo/validators/match_password_validator.dart';
import 'package:theo/validators/password_validator.dart';
import 'package:theo/validators/text_required_validator.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key, required this.controller}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();

  final SignupScreenController controller;
}

class _SignupScreenState extends State<SignupScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  SignupScreenController get controller => widget.controller;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: 6);

    widget.controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.onBackPressed(_tabController),
      child: Container(
        color: TheoColors.secondary,
        padding: TheoMetrics.paddingScreen,
        child: SafeArea(
          child: Form(
            key: controller.formState,
            child: _content,
          ),
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
              onPressed: () =>
                  controller.onNextButtonTap(_tabController, context),
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
          value: controller.currentBarValue,
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
            validators: [
              TextRequiredValidator(),
            ],
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
            validators: [
              EmailValidator(),
            ],
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
            validators: [
              TextRequiredValidator(),
            ],
          ),
        ],
      );

  Widget get _roleTab => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuestionTabFormField(
              QuestionTabFormFieldProps(
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
                focusNode: FocusNode(),
                validators: [
                  TextRequiredValidator(),
                ],
              ),
            ),
          ],
        ),
      );

  Widget get _ageTab => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuestionTabFormField(
              QuestionTabFormFieldProps(
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
                focusNode: FocusNode(),
                validators: [
                  TextRequiredValidator(),
                ],
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
            validators: [
              PasswordValidator(),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 80),
          ),
          TextInput(
            hintText: 'Escreva aqui',
            label: 'Repita a sua senha',
            onTextChanged: widget.controller.onPasswordCheckTextChanged,
            obscureText: true,
            validators: [
              PasswordValidator(),
              MatchPasswordValidator(
                matchValue: widget.controller.password ?? '',
              )
            ],
          ),
        ],
      );
}
