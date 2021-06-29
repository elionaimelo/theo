import 'package:flutter/material.dart';
import 'package:theo/components/option_button.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/pages/concluded_screen/concluded_screen_controller.dart';
import 'package:theo/pages/signup_screen/components/term_bottom_sheet.dart';
import 'package:theo/pages/tutorial_screen/tutorial_screen.dart';
import 'package:theo/pages/tutorial_screen/tutorial_screen_controller.dart';
import 'package:theo/styles/colors.dart';

class TermTab extends StatefulWidget {
  const TermTab({Key? key}) : super(key: key);

  @override
  _TermTabState createState() => _TermTabState();
}

class _TermTabState extends State<TermTab> {
  bool acceptEnabled = true;

  Future<void> _openTerm() async {
    await TermBottomSheet.showTermBottomSheet(context);

    setState(() {
      acceptEnabled = true;
    });
  }

  void _acceptTerm() {
    Navigator.of(context).pushNamed(
      Routes.concluded,
      arguments: ConcludedScreenController(
        message: 'O seu perfil já está pronto.',
        title: 'Concluído!',
        onNextButtonTap: _navigateToTutorialOrHome,
      ),
    );
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _label('Termo de consentimento'),
        OptionButton(text: 'Ler termo', onTap: _openTerm, selected: false),
        OptionButton(
            text: 'Aceitar',
            onTap: acceptEnabled ? _acceptTerm : () {},
            selected: !acceptEnabled),
      ],
    );
  }

  Widget _label(String text) => Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: TheoColors.primary,
              ),
        ),
      );
}
