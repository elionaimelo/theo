import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/titleText.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/pages/discover_screen/components/post_card.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';
import 'package:theo/utils/assets_path.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  void _onSearchTap() {
    Navigator.of(context).pushNamed(Routes.search);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Padding(
            padding: TheoMetrics.paddingScreen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BottomButton(
                  text: 'Pesquisar',
                  borderColor: TheoColors.primary,
                  backgroundColor: TheoColors.secondary,
                  primaryColor: TheoColors.primary,
                  icon: FeatherIcons.filter,
                  textDirection: TextDirection.rtl,
                  onPressed: _onSearchTap,
                ),
                Container(
                  margin: EdgeInsets.only(top: 28),
                  child: TitleText(
                    title: 'Descobrir histórias',
                  ),
                ),
              ],
            ),
          ),
          PostCard(
            profileName: 'Astrogilda Nunes',
            cardImage: AssetsPath.defaultCardSvg,
            avatarImage: AssetsPath.avatarJpg,
            textBody:
                'At vero eos et accusam et justo duo Dolores et ea rebum. Stet clita kasd gubergren, no sea',
            type: 'Imagem',
            title: 'Storyteling e lorem ipsum dolor sit amet.',
            author: 'Tarcila Cabral',
            likesCount: 16,
            commentsCount: 5,
            adultRestriction: true,
          ),
          PostCard(
            profileName: 'Kaline Sampaio',
            cardImage: AssetsPath.defaultCardSvg,
            avatarImage: AssetsPath.avatarJpg,
            type: 'Sífilis',
            format: 'Jogo',
            title: 'Nome do jogo lorem ipsum dolor',
            author: 'Beutrano Cunha',
            likesCount: 16,
            commentsCount: 5,
          ),
          PostCard(
            profileName: 'Beutrano Cunha',
            cardImage: AssetsPath.defaultCardSvg,
            avatarImage: AssetsPath.avatarJpg,
            type: 'Vídeo',
            format: 'Ciência',
            title:
                'Storyteling e lorem ipsum dolor sit amet, consetetur sadipscing elitr.',
            author: 'Aureliano Figueiredo',
            likesCount: 16,
            commentsCount: 4,
          ),
        ],
      ),
    );
  }
}
