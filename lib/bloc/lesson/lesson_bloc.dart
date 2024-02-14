import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:quiz_app_new/utils/common_functions.dart';

import '../../data/models/lesson.dart';

part 'lesson_event.dart';
part 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  LessonBloc() : super(LessonInitial()) {
    on<LoadLesson>(_onLoadLesson);
  }

  Future<void> _onLoadLesson(LoadLesson event, Emitter<LessonState>emit)async{
    emit(LessonLoading());

    try{
      final Lesson lesson = await getLesson(event.courseId, event.moduleId, event.lessonId);
      emit(LessonLoaded(lesson));
    }catch(e){
      emit(LessonError(e.toString()));
    }

  }

}
