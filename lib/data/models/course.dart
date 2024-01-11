import 'module.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'course.g.dart';

@JsonSerializable()
class Course extends Equatable {
  int id;
  String? title;
  String? description;
  // TODO: naming should describe the variable, it should be imageUrl.
  String? image;
  int instructorId;
  List<Module?> modules;
  DateTime createdAt;
  DateTime updatedAt;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.instructorId,
    required this.modules,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        image,
        modules,
        instructorId,
        createdAt,
        updatedAt
      ];
}
