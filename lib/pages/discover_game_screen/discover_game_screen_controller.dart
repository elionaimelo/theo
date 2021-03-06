import 'package:mobx/mobx.dart';
import 'package:theo/components/error_alert_dialog.dart';
import 'package:theo/models/post.dart';
import 'package:theo/states/navigation_store.dart';
import 'package:url_launcher/url_launcher.dart';

part 'discover_game_screen_controller.g.dart';

class DiscoverGameScreenController = _DiscoverGameScreenControllerBase
    with _$DiscoverGameScreenController;

abstract class _DiscoverGameScreenControllerBase with Store {
  _DiscoverGameScreenControllerBase({
    required this.navigationStore,
    required this.post,
  });

  final NavigationStore navigationStore;

  final Post post;

  Future<void> openGameButtonTap(String url) async {
    try {
      await canLaunch(url)
          ? await launch(url)
          : throw Exception('Não foi possivel abrir o link do jogo:\n$url');
    } catch (err) {
      ErrorAlertDialog.showAlertDialog(content: err.toString());
    }
  }
}
