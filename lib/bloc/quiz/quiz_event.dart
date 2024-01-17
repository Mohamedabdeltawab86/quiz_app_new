part of 'quiz_bloc.dart';

abstract class QuizEvent {}

class StartQuizEvent extends QuizEvent {
  final Quiz quiz;

  StartQuizEvent({required this.quiz});
}

class AnswerQuestionEvent extends QuizEvent {
  final String questionId;
  final int answer;

  AnswerQuestionEvent({required this.questionId, required this.answer});
}

class FinishQuizEvent extends QuizEvent {}
