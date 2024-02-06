import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app_new/data/models/add_lesson_data_model.dart';

import '../../utils/common_functions.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'module.g.dart';

@JsonSerializable(includeIfNull: false)
class Module extends Equatable {
  final String? id;
  final String? title;
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

  const Module({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleToJson(this);

  @override
  List<Object?> get props => [id, updatedAt];
}
