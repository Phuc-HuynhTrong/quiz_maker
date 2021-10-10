import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/models/Question.dart';
import 'package:quiz_maker/models/Quiz.dart';
import 'package:quiz_maker/screens/PLayQuiz/playquiz.dart';
import 'package:quiz_maker/screens/account/quizInformation.dart';
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
  List<List<Question>> listQuestion = new List.filled(100, []);
  List<Uint8List> listImage = new List.filled(100, Uint8List.fromList([0]));
  bool isLoadCode = false;
  List<String> listCode = [];
  @override
  void initState() {
    super.initState();
    databaseService = DatabaseService(uid: authService.getCurrentUser!.uid);
    getlistCode();
  }

  Future<void> getlistCode() async {
    isLoadCode = true;
    await databaseService
        .getListQuizOfUser()
        .then((value) => listQuiz = value)
        .whenComplete(() => {
              if (listQuiz.length == 0)
                {
                  setIsLoadingCode(),
                }
              else
                {
                  for (int i = 0; i < listQuiz.length; i++)
                    {
                      listCode.add(listQuiz[i].code),
                    },
                  setIsLoadingCode()
                }
            });
  }

  void getData(List<Quiz> lq) {
    for (int i = 0; i < lq.length; i++) {
      getQuestionList(lq, i);
      getImage(lq, i);
    }
  }

  Future setIsLoadingCode() async {
    setState(() {
      isLoadCode = false;
    });
  }

  Future<void> getImage(List<Quiz> lq, int index) async {
    try {
      await storage
          .loadImages(lq[index].imageURL)
          .then((value) => listImage[index] = value)
          .whenComplete(() => print('get image completed'));
    } catch (e) {
      print(e);
    }
  }

  Future<void> getQuestionList(List<Quiz> lq, int index) async {
    await databaseService
        .getQuestionsbyQuizid(lq[index])
        .then((value) => listQuestion[index] = value)
        .whenComplete(() => print('getQuestion completed'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff09103b),
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
        body: isLoadCode
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : listCode.length == 0
                ? Container(
                    color: Colors.transparent,
                  )
                : StreamBuilder<List<Quiz>>(
                    stream: databaseService.streamQuiz(listCode),
                    builder: (context, snapshot) {
                      List<Quiz> list = snapshot.data ?? [];
                      getData(list);
                      print("list l: " + list.length.toString());
                      return listImage[list.length == 0 ? 0: list.length - 1] ==
                              Uint8List.fromList([0])
                          ? Container(
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    quizInformation(
                                                      quiz: list[index],
                                                      listQuestion:
                                                          listQuestion[index],
                                                      userId: authService
                                                          .getCurrentUser!.uid,
                                                    )));
                                      },
                                      child: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 20, 0, 0),
                                          height: 100,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              120,
                                          decoration: BoxDecoration(
                                            image:
                                                listImage[index].toString() ==
                                                        Uint8List.fromList([0])
                                                            .toString()
                                                    ? null
                                                    : DecorationImage(
                                                        image: MemoryImage(
                                                            listImage[index]),
                                                        fit: BoxFit.fill,
                                                      ),
                                            border: Border.all(
                                                color: Colors.white, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            122,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            25),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        25))),
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              20, 0, 0, 0),
                                                      child: Text(
                                                        list[index].title,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6!
                                                            .copyWith(
                                                                color: Color(
                                                                    0xffe41ceb)),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          )),
                                    ),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 20, 0, 0),
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            color: Color(0xfffaf8aa),
                                            border: Border.all(
                                                color: Color(0xfff3fc38),
                                                width: 3),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: TextButton(
                                            onPressed: () async {
                                              await getQuestionList(
                                                  list, index);
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        PlayQuiz(
                                                            listQuestion:
                                                                listQuestion[
                                                                    index],
                                                            quiz: list[index]),
                                                  ));
                                            },
                                            child: Text(
                                              'Start',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      color: Colors.black87),
                                            ))),
                                  ],
                                );
                              });
                    }));
  }
}
