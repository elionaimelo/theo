import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theo/components/subTitleText.dart';

import 'package:theo/components/titleText.dart';
import 'package:theo/components/titleButton.dart';
import 'package:theo/pages/home_screen/components/categoryCard.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: TitleText(title: 'O que você quer explorar hoje?'),
            ),
            Container(
              margin: EdgeInsets.only(top: 22),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 6,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon:
                        SvgPicture.asset('assets/icons/icone-como-contar.svg'),
                    label: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TitleButton(
                            title: 'Como contar?',
                          ),
                          SubTitleText(
                            subTitle: 'Aprenda storytelling',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 22),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 6,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                        'assets/icons/icone-descobrir-historias.svg'),
                    label: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TitleButton(
                            title: 'Descobrir histórias?',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 22),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 6,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                        'assets/icons/icone-contar-historia.svg'),
                    label: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TitleButton(
                            title: 'Contar uma história',
                          ),
                          SubTitleText(
                            subTitle: 'Compartilhe suas histórias',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 37),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TitleText(title: 'Categorias'),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SubTitleText(
                          subTitle: 'O que você não pode perder',
                        ),
                      )
                    ],
                  ),
                  SvgPicture.asset(
                      'assets/icons/icone-feather-arrow-right.svg'),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryCard(),
                  CategoryCard(),
                  CategoryCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
