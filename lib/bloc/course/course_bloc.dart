import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_new/data/models/course.dart';
import 'package:quiz_app_new/data/models/lesson.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/add_lesson_data_model.dart';
import '../../data/models/module.dart';
import '../../utils/common_functions.dart';

part 'course_event.dart';

part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final Course? course;

  CourseBloc({this.course}) : super(CourseInitial()) {
    if (course != null) initCourse();

    on<AddCourse>(_addCourse);
    on<FetchCourses>(_fetchCourses);
    on<AddModule>(_addModule);
    on<AddLesson>(_addLesson);
    on<DeleteModule>(_deleteModule);
    on<DeleteLesson>(_deleteLesson);
  }

  List<Course> courses = [];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // TODO 2: Add image of the course
  final courseKey = GlobalKey<FormState>();
  List<ModuleData> addEditmodulesData = [];

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
      List<(Module, List<Lesson>)> modulesData = addEditmodulesData.map((m) {
        final now = DateTime.now();
        final Module module = Module(
          id: const Uuid().v4(),
          title: m.nameController.text,
          createdAt: now,
          updatedAt: now,
        );
        final List<Lesson> lessons = m.lessons.map((l) {
          return Lesson(
            id: const Uuid().v4(),
            title: l.lessonTitleController.text,
            content: l.lessonContentController.text,
            createdAt: now,
            updatedAt: now,
            moduleId: module.id,
          );
        }).toList();
        return (module, lessons);
      }).toList();
      await saveCourseInDB(course, modulesData);
      emit(AddingCourseDone());
    }
  }

  Future<void> _fetchCourses(
      FetchCourses event, Emitter<CourseState> emit) async {
    emit(CourseFetching());
    courses = await readCoursesFromDB();
    emit(CourseFetched());
  }

  void _addModule(AddModule event, Emitter<CourseState> emit) {
    addEditmodulesData.add(
      ModuleData(
        nameController: TextEditingController(),
        lessons: [],
      ),
    );
    emit(ModuleAdded());
  }

  void _addLesson(AddLesson event, Emitter<CourseState> emit) {
    addEditmodulesData[event.moduleIndex].lessons.add(
          LessonData(
            lessonTitleController: TextEditingController(),
            lessonContentController: TextEditingController(),
          ),
        );
    emit(LessonAdded());
  }

  void _deleteModule(DeleteModule event, Emitter<CourseState> emit) {
    addEditmodulesData.removeAt(event.index);
    emit(LessonDeleted());
  }

  void _deleteLesson(DeleteLesson event, Emitter<CourseState> emit) {
    addEditmodulesData[event.moduleIndex].lessons.removeAt(event.lessonIndex);
    emit(LessonDeleted());
  }

  void clearCourseTextFields() {
    titleController.text = '';
    descriptionController.text = '';
    for (var module in addEditmodulesData) {
      module.nameController.dispose();
      for (var lesson in module.lessons) {
        lesson.lessonTitleController.dispose();
        lesson.lessonContentController.dispose();
      }
    }
    addEditmodulesData.clear();
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    return super.close();
  }
}
