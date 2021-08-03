import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:theo/components/bottom_button.dart';
import 'package:theo/components/error_alert_dialog.dart';
import 'package:theo/components/result_status/loading_status.dart';
import 'package:theo/components/result_status/not_found_status.dart';
import 'package:theo/components/title_text.dart';
import 'package:theo/core/constants/story_format_consts.dart';
import 'package:theo/core/routes.dart';
import 'package:theo/models/post.dart';
import 'package:theo/pages/discover_game_screen/discover_game_screen_controller.dart';
import 'package:theo/pages/discover_image_screen/discover_image_screen_controller.dart';
import 'package:theo/pages/discover_screen/components/post_card.dart';
import 'package:theo/pages/discover_screen/discover_screen_controller.dart';
import 'package:theo/pages/discover_sound_screen/discover_media_screen_controller.dart';
import 'package:theo/pages/graph_story_screen/graph_story_screen_controller.dart';
import 'package:theo/styles/colors.dart';
import 'package:theo/styles/metrics.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key, required this.controller}) : super(key: key);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();

  final DiscoverScreenController controller;
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with AutomaticKeepAliveClientMixin<DiscoverScreen> {
  DiscoverScreenController get controller => widget.controller;

  @override
  bool get wantKeepAlive => true;

  void _onSearchTap() {
    Navigator.of(context).pushNamed(Routes.search);
  }

  @override
  void initState() {
    super.initState();

    controller.fetchPosts();
  }

  Future<void> onRefresh() {
    controller.fetchPosts(page: 1);
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: _content,
    );
  }

  Widget get _content => Container(
        child: _list,
      );

  Widget get _topContent => Padding(
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
      );

  Widget get _list => PagedListView.separated(
        pagingController: controller.postStore.pagingController,
        builderDelegate: _builderDelegate,
        separatorBuilder: (p1, p2) => Container(),
      );

  Widget _itemBuilder(context, post, index) {
    var postWidget = PostCard(
      post: post,
      onTapMore: () => _onTapCard(post),
    );

    var isFirstElement = index == 0;

    if (isFirstElement) {
      return Column(
        children: [_topContent, postWidget],
      );
    }

    return postWidget;
  }

  Widget withTopContent(Widget item) => Column(
        children: [
          _topContent,
          Expanded(
            child: Container(
              child: item,
            ),
          )
        ],
      );

  PagedChildBuilderDelegate<Post> get _builderDelegate =>
      PagedChildBuilderDelegate<Post>(
        itemBuilder: _itemBuilder,
        firstPageProgressIndicatorBuilder: (_) => withTopContent(
          LoadingStatus(),
        ),
        newPageErrorIndicatorBuilder: (context) => ErrorAlertDialog(
          content: 'Erro ao carregar os posts seguintes!',
          withButton: false,
        ),
        newPageProgressIndicatorBuilder: (context) => LoadingStatus(),
        noMoreItemsIndicatorBuilder: (context) => Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          child: NotFoundStatus(
            title: 'Você chegou até o fim!',
          ),
        ),
        firstPageErrorIndicatorBuilder: (context) => withTopContent(
          ErrorAlertDialog(
            content: controller.postStore.pagingController.error,
            withButton: false,
          ),
        ),
        noItemsFoundIndicatorBuilder: (context) => withTopContent(
          NotFoundStatus(
            title: 'Nenhum post encontrado!',
          ),
        ),
      );

  void _onTapCard(Post p) {
    if (p.story == null || p.story?.format == null) return;

    var format = p.story!.format;

    switch (format!.name) {
      case StoryFormatConsts.VIDEO:
      case StoryFormatConsts.MUSIC:
      case StoryFormatConsts.PODCAST:
        Navigator.of(context).pushNamed(
          Routes.discoverMedia,
          arguments: DiscoverMediaScreenController(post: p),
        );
        break;
      case StoryFormatConsts.IMAGE:
        Navigator.of(context).pushNamed(
          Routes.discoverImage,
          arguments: DiscoverImageScreenController(
            post: p,
          ),
        );
        break;
      case StoryFormatConsts.GAME:
        Navigator.of(context).pushNamed(
          Routes.discoverGame,
          arguments: DiscoverGameScreenController(
            navigationStore: GetIt.I.get(),
            post: p,
          ),
        );
        break;
      case StoryFormatConsts.INFROGRAPHIC:
        Navigator.of(context).pushNamed(
          Routes.graphStory,
          arguments:
              GraphStoryScreenController(storyStore: GetIt.I.get(), post: p),
        );
        break;
      default:
    }
  }
}
