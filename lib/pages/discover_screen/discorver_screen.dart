import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/title_text.dart';
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
            padding: TheoMetrics.paddingScreen.copyWith(bottom: 0),
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
            profileName: 'Kaline Sampaio',
            cardImage: AssetsPath.dicesJpg,
            avatarImage: AssetsPath.avatarJpg,
            type: 'Sífilis',
            format: 'Jogo',
            title: 'Nome do jogo lorem ipsum dolor',
            author: 'Beutrano Cunha',
            likesCount: 16,
            commentsCount: 5,
            onTapMore: () =>
                Navigator.of(context).pushNamed(Routes.discoverGame),
          ),
          PostCard(
            profileName: 'Nome do usuário',
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
            onTapMore: () =>
                Navigator.of(context).pushNamed(Routes.discoverImage),
          ),
          PostCard(
            profileName: 'Beutrano Cunha',
            cardImage: AssetsPath.cienciaPng,
            avatarImage: AssetsPath.avatarJpg,
            type: 'Ciência',
            format: 'Vídeo',
            title:
                'Storyteling e lorem ipsum dolor sit amet, consetetur sadipscing elitr.',
            author: 'Aureliano Figueiredo',
            likesCount: 16,
            commentsCount: 4,
            adultRestriction: true,
          ),
          PostCard(
            profileName: 'Eustáquio Dávila',
            cardImage: AssetsPath.lingPng,
            avatarImage: AssetsPath.avatarJpg,
            type: 'Linguística',
            format: 'Texto',
            title:
                'Storyteling e lorem ipsum dolor sit amet, consetetur sadipscing elitr.',
            author: 'Aristotelina Marques',
            likesCount: 16,
            commentsCount: 5,
          ),
          PostCard(
            profileName: 'Rosângela Alves',
            cardImage: AssetsPath.musicJpg,
            avatarImage: AssetsPath.avatarJpg,
            type: 'Português',
            format: 'Música',
            title: 'Story lorem ipsum dolor',
            author: 'Autoria: Rosângela Alves e Maria Coutinho',
            likesCount: 16,
            commentsCount: 5,
          ),
          PostCard(
            profileName: 'Maricleia Malva',
            cardImage: AssetsPath.podcastJpg,
            type: 'Meio ambiente',
            format: 'Podcast',
            title: 'Story lorem ipsum dolor',
            author: 'Autoria: Maricleia Malva e Antônio Silveira',
            likesCount: 1,
            commentsCount: 5,
          ),
        ],
      ),
    );
  }
}
