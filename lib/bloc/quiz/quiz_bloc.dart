import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_app_new/data/repositories/question_repo.dart';

import '../../data/models/question.dart';
import '../../data/models/quiz.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc(this.questionRepository) : super(QuizInitial()) {
    on<StartQuizEvent>(_onStartQuiz);
    on<AnswerQuestionEvent>(_onAnswerQuestion);
    on<FinishQuizEvent>(_onFinishQuiz);
  }

  final QuestionRepository questionRepository;
  late Quiz quiz;
  late List<String> questionIds;
  Map<String, Question> questions = {};
  Map<String, int> answers = {};
  int score = 0;

  Future<void> _onStartQuiz(
      StartQuizEvent event, Emitter<QuizState> emit) async {
    quiz = event.quiz;
    questionIds = quiz.questionsIds;

    // Fetch questions from Firestore
    final fetchedQuestions = await Future.wait(
      questionIds.map((id) => questionRepository.getQuestionById(id)),
    );
    questions = Map.fromIterables(questionIds, fetchedQuestions);
    emit(QuizStartedState(questions: fetchedQuestions));
  }

  void _onAnswerQuestion(AnswerQuestionEvent event, Emitter<QuizState> emit) {
    answers[event.questionId] = event.answer;

    // Calculate score if all questions answered
    if (answers.length == questionIds.length) {
      _calculateScore();
      _resetScore(); // Reset score for potential re-takes
      emit(QuizFinishedState(
          questions: questions.values.toList(), score: score));
    }
  }
  Future<List<Question>> fetchQuestions(List<String> questionIds) async {
    final fetchedQuestions = await Future.wait(
      questionIds.map((id) => questionRepository.getQuestionById(id)),
    );
    return fetchedQuestions;
  }

  void _calculateScore() {
    score = 0;
    for (final questionId in questionIds) {
      final userAnswer = answers[questionId];
      final correctAnswer = questions[questionId]!.correctAnswer;
      if (userAnswer == correctAnswer) {
        score++;
      }
    }
  }

  void _onFinishQuiz(FinishQuizEvent event, Emitter<QuizState> emit) {
    _calculateScore();
    _resetScore();
    emit(QuizFinishedState(questions: questions.values.toList(), score: score));
  }

  void _resetScore() {
    answers = {};
    score = 0;
  }
}
