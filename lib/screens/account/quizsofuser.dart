import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/models/Question.dart';
import 'package:quiz_maker/models/Quiz.dart';
import 'package:quiz_maker/screens/PLayQuiz/playquiz.dart';
import 'package:quiz_maker/screens/PLayQuiz/playquizhome.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/services/database.dart';
import 'package:quiz_maker/services/storage.dart';
import 'package:quiz_maker/widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuizOfUser extends StatefulWidget {
  const QuizOfUser({Key? key}) : super(key: key);

  @override
  _QuizOfUserState createState() => _QuizOfUserState();
}

class _QuizOfUserState extends State<QuizOfUser> {
  List<Quiz> listQuiz = [];
  AuthService authService = AuthService();
  late DatabaseService databaseService;
  Storage storage = new Storage();
  List<Question> list = [];
  var image;
  Future<void> getData() async {
    await databaseService.getListQuizOfUser().then((value) => listQuiz = value);
    //print('lenght list:' + listQuiz.length.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseService = DatabaseService(uid: authService.getCurrentUser!.uid);
    getData();
  }

  Future<void> getImage(int index) async {
    await storage
        .loadImages(listQuiz[index].imageURL)
        .then((value) => image = value);
  }

  Future<void> getQuestionList(int index) async {
    await databaseService
        .getQuestionsbyQuizid(listQuiz[index])
        .then((value) => list = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1d2859),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
          ),
          backgroundColor: Color(0xff1d2859),
          elevation: 0.0,
          centerTitle: true,
          title: Container(
              child: Column(
            children: [
              appBar(context),
              Text(
                'Your quizs',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              )
            ],
          )),
        ),
        body: ListView.builder(
            itemCount: listQuiz.length,
            itemBuilder: (context, index) {
              getImage(index);
              return Row(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      height: 100,
                      width: MediaQuery.of(context).size.width - 100,
                      decoration: BoxDecoration(
                        image: image != null
                            ? DecorationImage(
                                image: MemoryImage(image),
                                fit: BoxFit.fill,
                              )
                            : null,
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                listQuiz[index].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: Color(0xffe41ceb)),
                              )
                            ],
                          ),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      height: 80,
                      decoration: BoxDecoration(
                          color: Color(0xfffaf8aa),
                          border:
                              Border.all(color: Color(0xfff3fc38), width: 3),
                          borderRadius: BorderRadius.circular(25)),
                      child: TextButton(
                          onPressed: () async {
                            await getQuestionList(index);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PlayQuiz(
                                          listQuestion: list,
                                          quiz: listQuiz[index]),
                                ));
                          },
                          child: Text(
                            'Start',
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.black87),
                          ))),
                ],
              );
            }));
  }
}
