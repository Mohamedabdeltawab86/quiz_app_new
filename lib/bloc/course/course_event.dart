part of 'course_bloc.dart';

@immutable
abstract class CourseEvent {}

class AddCourse extends CourseEvent{}
class FetchCourses extends CourseEvent{

}
