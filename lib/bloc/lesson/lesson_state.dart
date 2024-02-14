part of 'lesson_bloc.dart';


abstract class LessonState {}

class LessonInitial extends LessonState {}

class LessonLoading extends LessonState{}
class LessonError extends LessonState{
  final String error;

  LessonError(this.error);
}

class LessonLoaded extends LessonState{
  final Lesson lesson;

  LessonLoaded(this.lesson);
}