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
    this.tags,
    this.languageId,
    this.categoryId,
    this.formatId,
    this.fileId,
    this.adultContent,
    this.url,
    this.sectionId,
    this.finished = false,
    this.language,
    this.category,
    this.format,
    this.file,
  });

  String? id;
  String? title;
  String? description;
  String? author;
  String? url;
  List<String>? tags;
  bool? adultContent;

  String? languageId;
  String? categoryId;
  String? formatId;
  String? fileId;

  Language? language;
  StoryCategory? category;
  StoryFormat? format;
  File? file;

  String? sectionId;
  bool finished;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'author': author,
        'url': url,
        'tags': tags,
        'language_id': languageId,
        'category_id': categoryId,
        'format_id': formatId,
        'file_id': formatId,
        'adult_content': adultContent,
      };

  static Story? fromJson(Map<String, dynamic> json) {
    try {
      return Story(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        author: json['author'],
        tags: json['tags'],
        languageId: json['language_id'],
        categoryId: json['category_id'],
        formatId: json['format_id'],
        fileId: json['file_id'],
        adultContent: json['adult_content'],
      );
    } catch (err) {
      print('Story.fromJson - $err');
    }
  }
}
