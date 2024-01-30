import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_new/data/models/course.dart';
import 'package:quiz_app_new/data/models/lesson.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/add_lesson_data_model.dart';
import '../../utils/common_functions.dart';

part 'course_event.dart';

part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final Course? course;

  CourseBloc({this.course}) : super(CourseInitial()) {
    if (course != null) initCourse();

    on<AddCourse>(_addCourse);
    on<FetchCourses>(_fetchCourses);
    on<AddLesson>(_addLesson);
    on<DeleteLesson>(_deleteLesson);
  }

  List<Course> courses = [];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // TODO 2: Add image of the course
  final courseKey = GlobalKey<FormState>();
  List<AddLessonDataModel> lessonsData = [];

  void initCourse() {
    titleController.text = course!.title;
  }

  Future<void> _addCourse(AddCourse event, Emitter<CourseState> emit) async {
    if (courseKey.currentState!.validate()) {
      emit(AddingCourseLoading());
      Course course = Course(
        id: const Uuid().v4(),
        title: titleController.text,
        description: descriptionController.text,
        createdAt: this.course?.createdAt ?? DateTime.now(),
        createdBy: getUid(),
        updatedAt: DateTime.now(),
      );
      List<Lesson> lessons = lessonsData.map((e) {
        return Lesson(
          id: const Uuid().v4(),
          title: e.lessonTitleController.text,
          content: e.lessonContentController.text,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
      }).toList();
      await saveCourseInDB(course, lessons);
      emit(AddingCourseDone());
    }
  }

  Future<void> _fetchCourses(
      FetchCourses event, Emitter<CourseState> emit) async {
    emit(CourseFetching());
    courses = await readCoursesFromDB();
    emit(CourseFetched());
  }

  void _addLesson(AddLesson event, Emitter<CourseState> emit) {
    lessonsData.add(
      AddLessonDataModel(
        lessonTitleController: TextEditingController(),
        lessonContentController: TextEditingController(),
      ),
    );
    emit(LessonAdded());
  }

  void _deleteLesson(DeleteLesson event, Emitter<CourseState> emit) {
    lessonsData.removeAt(event.index);
    emit(LessonDeleted());
  }

  void clearCourseTextFields(){
    titleController.text = '';
    descriptionController.text = '';
    for(var lessonData in lessonsData){
      lessonData.lessonContentController.dispose();
      lessonData.lessonTitleController.dispose();
    }
    lessonsData.clear();
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    return super.close();
  }
}
