import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/models/Question.dart';
import 'package:quiz_maker/models/Quiz.dart';
import 'package:quiz_maker/screens/PLayQuiz/playquiz.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/services/database.dart';
import 'package:quiz_maker/services/storage.dart';
import 'package:quiz_maker/widgets/appbar.dart';

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
  List<List<Question>> listQuestion = [];
  List<Uint8List> listImage = [];
  bool isLoadingImage = false;
  bool isLoadingQues = false;
  bool synchronized = false;
  Future<void> getData() async {
    isLoadingImage = true;
    isLoadingQues = true;
    await databaseService
        .getListQuizOfUser()
        .then((value) => listQuiz = value)
        .whenComplete(() => {
              print('list quiz leng: ' + listQuiz.length.toString()),
              for (int i = 0; i < listQuiz.length; i++)
                {
                  if (!synchronized)
                    {
                      if (listQuestion.length != i + 1) getQuestionList(i),
                      if (listImage.length != i + 1) getImage(i),
                    }
                }
            });
  }

  @override
  void initState() {
    isLoadingImage = false;
    isLoadingQues = false;
    super.initState();
    databaseService = DatabaseService(uid: authService.getCurrentUser!.uid);
    getData();
  }

  Future<void> getImage(int index) async {
    await storage
        .loadImages(listQuiz[index].imageURL)
        .then((value) => listImage.add(value))
        .whenComplete(() => print('get image completed'));
    setState(() {
      if (listQuestion.length == index + 1 && listImage.length == index + 1)
        synchronized = true;
    });
    if (index == listQuiz.length - 1) {
      setState(() {
        isLoadingImage = false;
      });
    }
  }

  Future<void> getQuestionList(int index) async {
    await databaseService
        .getQuestionsbyQuizid(listQuiz[index])
        .then((value) => listQuestion.add(value))
        .whenComplete(() => print('getQuestion completed'));
    setState(() {
      if (listQuestion.length == index + 1 && listImage.length == index + 1)
        synchronized = true;
    });
    if (index == listQuiz.length - 1)
      setState(() {
        isLoadingQues = false;
      });
    print('list ques leng ' + listQuestion[0].length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1d2859),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
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
            ],
          ),
        ),
        body: isLoadingImage || isLoadingQues
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : ListView.builder(
                itemCount: listQuiz.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          height: 100,
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: BoxDecoration(
                            image: listImage.length-1 < index
                                ? null
                                : DecorationImage(
                                    image: MemoryImage(listImage[index]),
                                    fit: BoxFit.fill,
                                  ),
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
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width - 102,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(25),
                                            bottomLeft: Radius.circular(25))),
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: Text(
                                        listQuiz[index].title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(color: Color(0xffe41ceb)),
                                      ),
                                    ),
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
                              border: Border.all(
                                  color: Color(0xfff3fc38), width: 3),
                              borderRadius: BorderRadius.circular(25)),
                          child: TextButton(
                              onPressed: () async {
                                await getQuestionList(index);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PlayQuiz(
                                              listQuestion: listQuestion[index],
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
