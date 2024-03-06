import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_new/data/models/question.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/add_lesson_data_model.dart';
import '../../utils/common_functions.dart';
import '../../utils/constants.dart';

part 'questions_event.dart';

part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  late final QuestionScreenArguments args;

  Question? questionToEdit;

  void initInfoPage(Question? question) {
    if (question != null) {
      questionToEdit = question;
      titleController.text = question.title ?? "";
      question.options?.forEach((answer) {
        answers.add(TextEditingController(text: answer));
      });
      correctAnswerIndex = question.correctAnswer!;
    }
  }

  QuestionsBloc(this.args) : super(QuestionsInitial()) {
    on<AddQuestion>(_addQuestion);
    on<UpdateQuestion>(_updateQuestion);
    on<DeleteQuestion>(_deleteQuestion);
    on<AddChoice>(_addChoice);
    on<RemoveChoice>(_removeChoice);

    on<SetCorrectAnswer>(_setCorrectAnswer);
  }

  final TextEditingController titleController = TextEditingController();
  final questionKey = GlobalKey<FormState>();

  final List<TextEditingController> answers = [
    TextEditingController(),
    TextEditingController(),
  ];

  int correctAnswerIndex = 0;

  Future<void> _addQuestion(
      AddQuestion event, Emitter<QuestionsState> emit) async {
    emit(QuestionAdding());
    Question question = Question(
      id: const Uuid().v4(),
      title: titleController.text,
      correctAnswer: correctAnswerIndex,
      options: answers.map((e) => e.text).toList(),
      updatedAt: DateTime.now(),
      //    TODO add diff and weight
    );

    if (questionKey.currentState!.validate()) {
      try {
        addEditQuestion(question, args);
        emit(QuestionAdded());
      } catch (e) {
        emit(QuestionError());
      }
    }
  }

  Future<void> _updateQuestion(
      UpdateQuestion event, Emitter<QuestionsState> emit) async {
    emit(QuestionUpdating());
    
    questionToEdit = event.question;
    titleController.text = event.question.title ?? "";

    final List options = event.question.options?? [];
    for (int i = 0; i < options.length; i++) {
      answers[i].text = options[i];
    }
    correctAnswerIndex = event.question.correctAnswer!;
    // update question
    
    Question question = Question(
      id:questionToEdit?.id,
      title: titleController.text,
      correctAnswer: correctAnswerIndex,
      options: answers.map((e) => e.text).toList(),
      updatedAt: DateTime.now(),
    );

    if (questionKey.currentState!.validate()) {
      try {
        
        addEditQuestion(question, args);
        emit(QuestionUpdated());
      } catch (e) {
        emit(QuestionUpdateError());
      }
    }

    // await FirebaseFirestore.instance
    //     .collection(coursesCollection)
    //     .doc(args.courseId)
    //     .collection(modulesCollection)
    //     .doc(args.moduleId)
    //     .collection(lessonCollection)
    //     .doc(args.lessonId)
    //     .collection(questionCollection)
    //     .doc(event.id)
    //     .delete();
  }

  Future<void> _deleteQuestion(
      DeleteQuestion event, Emitter<QuestionsState> emit) async {
    emit(QuestionDeleting());
    await FirebaseFirestore.instance
        .collection(coursesCollection)
        .doc(args.courseId)
        .collection(modulesCollection)
        .doc(args.moduleId)
        .collection(lessonCollection)
        .doc(args.lessonId)
        .collection(questionCollection)
        .doc(event.id)
        .delete();
    emit(QuestionDeleted());
  }

  void _addChoice(AddChoice event, Emitter<QuestionsState> emit) {
    emit(AddingChoice());
    try {
      answers.add(TextEditingController());
      emit(ChoiceAdded());
    } catch (e) {
      emit(ChoiceAdditionError());
    }
  }

  void _removeChoice(RemoveChoice event, Emitter<QuestionsState> emit) {
    if (event.choiceIndex == correctAnswerIndex) {
      correctAnswerIndex = 0;
    }
    answers.removeAt(event.choiceIndex);
    emit(ChoiceDeleted());
  }

  Future<void> _setCorrectAnswer(
      SetCorrectAnswer event, Emitter<QuestionsState> emit) async {
    // Todo: set correct answer
    correctAnswerIndex = event.id;
    emit(CorrectAnswerChanged());
  }

  @override
  Future<void> close() {
    titleController.dispose();
    
    for (var controller in answers) {
      controller.dispose();
    }
    return super.close();
  }
}
