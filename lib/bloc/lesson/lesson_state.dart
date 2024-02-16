part of 'lesson_bloc.dart';


abstract class LessonState {}

class LessonInitial extends LessonState {}

class LessonLoading extends LessonState{}
class LessonError extends LessonState{}
class QuestionStateChanged extends LessonState{
  final int index;

  QuestionStateChanged(this.index);
}

class LessonLoaded extends LessonState{
  final List<Question> questions;

  LessonLoaded(this.questions);
}