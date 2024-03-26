part of 'lesson_bloc.dart';

abstract class LessonState {}

class LessonInitial extends LessonState {}

class LessonLoading extends LessonState {}

class LessonError extends LessonState {}

class QuestionStateChanged extends LessonState {
  final int index;

  QuestionStateChanged(this.index);
}

class LessonLoaded extends LessonState {
  final List<Question> questions;
  final Map<String, int> previousAnswers;

  LessonLoaded({
    required this.questions,
    required this.previousAnswers,
  });
}

class LessonAdding extends LessonState {}

class LessonAdded extends LessonState {}

class LessonAddError extends LessonState {}

class LessonDeleting extends LessonState {}

class LessonDeleted extends LessonState {}

class LessonDeleteError extends LessonState {}

class QuestionAdding extends LessonState {}

class QuestionAdded extends LessonState {}

class QuestionError extends LessonState {}

class QuestionDeleting extends LessonState {}

class QuestionDeleted extends LessonState {}

class QuestionDeleteError extends LessonState {}

class ChoiceAdding extends LessonState {}

class ChoiceAdded extends LessonState {}

class ChoiceDeleting extends LessonState {}

class ChoiceDeleted extends LessonState {}

class OptionSelectedState extends LessonState {
  final Map<String, int?> selectedOptions;

  OptionSelectedState({required this.selectedOptions});
}

class AnswersSubmitted extends LessonState {
  final Map<String, int> correctAnswers;
  final int score;

  AnswersSubmitted({
    required this.correctAnswers,
    required this.score,
  });
}

class AnswerReset extends LessonState {}
