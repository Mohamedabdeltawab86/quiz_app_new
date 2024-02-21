import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:quiz_app_new/utils/common_functions.dart';
import 'package:quiz_app_new/utils/constants.dart';

import '../../data/models/add_lesson_data_model.dart';
import '../../data/models/lesson.dart';
import '../../data/models/question.dart';

part 'lesson_event.dart';

part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  Question? question;

  LessonBloc({this.question}) : super(LessonInitial()) {
    on<LoadLesson>(_onLoadLesson);
    on<UpdateLesson>(_updateLesson);
    on<DeleteLesson>(_deleteLesson);
    on<AddLesson>(_addLesson);

    on<ChangeQuestionState>(_onChangeQuestionState);


  }
  final lessonKey = GlobalKey<FormState>();
  List<bool> questionsState = [];

  void _onChangeQuestionState(event, Emitter<LessonState> emit) {
    questionsState[event.index] = event.state;
    emit(QuestionStateChanged(event.index));
  }

  Future<void> _onLoadLesson(
      LoadLesson event, Emitter<LessonState> emit) async {
    emit(LessonLoading());
    try {
      final questions = await getQuestions(
        event.courseId,
        event.moduleId,
        event.lessonId,
      );
      for (int i = 0; i < questions.length; i++) {
        questionsState.add(false);
      }
      final lessons = await getLessons(event.courseId, event.moduleId);
      emit(LessonLoaded(questions: questions, lessons: lessons));
    } catch (e) {
      log(e.toString());
      emit(LessonError());
    }
  }

  Future<void> _addLesson(AddLesson event, Emitter<LessonState> emit) async {
    if (lessonKey.currentState!.validate()) {
      emit(LessonAdding());
      try {
        await saveLesson(event.courseId, event.moduleId, event.lesson);
        emit(LessonAdded());
      } catch (e) {
        emit(LessonError());
      }
    }
  }



  Future<void> _updateLesson(
      UpdateLesson event, Emitter<LessonState> emit) async {}

  Future<void> _deleteLesson(
      DeleteLesson event, Emitter<LessonState> emit) async {
    emit(LessonDeleting());
    await FirebaseFirestore.instance
        .collection(coursesCollection)
        .doc(event.courseId)
        .collection(modulesCollection)
        .doc(event.moduleId)
        .collection(lessonCollection)
        .doc(event.lessonId)
        .delete();
    emit(LessonDeleted());
  }



  Future<void> _setCorrectAnswer(
      SetCorrectAnswer event, Emitter<LessonState> emit) async {}

  // @override
  // Future<void> close() {
  //   titleController.dispose();
  //   choiceController.dispose();
  //   return super.close();
  // }
}
