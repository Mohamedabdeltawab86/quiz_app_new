
enum QuestionType {radio, checkbox, trueFalse, complete}

class Question {
  String statement;

  // TODO: diff, weight, avg time
  List<String> options;
  String correctAnswer;

  Question({
    required this.statement,
    required this.options,
  });

  // Convert Question object to a map
  Map<String, dynamic> toJson() {
    return {
      'statement': statement,
      'options': options,
    };
  }

  // Create a Question object from a map
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      statement: json['statement'],
      options: List<String>.from(json['options']),
    );
  }
}
