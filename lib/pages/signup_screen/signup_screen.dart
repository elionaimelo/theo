import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/error_alert_dialog.dart';
import 'package:theo/components/inputs/text_input.dart';
import 'package:theo/components/lang_icon.dart';
import 'package:theo/components/question_tab.dart';
import 'package:theo/components/result_status/loading_status.dart';
import 'package:theo/pages/signup_screen/signup_screen_controller.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/types/enums.dart';
import 'package:theo/validators/email_validator.dart';
import 'package:theo/validators/match_password_validator.dart';
import 'package:theo/validators/option_required_validator.dart';
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
  SignupScreenController get controller => widget.controller;

  AppLocalizations get _locale => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();

    widget.controller.fetchData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller.setTabController(TabController(vsync: this, length: 7));
  }

  @override
  void dispose() {
    widget.controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => controller.onBackPressed(),
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
            _bottomButton,
          ],
        );
      },
    );
  }

  Widget get _bottomButton {
    return Observer(builder: (_) {
      if (controller.tabIndex == 0) {
        return Container();
      }

      return BottomButton(
        text: AppLocalizations.of(context)!.nextButton,
        icon: Icons.arrow_forward,
        onPressed: () => controller.onNextButtonTap(context),
      );
    });
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
            controller: controller.tabController,
            children: _tabs,
          ),
        ),
      );

  List<Widget> get _tabs => [
        _languageTab,
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
              TextRequiredValidator(context),
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
              EmailValidator(context),
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
              TextRequiredValidator(context),
            ],
          ),
        ],
      );

  Widget get _roleTab {
    var options = widget.controller.roles
        .map((e) => e.displayName?[_locale.localeName].toString() ?? '')
        .toList();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QuestionTabFormField(
            QuestionTabFormFieldProps(
              options: options
                  .map((i) => OptionItem(text: i, key: ValueKey(i)))
                  .toList(),
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
                // OptionRequiredValidator(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get _ageTab {
    var options = [
      AppLocalizations.of(context)!.age1Input,
      AppLocalizations.of(context)!.age2Input,
      AppLocalizations.of(context)!.age3Input,
      AppLocalizations.of(context)!.age4Input,
      AppLocalizations.of(context)!.age5Input,
    ];
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QuestionTabFormField(
            QuestionTabFormFieldProps(
              options: options
                  .map((i) => OptionItem(text: i, key: ValueKey(i)))
                  .toList(),
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
                // OptionRequiredValidator(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget get _passwordTab => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextInput(
            hintText: AppLocalizations.of(context)!.defaultInputHint,
            label: AppLocalizations.of(context)!.passwordInputLabel,
            onTextChanged: widget.controller.onPasswordTextChanged,
            obscureText: true,
            validators: [
              PasswordValidator(context),
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
              PasswordValidator(context),
              MatchPasswordValidator(
                matchValue: widget.controller.password ?? '',
                context: context,
              )
            ],
          ),
        ],
      );

  Widget get _languageTab {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QuestionTabFormField(
            QuestionTabFormFieldProps(
              options: widget.controller.languages
                  .map(
                    (i) => OptionItem(
                      text: i.displayName ?? '-',
                      icon: LangIcon(
                        languageCode: i.name,
                      ),
                      key: ValueKey(i),
                    ),
                  )
                  .toList(),
              onSelectedIndex: (index) {
                widget.controller.onLanguageSelected(context, index);
              },
              question: AppLocalizations.of(context)!.roleInputQuestion,
              crossAxisAlign: CrossAxisAlignment.start,
              questionStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: TheoColors.primary,
                  ),
              focusNode: FocusNode(),
              validators: [],
            ),
          ),
        ],
      ),
    );
  }
}
