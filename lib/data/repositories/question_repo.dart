import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/question.dart';

class QuestionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Question> getQuestionById(String questionId) async {
    final docRef = _firestore
        .collection('teachers')
        .doc('teacherId') // Replace with actual teacher ID
        .collection('courses')
        .doc('courseId') // Replace with actual course ID
        .collection('quizzes')
        .doc('quizId') // Replace with actual quiz ID
        .collection('questions')
        .doc(questionId.toString());

    final snapshot = await docRef.get();
    if (snapshot.exists) {
      return Question.fromJson(snapshot.data()!);
    } else {
      throw Exception('Question not found');
    }
  }
}