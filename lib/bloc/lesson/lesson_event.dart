part of 'lesson_bloc.dart';


abstract class LessonEvent {}

class LoadLesson extends LessonEvent{
  final String courseId;
  final String moduleId;
  final String lessonId;

  LoadLesson({required this.courseId, required this.moduleId, required this.lessonId});

}

class ChangeQuestionState extends LessonEvent {
  final bool state;
  final int index;

  ChangeQuestionState({required this.state, required this.index});
}
