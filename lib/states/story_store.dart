import 'package:mobx/mobx.dart';
import 'package:theo/models/story_format.dart';
import 'package:theo/types/enums.dart';
import 'package:theo/models/story.dart';
part 'story_store.g.dart';

class StoryStore = _StoryStoreBase with _$StoryStore;

abstract class _StoryStoreBase with Store {
  @observable
  List<Story> stories = [
    Story(
      id: '1',
      sectionId: '1',
      finished: false,
      format: StoryFormat(name: EStoryFormat.VIDEO.getString()),
      title: 'Aprendendo a gravar vídeos com o celular',
      url:
          'https://github.com/elionaimelo/theo/raw/pre-validacao/others/videos/educacional_celular.mp4',
    ),
    Story(
      id: '2',
      sectionId: '1',
      finished: false,
      format: StoryFormat(name: EStoryFormat.PODCAST.getString()),
      title: 'Exercício de fortalecimento, fazer ou não fazer',
      url:
          'https://github.com/elionaimelo/theo/raw/pre-validacao/others/audios/revelacast.wav',
    ),
    Story(
      id: '3',
      sectionId: '1',
      finished: false,
      format: StoryFormat(name: EStoryFormat.INFROGRAPHIC.getString()),
      title: 'Storyteling e lorem ipsum dolor sit amet',
    ),
    Story(
      id: '4',
      sectionId: '1',
      finished: false,
      format: StoryFormat(name: EStoryFormat.TEXT.getString()),
      title: 'Storyteling e lorem ipsum dolor sit amet',
    ),
    Story(
      id: '5',
      sectionId: '1',
      finished: false,
      format: StoryFormat(name: EStoryFormat.QUIZ.getString()),
      title: 'Storyteling e lorem ipsum dolor sit amet',
    ),
  ];

  @action
  void finishStory(String id) {
    stories = stories.map((e) {
      if (e.id == id) {
        e.finished = true;

        return e;
      }
      return e;
    }).toList();
  }

  bool isSectionFinished(String sectionId) {
    return stories.every((element) {
      // Ignore the stories from another sections
      if (element.sectionId != sectionId) return true;

      return element.finished;
    });
  }
}
