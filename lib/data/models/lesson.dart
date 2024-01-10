import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'lesson.g.dart';

@JsonSerializable()
class Lesson extends Equatable{
  int id;
  String title;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  Lesson({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Lesson.fromJson(Map<String, dynamic>json)=> _$LessonFromJson(json);

  Map<String, dynamic> toJson()=> _$LessonToJson(this);

  @override

  List<Object?> get props => [id,title,content, createdAt,updatedAt];
}

