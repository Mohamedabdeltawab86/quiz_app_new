import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_new/bloc/quiz/quiz_bloc.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<QuizBloc>();
    final questions = bloc.questions.values.toList();
    final currentQuestion = questions[0];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(currentQuestion.title, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 20),
        ...currentQuestion.options.map(
          (option) => RadioListTile<int>(
            title: Text(option),
            value: currentQuestion.options.indexOf(option),
            groupValue: context.read<QuizBloc>().answers[currentQuestion.id],
            onChanged: (value) => context.read<QuizBloc>().add(
                AnswerQuestionEvent(
                    questionId: currentQuestion.id, answer: value!)),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => context.read<QuizBloc>().add(FinishQuizEvent()),
              child: const Text('Finish Quiz'),
            ),
            // Add a button to navigate to the next question (if applicable)
          ],
        ),
      ],
    );
  }
}
