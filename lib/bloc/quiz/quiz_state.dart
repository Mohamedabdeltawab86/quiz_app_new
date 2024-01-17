part of 'quiz_bloc.dart';

abstract class QuizState extends Equatable {
  const QuizState();
}

class QuizInitial extends QuizState {
  @override
  List<Object> get props => [];
}

class QuizStartedState extends QuizState {
  final List<Question> questions;

  const QuizStartedState({required this.questions});

  @override
  List<Object?> get props => [questions];
}

class QuizFinishedState extends QuizState {
  final List<Question> questions;
  final int score;

  const QuizFinishedState({required this.questions, required this.score});

  @override
  List<Object?> get props => [questions, score];
}
