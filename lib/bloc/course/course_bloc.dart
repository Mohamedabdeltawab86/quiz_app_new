import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_new/data/models/module.dart';
import 'package:quiz_app_new/utils/common_functions.dart';

import '../../data/models/course.dart';
import '../../utils/constants.dart';

part 'course_event.dart';

part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final Course course;
  CourseBloc(this.course) : super(CourseInitial()) {
    on<LoadModules>(_loadModules);
    on<DeleteModule>(_deleteModule);

    // send event after registering the event handler.
    add(LoadModules());
  }

  Future<void> _loadModules(
    LoadModules event,
    Emitter<CourseState> emit,
  ) async {
    emit(ModulesLoading());
    final List<Module> modules = await getModules(course.id!);
    emit(ModulesLoaded(modules));
  }

  Future<void> _deleteModule(
      DeleteModule event, Emitter<CourseState> emit) async {
    emit(DeletingModuleLoading());
    await FirebaseFirestore.instance
        .collection(coursesCollection)
        .doc(course.id)
        .collection(modulesCollection)
        .doc(event.moduleID)
        .delete();
    add(LoadModules());
  }
}
