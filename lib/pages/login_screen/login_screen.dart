import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theo/components/bottomButton.dart';
import 'package:theo/components/theoAppBar.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/pages/login_screen/components/login_email_tag.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

import 'components/login_input_text.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  String email = '';
  String password = '';

  Future<bool> _onBackPressed() async {
    if (_tabController.index > 0) {
      _tabController.animateTo(_tabController.index - 1);
      return false;
    }

    Navigator.of(context).pop();
    return false;
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
      email = value;
    });
  }

  void _onPasswordTextChanged(String value) {
    setState(() {
      password = value;
    });

    Navigator.of(context).pushNamed(Routes.home);
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(TheoMetrics.appBarHeight),
          child: TheoAppBar(
            withBackButton: true,
            onBackPressed: _onBackPressed,
          ),
        ),
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
            email: email,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoginInputText(
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
          LoginInputText(
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
