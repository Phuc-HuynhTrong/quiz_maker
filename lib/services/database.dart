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

  Future addQuiz(Quiz quiz) async {
    //get auto id for quiz
    DocumentReference quizRef = quizs.doc();
    quiz.id = quizRef.id;
    //add codQuiz into users code
    await quizRef
        .set(quiz.toMap())
        .then((value) => print('add quizcode completed'));
    DocumentReference codeRef = users.doc(uid).collection('codeQuizs').doc();
    await codeRef
        .set(quiz.toMapCode())
        .then((value) => print('add code to users'));
  }

  Future addQuestion(Question question, String idQuiz) async {
    DocumentReference quesRef = quizs.doc(idQuiz).collection('questions').doc();
    question.id = quesRef.id;
    await quesRef
        .set(question.toMap())
        .then((value) => print('add question completed'))
        .catchError((error) => print(error));
  }

  Future<Quiz> getQuizByCode(String code) async {
    Quiz quiz = Quiz(id: '', code: '', imageURL: '', title: '');
    await quizs.where('code', isEqualTo: code).get().then((value) =>
        quiz = Quiz.fromMap(value.docs.first.data() as Map<String, dynamic>));
    print('quiz id: ' + quiz.id);
    return quiz;
  }

  Future<List<Question>> getQuestionsbyQuizid(Quiz quiz) async {
    List<Question> list = [];
    await quizs.doc(quiz.id).collection('questions').get().then((value) =>
        {value.docs.map((e) => list.add(Question.fromMap(e.data())))});
    return list;
  }

  Future<List<Quiz>> getListQuizOfUser() async {
    List<Quiz> listQuiz = [];
    List<String> listIdCodeQuiz = [];
    await users.doc(uid).collection('codeQuizs').get().then((value) => {
          value.docs
              .map((e) => listIdCodeQuiz.add(e.data().entries.first.value))
        });
    for (int i = 0; i < listIdCodeQuiz.length; i++) {
      Quiz q = getQuizByCode(listIdCodeQuiz[i]) as Quiz;
      listQuiz.add(q);
    }
    return listQuiz;
  }
}
