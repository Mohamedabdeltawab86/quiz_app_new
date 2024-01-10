import 'lesson.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'module.g.dart';

@JsonSerializable()
class Module extends Equatable{
  int id;
  String? title;
  List<Lesson?> lessons;
  DateTime createdAt;
  DateTime updatedAt;

  Module({
    required this.id,
    required this.title,
    required this.lessons,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Module.fromJson(Map<String, dynamic>json)=>_$ModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleToJson(this);

  @override

  List<Object?> get props => [id, title, lessons,createdAt,updatedAt];
}
