import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_maker/models/Code.dart';
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

  //Quiz
  Future addQuiz(Quiz quiz) async {
    //get auto id for quiz
    DocumentReference quizRef = quizs.doc();
    quiz.id = quizRef.id;
    //check code of quiz was uesd or no;
    Quiz checkQuiz = Quiz(id: '', code: '', imageURL: '', title: '');
    await getQuizByCode(quiz.code).then((value) =>
        checkQuiz = value,
    );
    if(checkQuiz.id != '')
      return "Code was uesd";
    //add codQuiz into users code
    await quizRef
        .set(quiz.toMap())
        .then((value) => print('add quizcode completed'));
    DocumentReference codeRef = users.doc(uid).collection('codeQuizs').doc();
    var code = Code(id: "", code: quiz.code);
    code.id = codeRef.id;
    await codeRef.set(code.toMap()).then((value) => print('add code to users'));
  }

  Future<Quiz> getQuizByCode(String code) async {
    //get quiz when user enter code
    Quiz quiz = Quiz(id: '', code: '', imageURL: '', title: '');
    await quizs.where('code', isEqualTo: code).get().then((value) => {
          if (value.docs.isNotEmpty)
            quiz = Quiz.fromMap(value.docs.first.data() as Map<String, dynamic>)
        });
    print('quiz id: ' + quiz.id);
    return quiz;
  }

  Future deleteQuiz(Quiz quiz, String uid, List<Question> listQues) async {
    //delete collection 'question' of quiz in firebase
    listQues.forEach((element) {
      quizs.doc(quiz.id).collection('questions').doc(element.id).delete();
    });
    //get list result of quiz in firebase
    List<Result> listResult = [];
    await getListResultOfQuiz(quiz, uid).then(
      (value) => listResult = value,
    );
    //delete collection 'results' of quiz in firebase
    listResult.forEach((element) {
      quizs.doc(quiz.id).collection('results').doc(element.id).delete();
    });
    //delete quiz
    await quizs.doc(quiz.id).delete();
    //get code of quiz in currently user
    Code c = Code(id: "", code: "");

    await users
        .doc(uid)
        .collection('codeQuizs')
        .where('code', isEqualTo: quiz.code)
        .get()
        .then((value) => c = Code.fromMap(value.docs.first.data()));
    print(c.id);
    //delete code in user data
    await users.doc(uid).collection('codeQuizs').doc(c.id).delete();
    return "deleted quiz";
  }

  //Question
  Future addQuestion(Question question, String idQuiz) async {
    DocumentReference quesRef = quizs.doc(idQuiz).collection('questions').doc();
    question.id = quesRef.id;
    await quesRef
        .set(question.toMap())
        .then((value) => print('add question completed'))
        .catchError((error) => print(error));
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
    late List<Quiz> listQuiz = [];
    List<String> listIdCodeQuiz = [];
    await users.doc(uid).collection('codeQuizs').get().then((value) => {
          value.docs.toList().forEach((element) {
            listIdCodeQuiz.add(element.data()['code']);
          })
        });
    for (int i = 0; i < listIdCodeQuiz.length; i++) {
      await getQuizByCode(listIdCodeQuiz[i]).then((value) => {
            listQuiz.add(value),
          });
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

  Future<List<Result>> getReult(Quiz quiz, String userid) async {
    List<Result> listRes = [];
    await quizs
        .doc(quiz.id)
        .collection('results')
        .where('userid', isEqualTo: userid)
        .get()
        .then((value) =>
            {value.docs.map((e) => listRes.add(Result.fromMap(e.data())))});
    print('quiz id: ' + quiz.id);
    return listRes;
  }

  Future<int> getTimes(Quiz quiz) async {
    int times = 0;
    await quizs
        .doc(quiz.id)
        .collection('results')
        .where('userid', isEqualTo: uid)
        .get()
        .then((value) => times = value.docs.length);
    return times;
  }

  Future<List<Result>> getListResultOfQuiz(Quiz quiz, String userid) async {
    List<Result> listRes = [];
    await quizs.doc(quiz.id).collection('results').get().then((value) => {
          value.docs.toList().forEach((element) {
            listRes.add(Result.fromMap(element.data()));
          }),
        });
    return listRes;
  }
}
