import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
part 'quiz.g.dart';

@JsonSerializable()
class Quiz extends Equatable{

  int id;
  String title;
  List<String> questionsIds;
  double? difficulty;
  int? weight;
  int? averageTime;

  DateTime createdAt;
  DateTime updatedAt;

  Quiz({
    required this.id,
    required this.title,
    required this.questionsIds,
    required this.createdAt,
    required this.updatedAt,
    this.difficulty,
    this.weight,
    this.averageTime,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);

  Map<String, dynamic> toJson() => _$QuizToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [id,title, questionsIds,createdAt,updatedAt];

}