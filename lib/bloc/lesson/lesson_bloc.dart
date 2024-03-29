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
  late final QuestionScreenArguments args;

  LessonBloc({this.question}) : super(LessonInitial()) {
    on<LoadLesson>(_onLoadLesson);
    on<UpdateLesson>(_updateLesson);
    on<DeleteLesson>(_deleteLesson);
    on<AddLesson>(_addLesson);
    on<DeleteQuestion>(_deleteQuestion);
    on<ChangeQuestionState>(_onChangeQuestionState);
    on<OptionSelected>(_onOptionSelected);
    on<SubmitAnswers>(_onSubmitAnswers);
    on<ResetAnswers>(_resetAnswers);
  }

  final lessonKey = GlobalKey<FormState>();
  List<bool> questionsState = [];
  Map<String, int?> selectedOptions = {};
  List<bool> questionSelected = [];
  // questionSelected = List.filled(questions.length, false);

  Future<void> _onSubmitAnswers(
      SubmitAnswers event, Emitter<LessonState> emit) async {
    final Map<String, int> answers = {};
    int score = 0;

    final questions = event.questionList;
    for (final question in questions) {
      final selectedOptionIndex = selectedOptions[question.id];
      final isCorrect = selectedOptionIndex == question.correctAnswer;
      // TODO: make sure all answers are not null
      answers[question.id!] = selectedOptionIndex!;
      if (isCorrect) {
        score++;
      }
    }
    await saveUserAnswers(
      event.courseId,
      event.moduleId,
      event.lessonId,
      answers,
    );
    emit(AnswersSubmitted(score: score, correctAnswers: answers));
  }

  void _onOptionSelected(OptionSelected event, Emitter<LessonState> emit) {
    selectedOptions[event.questionId] = event.optionIndex;

    // questionSelected[event.questionIndex] = true;
    emit(OptionSelectedState(selectedOptions: selectedOptions));
  }

  bool isSubmitEnabled() {
    return questionSelected.every((element) => element);
  }

  void _onChangeQuestionState(event, Emitter<LessonState> emit) {
    questionsState[event.index] = event.state;
    emit(QuestionStateChanged(event.index));
  }
    void _resetAnswers(ResetAnswers event, Emitter<LessonState>emit)
    {
      selectedOptions.clear();
      emit(OptionSelectedState(selectedOptions: selectedOptions));
    }

  Future<void> _onLoadLesson(
      LoadLesson event, Emitter<LessonState> emit) async {
    emit(LessonLoading());
    try {
      debugPrint(event.lessonId);
      final questions = await getQuestions(
        event.courseId,
        event.moduleId,
        event.lessonId,
      );
      // debugPrint(questions as String?);
      // for (int i = 0; i < questions.length; i++) {
      //   questionsState.add(false);
      // }
      final previousAnswers = await getPreviousAnswers(
        event.courseId,
        event.moduleId,
        event.lessonId,
      );
      emit(LessonLoaded(questions: questions, previousAnswers: previousAnswers));
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

  Future<void> _deleteQuestion(
      DeleteQuestion event, Emitter<LessonState> emit) async {
    emit(QuestionDeleting());
    await FirebaseFirestore.instance
        .collection(coursesCollection)
        .doc(event.courseId)
        .collection(modulesCollection)
        .doc(event.moduleId)
        .collection(lessonCollection)
        .doc(event.lessonId)
        .collection(questionCollection)
        .doc(event.question.id)
        .delete();
    emit(QuestionDeleted());
  }

  // Future<void> _setCorrectAnswer(
  //     SetCorrectAnswer event, Emitter<LessonState> emit) async {}

// @override
// Future<void> close() {
//   titleController.dispose();
//   choiceController.dispose();
//   return super.close();
// }
}
