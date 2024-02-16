import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:quiz_app_new/utils/common_functions.dart';

import '../../data/models/question.dart';

part 'lesson_event.dart';

part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  LessonBloc() : super(LessonInitial()) {
    on<LoadLesson>(_onLoadLesson);
    on<ChangeQuestionState>(_onChangeQuestionState);
  }

  List<bool> questionsState = [];

  void _onChangeQuestionState(event,Emitter<LessonState> emit) {
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
      emit(LessonLoaded(questions));
    } catch (e) {
      log(e.toString());
      emit(LessonError());
    }
  }

}
