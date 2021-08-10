import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/profile_bar.dart';
import 'package:theo/components/result_status/loading_status.dart';
import 'package:theo/pages/login_screen/login_screen_controller.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/types/enums.dart';
import 'package:theo/validators/email_validator.dart';
import 'package:theo/validators/password_validator.dart';
import 'package:theo/validators/text_required_validator.dart';

import '../../components/inputs/text_input.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({required this.controller});
  @override
  _LoginScreenState createState() => _LoginScreenState();

  final LoginScreenController controller;
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

    _tabController = TabController(vsync: this, length: _tabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: _body,
      ),
    );
  }

  Widget get _body {
    return Observer(
      builder: (context) {
        if (widget.controller.eResultStatus == EResultStatus.LOADING) {
          return Center(child: LoadingStatus());
        }

        return Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 71, top: 15),
          child: Form(
            key: widget.controller.formState,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: _tabs,
            ),
          ),
        );
      },
    );
  }

  List<Widget> get _tabs => [
        _emailTab,
        _passwordTab,
      ];

  Widget get _passwordTab => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProfileBar(
            name: widget.controller.email,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInput(
                hintText: 'Escreva sua senha aqui',
                label: 'Insira sua senha',
                onTextChanged: widget.controller.onPasswordTextChanged,
                obscureText: true,
                validators: [
                  TextRequiredValidator(),
                  PasswordValidator(),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Divider(
                  height: 5,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Esqueceu a senha? Redefina aqui',
                  style: GoogleFonts.muli(
                    color: TheoColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          BottomButton(
            text: 'Entrar',
            icon: Icons.arrow_forward,
            onPressed: widget.controller.signInUser,
          ),
        ],
      );

  Widget get _emailTab => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _title,
          TextInput(
            hintText: 'Escreva seu email aqui',
            label: 'Endereço de email',
            onTextChanged: widget.controller.onEmailTextChanged,
            autoFocus: true,
            validators: [
              TextRequiredValidator(),
              EmailValidator(),
            ],
          ),
          BottomButton(
            text: 'Continuar',
            icon: Icons.arrow_forward,
            onPressed: () => widget.controller.onEmailButtonTap(_tabController),
          )
        ],
      );

  Widget get _title => Text(
        'Bem-vindo de volta!',
        style: GoogleFonts.muli(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: TheoColors.third,
        ),
      );
}
