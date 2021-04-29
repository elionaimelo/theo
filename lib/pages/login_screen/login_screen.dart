import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/models/theo_app_bar_settings.dart';
import 'package:theo/pages/login_screen/components/login_email_tag.dart';
import 'package:theo/pages/login_screen/login_screen_controller.dart';
import 'package:theo/styles/colors.dart';

import '../../components/text_input.dart';

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
    widget.controller.setAppBar(TheoAppBarSettings(
      visible: false,
    ));
    return true;
  }

  void _onEmailButtonTap() {
    _tabController.animateTo(1);
  }

  void _onPasswordButtonTap() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed(Routes.home);
  }

  void _onEmailTextChanged(String value) {
    setState(() {
      widget.controller.email = value;
    });
  }

  void _onPasswordTextChanged(String value) {
    setState(() {
      widget.controller.password = value;
    });

    Navigator.of(context).pushNamed(Routes.home);
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, length: _tabs.length);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      widget.controller
          .setAppBar(TheoAppBarSettings(visible: true, withBackButton: true));
    });
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

  Widget get _body => Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 71, top: 15),
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: _tabs,
      ));

  List<Widget> get _tabs => [
        _emailTab,
        _passwordTab,
      ];

  Widget get _passwordTab => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LoginEmailTag(
            email: widget.controller.email,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputText(
                hintText: 'Escreva sua senha aqui',
                label: 'Insira sua senha',
                onTextChanged: _onPasswordTextChanged,
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Divider(
                  height: 5,
                ),
              ),
              TextButton(
                onPressed: () {
                  print('Pressed');
                },
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
            onPressed: _onPasswordButtonTap,
          ),
        ],
      );

  Widget get _emailTab => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _title,
          InputText(
            hintText: 'Escreva seu email aqui',
            label: 'Endereço de email',
            onTextChanged: _onEmailTextChanged,
          ),
          BottomButton(
            text: 'Continuar',
            icon: Icons.arrow_forward,
            onPressed: _onEmailButtonTap,
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
