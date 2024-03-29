import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app_new/data/models/course.dart';
import 'package:quiz_app_new/data/models/lesson.dart';
import 'package:quiz_app_new/utils/constants.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/add_lesson_data_model.dart';
import '../../data/models/module.dart';
import '../../utils/common_functions.dart';

part 'courses_event.dart';

part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  Course? editCourse;

  CoursesBloc() : super(CourseInitial()) {
    on<AddCourse>(_addEditCourse);
    on<FetchCourses>(_fetchCourses);

    on<AddModule>(_addModule);
    on<AddLesson>(_addLesson);
    // add delete course
    on<DeleteCourse>(_deleteCourse);
    // edit course
    on<DeleteModule>(_deleteModule);
    on<DeleteLesson>(_deleteLesson);
    on<InitCourse>(_initCourse);
    on<CopyCourseId>(_copyCourseId);
    on<DuplicateCourse>(_duplicateCourse);
  }

  // void initInfoPage(Course course) {
  //   titleController.text = course.title;
  //   descriptionController.text = course.description ?? "";
  // }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final courseKey = GlobalKey<FormState>();
  List<Course> courses = [];
  List<ModuleData> addEditModulesData = [];

  Future<void> _initCourse(InitCourse event, Emitter<CoursesState> emit) async {
    emit(LoadingModulesAndLessons());
    editCourse = event.course;
    titleController.text = event.course.title;
    descriptionController.text = event.course.description ?? "";
    // load addEditModulesData
    final List<Module> modules = await getModules(event.course.id!);
    for (Module module in modules) {
      final List<Lesson> lessons =
          await getLessons(event.course.id!, module.id!);
      List<LessonData> lessonsData = [];
      for (Lesson lesson in lessons) {
        lessonsData.add(
          LessonData(
            // Done: loaded the lessonId here
            lessonId: lesson.id,
            lessonTitleController: TextEditingController(
              text: lesson.title,
            ),
            lessonContentController: TextEditingController(
              text: lesson.content,
            ),
          ),
        );
      }
      addEditModulesData.add(
        ModuleData(
          // Done: loaded the moduleId here
          moduleId: module.id,
          nameController: TextEditingController(text: module.title),
          lessons: lessonsData,
        ),
      );
    }
    emit(ModulesAndLessonsLoaded());
  }

  Course getCourseByID(String id) {
    return courses.firstWhere((course) => course.id == id);
  }

  Future<void> _addEditCourse(
      AddCourse event, Emitter<CoursesState> emit) async {
    if (courseKey.currentState!.validate()) {
      emit(AddingCourseLoading());
      Course course = Course(
        id: editCourse?.id ??
            const Uuid().v4().replaceAll("-", "").substring(0, 12),
        title: titleController.text,
        description: descriptionController.text,
        createdAt: editCourse?.createdAt ?? DateTime.now(),
        createdBy: getUid(),
        updatedAt: DateTime.now(),
      );

      List<(Module, List<Lesson>)> modulesData = addEditModulesData.map((m) {
        final now = DateTime.now();
        final Module module = Module(
          id: m.moduleId ?? const Uuid().v4(),
          // Done: used moduleId here after being loaded.
          title: m.nameController.text,
          createdAt: now,
          updatedAt: now,
        );
        final List<Lesson> lessons = m.lessons.map((l) {
          return Lesson(
            id: l.lessonId ?? const Uuid().v4(),
            // Done: used lessonId here after being loaded.
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

  Future<void> _deleteCourse(
      DeleteCourse event, Emitter<CoursesState> emit) async {
    emit(DeletingCourseLoading());
    await FirebaseFirestore.instance
        .collection(coursesCollection)
        .doc(event.courseId)
        .delete();
    emit(DeletingCourseSuccess());
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

  Future<void> _copyCourseId(
      CopyCourseId event, Emitter<CoursesState> emit) async {
    await Clipboard.setData(ClipboardData(text: event.courseId));
  }
    Future<void> _duplicateCourse(
      DuplicateCourse event, Emitter<CoursesState> emit) async {
    emit(CoursesDuplicationLoading());
    final Course courseToClone = getCourseByID(event.courseId);
    final String newCourseId = const Uuid().v4();

    Course newCourse = Course(
      id: newCourseId,
      title: '${courseToClone.title} - Copy',
      description: courseToClone.description,
      createdAt: DateTime.now(),
      createdBy: getUid(),
      updatedAt: DateTime.now(),
    );
    final modulesData = await _duplicateModulesAndLessons(courseToClone.id!, newCourseId);

    await saveCourseInDB(newCourse, modulesData);
    emit(CoursesDuplicationSuccess());
  }

  
     Future<List<(Module, List<Lesson>)>> _duplicateModulesAndLessons(
    String oldCourseId,
    String newCourseId,
  ) async {
    final List<Module> oldModules = await getModules(oldCourseId);
    final List<(Module, List<Lesson>)> newModulesData = [];

    for (final oldModule in oldModules) {
      final List<Lesson> oldLessons = await getLessons(oldCourseId, oldModule.id!);
      final List<Lesson> newLessons = oldLessons.map((oldLesson) {
        return Lesson(
          id: const Uuid().v4(),
          title: oldLesson.title,
          content: oldLesson.content,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          moduleId: null, // Will be set later
        );
      }).toList();

      final newModule = Module(
        id: const Uuid().v4(),
        title: oldModule.title,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // // Set moduleId for new lessons
      // for (final newLesson in newLessons) {
      //   newLesson.moduleId = newModule.id;
      // }

      newModulesData.add((newModule, newLessons));
    }

    return newModulesData;
  }


  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    return super.close();
  }
}
