import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import '../../utils/common_functions.dart';

part 'course.g.dart';

@JsonSerializable()
class Course extends Equatable {
  final int? id;
  final String title;
  final String? description;
  final String? imageUrl;
  final List<String>? moduleIds;
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

  const Course({
    this.id,
    required this.title,
    this.description,
    this.imageUrl,
    this.moduleIds,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);



  @override
  List<Object?> get props => [id, updatedAt];
}
