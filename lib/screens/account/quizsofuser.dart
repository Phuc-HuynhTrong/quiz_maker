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
  bool isLoadCode = true;
  List<String> listCode = [];
  int num = 0;
  late List<List<Question>> listQuestion;
  late List<Uint8List> listImage;

  @override
  void initState() {
    num = 0;
    super.initState();
    databaseService = DatabaseService(uid: authService.getCurrentUser!.uid);
    getlistCode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (int i = 0; i < listQuiz.length; i++) {
      getImage(listQuiz, i);
    }
  }

  void getlistCode() async {
    isLoadCode = true;
    await databaseService
        .getListQuizOfUser()
        .then((value) => listQuiz = value)
        .whenComplete(() => {
              listQuestion = new List.filled(100, []),
              listImage = new List.filled(100, Uint8List.fromList([0])),
              if (listQuiz.length == 0)
                {
                  setIsLoadingCode(),
                }
              else
                {
                  for (int i = 0; i < listQuiz.length; i++)
                    {
                      listCode.add(listQuiz[i].code),
                      getImage(listQuiz, i).whenComplete(() => setnum()),
                    },
                  setIsLoadingCode()
                }
            });
  }

  Future<void> getData(List<Quiz> lq) async {
    for (int i = 0; i < lq.length; i++) {
      getImage(lq, i);
      getQuestionList(lq, i);
    }
    ;
  }

  Future setnum() async {
    setState(() {
      num += 1;
    });
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
          .whenComplete(() => print('get image completed' + index.toString()));
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

  DateTime lastRender = DateTime(0, 1, 1);
  get _duration {
    var now = DateTime.now();
    var defaultDelay = Duration(milliseconds: 150);
    Duration delay;

    if (lastRender == DateTime(0, 1, 1)) {
      lastRender = now;
      delay = defaultDelay;
    } else {
      var difference = now.difference(lastRender);
      if (difference > defaultDelay) {
        lastRender = now;
        delay = defaultDelay;
      } else {
        var durationOffcet = difference - defaultDelay;
        delay = defaultDelay + (-durationOffcet);

        lastRender = now.add(-durationOffcet);
      }
      return delay;
    }

    return defaultDelay;
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
        body: listCode.length == 0
            ? Container(
                color: Colors.transparent,
              )
            : isLoadCode || num < listQuiz.length
                ? Container(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : StreamBuilder<List<Quiz>>(
                    stream: databaseService.streamQuiz(listCode),
                    builder: (context, snapshot) {
                      List<Quiz> list = snapshot.data ?? [];
                      getData(list);
                      return ListView(
                        children: List.generate(
                            list.length,
                            (index) => QuizView(
                                duration: _duration,
                                index: index,
                                list: list,
                                listQuestion: listQuestion,
                                uid: authService.getCurrentUser!.uid.toString(),
                                listImage: listImage)),
                      );
                    }));
  }
}

class QuizView extends StatefulWidget {
  Duration duration;
  List<Quiz> list;
  int index;
  List<List<Question>> listQuestion;
  String uid;
  List<Uint8List> listImage;
  QuizView(
      {Key? key,
      required this.duration,
      required this.index,
      required this.list,
      required this.listQuestion,
      required this.uid,
      required this.listImage})
      : super(key: key);

  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animation.addStatusListener((status) {
      setState(() {});
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: Row(
        children: [
          MaterialButton(
            onPressed: () async {
              bool isDeleted = false;
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => quizInformation(
                            isDeleted: isDeleted,
                            quiz: widget.list[widget.index],
                            listQuestion: widget.listQuestion[widget.index],
                            userId: widget.uid,
                          )));
              if (isDeleted == true) {
                setState(() {
                  widget.listImage.removeAt(widget.index);
                  widget.listQuestion.removeAt(widget.index);
                });
              }
            },
            child: Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                height: 100,
                width: MediaQuery.of(context).size.width - 120,
                decoration: BoxDecoration(
                  image: widget.listImage[widget.index].toString() ==
                          Uint8List.fromList([0]).toString()
                      ? null
                      : DecorationImage(
                          image: MemoryImage(widget.listImage[widget.index]),
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
                          width: MediaQuery.of(context).size.width - 122,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(25),
                                  bottomLeft: Radius.circular(25))),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              widget.list[widget.index].title,
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
          ),
          Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  color: Color(0xfffaf8aa),
                  border: Border.all(color: Color(0xfff3fc38), width: 3),
                  borderRadius: BorderRadius.circular(25)),
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => PlayQuiz(
                              listQuestion: widget.listQuestion[widget.index],
                              quiz: widget.list[widget.index]),
                        ));
                  },
                  child: Text(
                    'Start',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.black87),
                  ))),
        ],
      ),
    );
  }
}
