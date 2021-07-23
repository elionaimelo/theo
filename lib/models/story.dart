import 'package:theo/core/constants/file_consts.dart';
import 'package:theo/models/story_category.dart';
import 'package:theo/models/file.dart';
import 'package:theo/models/story_format.dart';
import 'package:theo/models/language.dart';

class Story {
  Story({
    this.id,
    this.title,
    this.description,
    this.author,
    this.tags = const [],
    this.languageId,
    this.categoryId,
    this.formatId,
    this.adultContent,
    this.url,
    this.sectionId,
    this.finished = false,
    this.language,
    this.category,
    this.format,
    this.files = const [],
  });

  String? id;
  String? title;
  String? description;
  String? author;
  String? url;
  List<String> tags;
  bool? adultContent;

  String? languageId;
  String? categoryId;
  String? formatId;

  Language? language;
  StoryCategory? category;
  StoryFormat? format;

  List<File> files;

  List<File> get imageFiles {
    return files
        .where((element) => element.type == FileConsts.IMG_TYPE)
        .toList();
  }

  String? sectionId;
  bool finished;

  Map<String, dynamic> toJson({bool withId = true}) => {
        if (withId) 'id': id,
        'title': title,
        'description': description,
        'author': author,
        'url': url,
        'tags': tags,
        'language_id': languageId,
        'category_id': categoryId,
        'format_id': formatId,
        'adult_content': adultContent,
      };

  static Story? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    try {
      return Story(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        author: json['author'],
        url: json['url'],
        tags: (json['tags'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        languageId: json['language_id'],
        categoryId: json['category_id'],
        formatId: json['format_id'],
        adultContent: json['adult_content'],
        files: (json['files'] as List<dynamic>?)
                ?.map((e) => File.fromJson(e)!)
                .toList() ??
            [],
        format: StoryFormat.fromJson(json['format']),
        category: StoryCategory.fromJson(json['category']),
        language: Language.fromJson(json['language']),
      );
    } catch (err) {
      print('Story.fromJson - $err');
      rethrow;
    }
  }
}
