import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:quiz_app_new/utils/common_functions.dart';
import 'package:quiz_app_new/utils/constants.dart';
import 'package:uuid/uuid.dart';

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

    // on<LoadQuestion>(_LoadQuestion);
    on<UpdateQuestion>(_updateQuestion);
    on<DeleteQuestion>(_deleteQuestion);
    on<AddQuestion>(_addQuestion);
    on<AddChoice>(_addChoice);
    on<RemoveChoice>(_removeChoice);

    on<SetCorrectAnswer>(_setCorrectAnswer);
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController choiceController = TextEditingController();
  final lessonKey = GlobalKey<FormState>();

  List<QuestionData> addEditQuestionsData = [];

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

  Future<void> _addQuestion(
      AddQuestion event, Emitter<LessonState> emit) async {
    emit(LessonAdding());
    try {
      Question question = Question(
        id: const Uuid().v4(),
        title: titleController.text,
        options: addEditQuestionsData.map((e) {
          return ChoiceData(choiceController: choiceController).toString();
        }).toList(),
        // correctAnswer:
      );
      await saveQuestion(
          event.courseId, event.moduleId, event.lessonId, question);
      emit(LessonAdded());
    } catch (e) {
      emit(LessonError());
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

  Future<void> _updateQuestion(
      UpdateQuestion event, Emitter<LessonState> emit) async {}

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

  void _addChoice(AddChoice event, Emitter<LessonState> emit) {
    emit(ChoiceAdding());
    addEditQuestionsData[event.questionIndex].choices.add(
          ChoiceData(
            choiceController: TextEditingController(),
          ),
        );
    emit(ChoiceAdded());
  }

  void _removeChoice(RemoveChoice event, Emitter<LessonState> emit) {
    emit(ChoiceDeleting());
    addEditQuestionsData[event.questionIndex]
        .choices
        .removeAt(event.choiceIndex);
    emit(ChoiceDeleted());
  }

  Future<void> _setCorrectAnswer(
      SetCorrectAnswer event, Emitter<LessonState> emit) async {}
}
