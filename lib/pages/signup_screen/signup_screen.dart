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

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              text: AppLocalizations.of(context)!.nextButton,
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
            hintText: AppLocalizations.of(context)!.nameInputHint,
            label: AppLocalizations.of(context)!.nameInputLabel,
            onTextChanged: widget.controller.onNameTextChanged,
          ),
        ],
      );

  Widget get _emailTab => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInput(
            hintText: AppLocalizations.of(context)!.emailInputHint,
            label: AppLocalizations.of(context)!.emailInputLabel,
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
            hintText: AppLocalizations.of(context)!.countryInputHint,
            label: AppLocalizations.of(context)!.countryInputLabel,
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
                question: AppLocalizations.of(context)!.roleInputQuestion,
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
                  AppLocalizations.of(context)!.age1Input,
                  AppLocalizations.of(context)!.age2Input,
                  AppLocalizations.of(context)!.age3Input,
                  AppLocalizations.of(context)!.age4Input,
                  AppLocalizations.of(context)!.age5Input,
                ],
                onSelectedIndex: widget.controller.onAgeSelected,
                question: AppLocalizations.of(context)!.ageInputQuestion,
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
            hintText: AppLocalizations.of(context)!.defaultInputHint,
            label: AppLocalizations.of(context)!.passwordInputLabel,
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
            hintText: AppLocalizations.of(context)!.defaultInputHint,
            label: AppLocalizations.of(context)!.matchPasswordInputLabel,
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
