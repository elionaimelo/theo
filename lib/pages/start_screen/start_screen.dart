import 'package:flutter/material.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/styles/colors.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  void _onLoginButtonPress() {
    Navigator.of(context).pushNamed(Routes.login);
  }

  void _onSignupButtonPress() {
    Navigator.of(context).pushNamed(Routes.signup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/bg1.png'),
                        fit: BoxFit.cover)),
              )),
          Expanded(
              child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.asset('assets/images/logo-theo.png'),
                ),
              ),
              Container(
                width: 262,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text:
                            'Veja histórias em qualquer\n lugar e compartilhe com facilidade!',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: TheoColors.primary,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 30, right: 10, left: 10),
                  child: Column(
                    children: [
                      BottomButton(
                        onPressed: _onSignupButtonPress,
                        text: 'Criar perfil',
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: BottomButton(
                            onPressed: _onLoginButtonPress,
                            text: 'Já tenho uma conta',
                            primaryColor: TheoColors.primary,
                            backgroundColor: TheoColors.five,
                          )),
                    ],
                  ))
            ],
          ))
        ],
      ),
    );
  }
}
