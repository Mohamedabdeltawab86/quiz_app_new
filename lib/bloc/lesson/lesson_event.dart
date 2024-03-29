part of 'lesson_bloc.dart';

abstract class LessonEvent {}

class AddLesson extends LessonEvent {
  final String courseId;
  final String moduleId;
  final Lesson lesson;

  AddLesson(
      {required this.courseId, required this.moduleId, required this.lesson});
}

class UpdateLesson extends LessonEvent {
  final String courseId;
  final String moduleId;
  final String lessonId;

  UpdateLesson(
      {required this.courseId, required this.moduleId, required this.lessonId});
}

class DeleteLesson extends LessonEvent {
  final String courseId;
  final String moduleId;
  final String lessonId;

  DeleteLesson(
      {required this.courseId, required this.moduleId, required this.lessonId});
}

class LoadLesson extends LessonEvent {
  final String courseId;
  final String moduleId;
  final String lessonId;

  LoadLesson(
      {required this.courseId, required this.moduleId, required this.lessonId});
}

class AddQuestion extends LessonEvent {
  final QuestionScreenArguments args;

  AddQuestion(this.args);
}

class UpdateQuestion extends LessonEvent {
  final String courseId;
  final String moduleId;
  final String lessonId;
  final Question question;

  UpdateQuestion(
      {required this.courseId,
      required this.moduleId,
      required this.lessonId,
      required this.question});
}

class DeleteQuestion extends LessonEvent {
  final String courseId;
  final String moduleId;
  final String lessonId;

  final Question question;

  DeleteQuestion({
    required this.courseId,
    required this.moduleId,
    required this.lessonId,
    required this.question,
  });
}

class SetCorrectAnswer extends LessonEvent {
  final String courseId;
  final String moduleId;
  final String lessonId;
  final Question question;
  final int answer;

  SetCorrectAnswer(
      {required this.courseId,
      required this.moduleId,
      required this.lessonId,
      required this.question,
      required this.answer});
}

class AddChoice extends LessonEvent {
  final int questionIndex;

  AddChoice({
    required this.questionIndex,
  });
}

class RemoveChoice extends LessonEvent {
  final int questionIndex;
  final int choiceIndex;

  RemoveChoice({
    required this.questionIndex,
    required this.choiceIndex,
  });
}

class ChangeQuestionState extends LessonEvent {
  final bool state;
  final int index;

  ChangeQuestionState({
    required this.state,
    required this.index,
  });
}

class OptionSelected extends LessonEvent {
  final String questionId;
  final int questionIndex;
  final int optionIndex;

  OptionSelected({
    required this.questionId,
    required this.questionIndex,
    required this.optionIndex,
  });
}

class SubmitAnswers extends LessonEvent {

  final List<Question> questionList;
  final String courseId;
  final String moduleId;
  final String lessonId;

  SubmitAnswers({

    required this.questionList,
    required this.courseId,
    required this.moduleId,
    required this.lessonId,
  });
}
class ResetAnswers extends LessonEvent{}
