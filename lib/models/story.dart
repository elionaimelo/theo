import 'package:theo/models/enums.dart';

class Story {
  Story({
    required this.id,
    required this.sectionId,
    this.title = '',
    this.finished = false,
    this.format = EStoryFormat.NONE,
    this.type = EStoryType.NONE,
  });

  String id;
  String sectionId;
  String title;
  bool finished;
  EStoryFormat format;
  EStoryType type;

  Story copyWith({
    String? id,
    String? sectionId,
    String? title,
    bool? finished,
    EStoryFormat? format,
    EStoryType? type,
  }) {
    this.id = id ?? this.id;
    this.sectionId = sectionId ?? this.sectionId;
    this.title = title ?? this.title;
    this.finished = finished ?? this.finished;
    this.format = format ?? this.format;
    this.type = type ?? this.type;

    return this;
  }
}
