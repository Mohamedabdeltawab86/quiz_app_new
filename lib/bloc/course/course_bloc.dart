import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_new/data/models/course.dart';

import '../../utils/common_functions.dart';

part 'course_event.dart';

part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final Course? course;

  CourseBloc({this.course}) : super(CourseInitial()) {
    if (course != null) initCourse();
    //TODO: add functions
    on<AddCourse>(_addCourse);
    on<FetchCourses>(_fetchCourses);
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final courseKey = GlobalKey<FormState>();

  void initCourse() {
    titleController.text = course!.title;
  }

  Future<void> _addCourse(AddCourse event, Emitter<CourseState> emit) async {
    if (courseKey.currentState!.validate()) {
      emit(AddingCourseLoading());
      Course course = Course(
        title: titleController.text,
        description: descriptionController.text,
        createdAt: this.course?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await saveCourseInDB(course);
    emit(AddingCourseLoaded());
    }
  }
  List<Course> _fetchCourses(FetchCourses event, Emitter<CourseState>emit){

    emit(CourseFetchingState());
    List<Course> courses = readCoursesFromDB() as List<Course>;
    emit(CourseFetchedState(courses));

    return courses;

  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    return super.close();
  }
}
