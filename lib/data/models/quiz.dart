import 'package:quiz_app_new/data/models/question.dart';

class Quiz {
  int id;
  String title;
  //TODO: diff, weight, avg time
  List<String> questionsIds;
  DateTime createdAt;
  DateTime updatedAt;

  Quiz({
    required this.id,
    required this.title,
    required this.questions,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert Quiz object to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'questions': questions.map((question) => question.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // Create a Quiz object from a map
  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      title: json['title'],
      questions: (json['questions'] as List).map((questionJson) => Question.fromJson(questionJson)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
