import 'package:theo/core/constants/story_format_consts.dart';
import 'package:theo/models/section.dart';
import 'package:theo/models/story.dart';
import 'package:theo/models/story_format.dart';

class TheoMocks {
  static List<String> tellFormatsMock = [
    'Vídeo',
    'Animação',
    'Texto',
    'HQ',
    'Jogo',
    'Infográfico',
    'Imagem',
    'Música',
    'Figura Interativa',
    'Podcast'
  ];

  static List<String> categoriesMock = [
    'Ciência',
    'Sífilis',
    'Saúde',
    'Tecnologia',
    'Meio ambiente',
    'Matemática',
    'Inovação',
    'Artes',
    'História',
    'Linguística'
  ];

  static List<String> languagesMock = [
    'English',
    'Português',
    'Español',
    'Todos',
  ];

  static List<Section> sectionsMock = [
    Section(
      title: 'Aprendendo a gravar vídeos com o celular',
      id: '1',
    ),
    Section(
      title: 'Direitos Autorais',
      id: '2',
    ),
    Section(
      title: 'Título aqui - lorem ipsum dolor sit amet consetetur',
      id: '3',
    ),
    Section(
      title: 'Título aqui - lorem ipsum dolor sit amet consetetur',
      id: '4',
    ),
    Section(
      title: 'Título aqui - lorem ipsum dolor sit amet consetetur',
      id: '5',
    ),
    Section(
      title: 'Título aqui - lorem ipsum dolor sit amet consetetur',
      id: '6',
    ),
    Section(
      title: 'Título aqui - lorem ipsum dolor sit amet consetetur',
      id: '7',
    ),
    Section(
      title: 'Título aqui - lorem ipsum dolor sit amet consetetur',
      id: '8',
    ),
    Section(
      title: 'Título aqui - lorem ipsum dolor sit amet consetetur',
      id: '9',
    ),
  ];

  static List<Story> learningStories = [
    Story(
      id: '1',
      sectionId: '1',
      finished: false,
      format: StoryFormat(name: StoryFormatConsts.VIDEO),
      title: 'Aprendendo a gravar vídeos com o celular',
      url:
          'https://github.com/elionaimelo/theo/raw/pre-validacao/others/videos/educacional_celular.mp4',
    ),
    Story(
      id: '2',
      sectionId: '1',
      finished: false,
      format: StoryFormat(name: StoryFormatConsts.PODCAST),
      title: 'Exercício de fortalecimento, fazer ou não fazer',
      url:
          'https://github.com/elionaimelo/theo/raw/pre-validacao/others/audios/revelacast.wav',
    ),
    Story(
      id: '3',
      sectionId: '1',
      finished: false,
      format: StoryFormat(name: StoryFormatConsts.INFROGRAPHIC),
      title: 'Storyteling e lorem ipsum dolor sit amet',
    ),
    Story(
      id: '4',
      sectionId: '1',
      finished: false,
      format: StoryFormat(name: StoryFormatConsts.TEXT),
      title: 'Storyteling e lorem ipsum dolor sit amet',
    ),
    Story(
      id: '5',
      sectionId: '1',
      finished: false,
      format: StoryFormat(name: StoryFormatConsts.QUIZ),
      title: 'Storyteling e lorem ipsum dolor sit amet',
    ),
  ];
}
