import 'package:flutter/material.dart';
import 'package:quiz_maker/models/Question.dart';
import 'package:quiz_maker/models/Quiz.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/services/database.dart';

class quizInformation extends StatefulWidget {
  final userId;
  final Quiz quiz;
  final List<Question> listQuestion;
  quizInformation(
      {Key? key, required this.listQuestion, required this.quiz, this.userId})
      : super(key: key);

  @override
  _quizInformation createState() => _quizInformation();
}

class _quizInformation extends State<quizInformation> {
  late Quiz quiz;
  late List<Question> listQues;
  AuthService authService = AuthService();
  late DatabaseService databaseService;
  @override
  void initState() {
    quiz = widget.quiz;
    listQues = widget.listQuestion;
    databaseService = DatabaseService(uid: authService.getCurrentUser!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff09103b),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Quiz: " + quiz.title),
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {
                databaseService.deleteQuiz(quiz, widget.userId, listQues);
                Navigator.pop(context);
                //return 'delete quiz';
              },
              child: Text(
                'delete',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
