import 'package:theo/types/enums.dart';
import 'package:theo/models/user.dart';

class Story {
  Story({
    required this.id,
    required this.sectionId,
    this.title = '',
    this.finished = false,
    this.format = EStoryFormat.NONE,
    this.type = EStoryType.NONE,
    this.link = '',
    this.adultContent = false,
    this.author = '',
    this.user,
  });

  String id;
  String sectionId;
  String title;
  bool finished;
  String link;
  bool adultContent;
  EStoryFormat format;
  EStoryType type;
  String author;
  User? user;

  Story copyWith({
    String? id,
    String? sectionId,
    String? title,
    bool? finished,
    EStoryFormat? format,
    EStoryType? type,
    String? link,
    bool? adultContent,
    String? author,
    User? user,
  }) {
    this.id = id ?? this.id;
    this.sectionId = sectionId ?? this.sectionId;
    this.title = title ?? this.title;
    this.finished = finished ?? this.finished;
    this.format = format ?? this.format;
    this.type = type ?? this.type;
    this.link = link ?? this.link;
    this.adultContent = adultContent ?? this.adultContent;
    this.author = author ?? this.author;
    this.user = user ?? this.user;

    return this;
  }
}
