import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/common_functions.dart';
import 'lesson.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'module.g.dart';

@JsonSerializable()
class Module extends Equatable {
  final int id;
  final String? title;
  // Done: use IDs instead of whole objects, always remeber that you're using firestore not local db.
  final List<String> lessonIds;
  @JsonKey(
    fromJson: dateTimeFromTimestamp,
    toJson: dateTimeToTimestamp,
  )
  final DateTime createdAt;
  @JsonKey(
    fromJson: dateTimeFromTimestamp,
    toJson: dateTimeToTimestamp,
  )
  final DateTime updatedAt;

  const Module({
    required this.id,
    required this.title,
    required this.lessonIds,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleToJson(this);

  @override
  List<Object?> get props => [id, title, lessonIds, createdAt, updatedAt];
}
