import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/models/Question.dart';
import 'package:quiz_maker/models/Quiz.dart';
import 'package:quiz_maker/models/result.dart';
import 'package:quiz_maker/screens/PLayQuiz/optionview.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/services/database.dart';
import 'package:quiz_maker/services/storage.dart';

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
  Storage storage = Storage();
  late DatabaseService databaseService;
  String uid = "";
  List<Result> listResults = [];
  bool isLoading = false;
  bool isShowListQuestion = false;
  bool isShowListResult = false;
  @override
  void initState() {
    quiz = widget.quiz;
    uid = authService.getCurrentUser!.uid;
    listQues = widget.listQuestion;
    databaseService = DatabaseService(uid: uid);
    getListResutl();
    super.initState();
  }

  Future<void> getListResutl() async {
    bool complete = false;
    setState(() {
      isLoading = true;
    });
    await databaseService.getListResultOfQuiz(quiz, uid).then((value) => {
          listResults = value,
          complete = true,
        });
    if (complete) {
      setState(() {
        isLoading = false;
      });
    }
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
                storage.deleteImages(quiz.imageURL);
                Navigator.pop(context);
                //return 'delete quiz';
              },
              child: Text(
                'delete',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : ListView(
              children: [
                Container(
                  height: 25,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Code: ',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        quiz.code.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 25,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Num of questions: ',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        listQues.length.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 25,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total num of testing:',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        listResults.length.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      if (isShowListQuestion == true)
                        isShowListQuestion = false;
                      else
                        isShowListQuestion = true;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'List question ',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          )
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.white,
                        indent: 100,
                        endIndent: 100,
                      )
                    ],
                  ),
                ),
                isShowListQuestion
                    ? AnimatedContainer(
                        height: listQues.length * 470,
                        duration: Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.easeInToLinear,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: listQues.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                subtitle: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 60),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Correct answer: ',
                                        style: tst(context),
                                      ),
                                      listQues[index].rightAnswer == 1
                                          ? Text(
                                              listQues[index].option1,
                                              style: tst(context),
                                            )
                                          : listQues[index].rightAnswer == 2
                                              ? Text(
                                                  listQues[index].option2,
                                                  style: tst(context),
                                                )
                                              : listQues[index].rightAnswer == 3
                                                  ? Text(
                                                      listQues[index].option3,
                                                      style: tst(context),
                                                    )
                                                  : Text(
                                                      listQues[index].option4,
                                                      style: tst(context),
                                                    )
                                    ],
                                  ),
                                ),
                                title: Container(
                                  margin: EdgeInsets.all(20),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          listQues[index].question.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        ...List.generate(
                                          4,
                                          (x) => OptionView(
                                              index: x + 1,
                                              ques: listQues[index],
                                              press: () {}),
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        ),
                      )
                    : Row(),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      if (isShowListResult == true)
                        isShowListResult = false;
                      else
                        isShowListResult = true;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'List results of all user ',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          )
                        ],
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.white,
                        indent: 100,
                        endIndent: 100,
                      )
                    ],
                  ),
                ),
                isShowListResult
                    ? AnimatedContainer(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        duration: Duration(milliseconds: 300),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Name',
                              style: tst(context),
                            ),
                            Text(
                              'Turn',
                              style: tst(context),
                            ),
                            Text(
                              'Score',
                              style: tst(context),
                            ),
                          ],
                        ),
                      )
                    : Row(),
                isShowListResult
                    ? AnimatedContainer(
                        height: listResults.length * 60,
                        duration: Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.easeInToLinear,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: listResults.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    listResults[index].name,
                                    style: tst(context),
                                  ),
                                  Text(
                                    listResults[index].times.toString(),
                                    style: tst(context),
                                  ),
                                  Text(
                                    listResults[index].score.toString(),
                                    style: tst(context),
                                  ),
                                ],
                              ),
                            ));
                          },
                        ),
                      )
                    : Row(),
              ],
            ),
    );
  }
}

TextStyle tst(context) {
  return Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white);
}
