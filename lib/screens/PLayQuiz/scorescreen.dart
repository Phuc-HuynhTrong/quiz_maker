import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/controllers/questionController.dart';
import 'package:get/get.dart';
import 'package:quiz_maker/models/result.dart';
import 'package:quiz_maker/screens/PLayQuiz/playquiz.dart';
import 'package:quiz_maker/screens/home/home.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/services/database.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({Key? key}) : super(key: key);

  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  late QuestionController questionController = Get.put(QuestionController());
  late AuthService authService = AuthService();
  late String userid = authService.getCurrentUser!.uid;
  late DatabaseService databaseService = DatabaseService(uid: userid);
  late Result result = Result(id: '', score: 0, times: 0, userid: userid);
  Future<void> creatAndUploadData() async {
    dynamic time = 0;
    await databaseService.getTimes(questionController.quiz).then((value) => {
          time = value,
        });
    setState(() {
      result = Result(
          id: '',
          score: questionController.numofCorrect,
          times: time! + 1,
          userid: userid);
    });
    databaseService.addResult(questionController.quiz, result);
  }

  @override
  void initState() {
    creatAndUploadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff09103b),
      body: Container(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          (questionController.numofCorrect * 10).toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          '/' +
                              (questionController.listQues.length * 10)
                                  .toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Test time:   " + result.times.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 2 - 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color: Color(0xFF0be345), width: 3)),
                              margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const Home(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Home",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(color: Colors.black87),
                                  ))),
                          Container(
                              width: MediaQuery.of(context).size.width / 2 - 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color: Color(0xFF0be345), width: 3)),
                              margin: EdgeInsets.fromLTRB(20, 40, 0, 0),
                              child: TextButton(
                                  onPressed: () {

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            PlayQuiz(
                                                quiz: questionController.quiz,
                                                listQuestion: questionController
                                                    .listQues),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Test again",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(color: Colors.black87),
                                  )))
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
