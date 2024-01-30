import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import '../../utils/common_functions.dart';
part 'lesson.g.dart';

@JsonSerializable(includeIfNull: false)
class Lesson extends Equatable {
  final String? id;
  final String? title;
  final String? content;
  @JsonKey(
    fromJson: dateTimeFromTimestamp,
    toJson: dateTimeToTimestamp,
  )
  final DateTime? createdAt;
  @JsonKey(
    fromJson: dateTimeFromTimestamp,
    toJson: dateTimeToTimestamp,
  )
  final DateTime? updatedAt;

  const Lesson({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  Map<String, dynamic> toJson() => _$LessonToJson(this);


  @override
  List<Object?> get props => [id, updatedAt];
}
