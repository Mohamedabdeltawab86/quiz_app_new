part of 'lesson_bloc.dart';


abstract class LessonEvent {}

class LoadLesson extends LessonEvent{
  final String courseId;
  final String moduleId;
  final String lessonId;

  LoadLesson({required this.courseId, required this.moduleId, required this.lessonId});

}
