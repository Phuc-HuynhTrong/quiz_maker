import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_maker/models/Question.dart';
import 'package:quiz_maker/models/Quiz.dart';
import 'package:quiz_maker/models/result.dart';

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
    await quizs.where('code', isEqualTo: code).get().then((value) => {
          if (value.docs.isNotEmpty)
            quiz = Quiz.fromMap(value.docs.first.data() as Map<String, dynamic>)
        });
    print('quiz id: ' + quiz.id);
    return quiz;
  }

  Future<List<Question>> getQuestionsbyQuizid(Quiz quiz) async {
    List<Question> list = [];
    List<QueryDocumentSnapshot<Map<String, dynamic>>> listcache = [];
    await quizs.doc(quiz.id).collection('questions').get().then((value) => {
          listcache = value.docs.toList(),
        });
    for (int i = 0; i < listcache.length; i++) {
      list.add(Question.fromMap(listcache[i].data()));
    }
    print(quiz.id);
    print('list lenght ' + list.length.toString());
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

  //start with Result
  Future addResult(Quiz quiz, Result result) async {
    //get auto id for quiz
    DocumentReference resultRef =
        quizs.doc(quiz.id).collection('results').doc();
    result.id = resultRef.id;
    //add codQuiz into users code
    await resultRef
        .set(result.toMap())
        .then((value) => print('add result completed'));
  }

  Future<Result> getReult(Quiz quiz, String userid) async {
    Result result = Result(id: '', score: 0, times: 0, userid: userid);
    await quizs
        .doc(quiz.id)
        .collection('results')
        .where('userid', isEqualTo: userid)
        .get()
        .then((value) => result = Result.fromMap(value.docs.first.data()));
    print('quiz id: ' + quiz.id);
    return result;
  }
}
