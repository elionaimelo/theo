import 'package:flutter/material.dart';
import 'package:theo/styles/colors.dart';

import 'package:theo/pages/home_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: TheoColors.primary,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 30, right: 10, left: 10),
                  child: Column(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            primary: Colors.white,
                            backgroundColor: TheoColors.primary,
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w900)),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Criar perfil',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              primary: TheoColors.primary,
                              backgroundColor: TheoColors.five,
                              textStyle: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w900)),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Já tenho uma conta',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ))
        ],
      ),
    );
  }
}
