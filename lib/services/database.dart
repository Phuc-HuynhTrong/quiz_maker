import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_maker/models/Question.dart';
import 'package:quiz_maker/models/Quiz.dart';

class DatabaseService {
  final String uid;
  DatabaseService({
    required this.uid,
  });
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference quizs =
      FirebaseFirestore.instance.collection('quizs');

  Future addFirstQuiz(Quiz quiz) async {
    //get auto id for quiz
    DocumentReference quizRef = quizs.doc();
    quiz.id = quizRef.id;
    //add codQuiz into users code
    await quizRef
        .set(quiz.toMap())
        .then((value) => print('add quizcode complete'));
  }
}
