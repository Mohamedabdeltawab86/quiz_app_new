part of 'questions_bloc.dart';

@immutable
abstract class QuestionsEvent {}

class AddQuestion extends QuestionsEvent {}

class UpdateQuestion extends QuestionsEvent {
  final String id;

  UpdateQuestion(this.id);
}

class DeleteQuestion extends QuestionsEvent {
  final String id;

  DeleteQuestion(this.id);
}

class SetCorrectAnswer extends QuestionsEvent {
  final int id;

  SetCorrectAnswer(this.id);
}


class AddChoice extends QuestionsEvent {}

class RemoveChoice extends QuestionsEvent {
  final int choiceIndex;

  RemoveChoice(this.choiceIndex);
}
