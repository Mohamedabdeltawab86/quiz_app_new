import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_new/data/models/course.dart';
import 'package:quiz_app_new/data/models/lesson.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/add_lesson_data_model.dart';
import '../../data/models/module.dart';
import '../../utils/common_functions.dart';

part 'courses_event.dart';

part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final Course? course;

  CoursesBloc({this.course}) : super(CourseInitial()) {
    if (course != null) initCourse();

    on<AddCourse>(_addCourse);
    on<FetchCourses>(_fetchCourses);
    on<SelectCourse>(_selectCourse);
    on<AddModule>(_addModule);
    on<AddLesson>(_addLesson);
    on<DeleteModule>(_deleteModule);
    on<DeleteLesson>(_deleteLesson);

  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // TODO 2: Add image of the course
  final courseKey = GlobalKey<FormState>();
  List<Course> courses = [];
  List<ModuleData> addEditModulesData = [];

  Future<void> initCourse() async {
    titleController.text = course!.title;
    courses = await readCoursesFromDB();
  }
  Course getCourseByID(String id){
    return courses.firstWhere((course) => course.id == id);
  }

  Future<void> _selectCourse(
      SelectCourse event, Emitter<CoursesState> emit) async {
    emit(CourseInitial());
    final modules = await getModules(event.course.id.toString());
    final lessons = await getLesson(
      event.course.id.toString(),
      modules.first.id.toString(),
    );
    emit(
      CourseSelected(
        event.course,
        modules: modules,
        lessons: lessons,
      ),
    );
  }

  Future<void> _addCourse(AddCourse event, Emitter<CoursesState> emit) async {
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

      List<(Module, List<Lesson>)> modulesData = addEditModulesData.map((m) {
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
      FetchCourses event, Emitter<CoursesState> emit) async {
    emit(CourseFetching());
    courses = await readCoursesFromDB();
    emit(CourseFetched());
  }

  void _addModule(AddModule event, Emitter<CoursesState> emit) {
    addEditModulesData.add(
      ModuleData(
        nameController: TextEditingController(),
        lessons: [],
      ),
    );
    emit(ModuleAdded());
  }

  void _addLesson(AddLesson event, Emitter<CoursesState> emit) {
    addEditModulesData[event.moduleIndex].lessons.add(
          LessonData(
            lessonTitleController: TextEditingController(),
            lessonContentController: TextEditingController(),
          ),
        );
    emit(LessonAdded());
  }

  void _deleteModule(DeleteModule event, Emitter<CoursesState> emit) {
    addEditModulesData.removeAt(event.index);
    emit(LessonDeleted());
  }

  void _deleteLesson(DeleteLesson event, Emitter<CoursesState> emit) {
    addEditModulesData[event.moduleIndex].lessons.removeAt(event.lessonIndex);
    emit(LessonDeleted());
  }

  void clearCourseTextFields() {
    titleController.text = '';
    descriptionController.text = '';
    for (var module in addEditModulesData) {
      module.nameController.dispose();
      for (var lesson in module.lessons) {
        lesson.lessonTitleController.dispose();
        lesson.lessonContentController.dispose();
      }
    }
    addEditModulesData.clear();
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    return super.close();
  }
}
