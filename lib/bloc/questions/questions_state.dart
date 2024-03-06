part of 'questions_bloc.dart';

@immutable
abstract class QuestionsState {}

class QuestionsInitial extends QuestionsState {}
class QuestionAdding extends QuestionsState{}
class QuestionAdded extends QuestionsState{}
class QuestionError extends QuestionsState{}

class QuestionDeleting extends QuestionsState{}
class QuestionDeleted extends QuestionsState{}
class QuestionDeleteError extends QuestionsState{}

class QuestionUpdating extends QuestionsState{}
class QuestionUpdated extends QuestionsState{}
class QuestionUpdateError extends QuestionsState{}

class AddingChoice extends QuestionsState{}
class ChoiceAdded extends QuestionsState{}
class ChoiceAdditionError extends QuestionsState{}


class ChoiceDeleting extends QuestionsState{}
class ChoiceDeleted extends QuestionsState{}
class ChoiceDeletionError extends QuestionsState{}

class CorrectAnswerChanged extends QuestionsState{}