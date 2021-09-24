import 'package:flutter/material.dart';
import 'package:quiz_maker/components/process_bar.dart';
import 'package:quiz_maker/models/Question.dart';
import 'package:quiz_maker/models/Quiz.dart';

class PlayQuiz extends StatefulWidget {
  final Quiz quiz;
  final List<Question> listQuestion;
  const PlayQuiz({Key? key, required this.quiz, required this.listQuestion})
      : super(key: key);
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz> {
  List<Question> list = [];
  @override
  void initState() {
    // TODO: implement initState
    list = widget.listQuestion;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1d2859),
        appBar: AppBar(
          backgroundColor: Color(0xff1d2859),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProcessBar(
                      listQues: widget.listQuestion,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text.rich(TextSpan(
                        text: "Question 1",
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.white),
                        children: [
                          TextSpan(
                            text: "/10",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white),
                          )
                        ])),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            list[0].question.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey,width: 3),
                                borderRadius:  BorderRadius.circular(25)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  list[0].option1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.black),
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey,width: 3),
                                    borderRadius:  BorderRadius.circular(50)
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey,width: 3),
                                borderRadius:  BorderRadius.circular(25)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  list[0].option2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.black),
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey,width: 3),
                                      borderRadius:  BorderRadius.circular(50)
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey,width: 3),
                                borderRadius:  BorderRadius.circular(25)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  list[0].option3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.black),
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey,width: 3),
                                      borderRadius:  BorderRadius.circular(50)
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey,width: 3),
                                borderRadius:  BorderRadius.circular(25)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  list[0].option4,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.black),
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey,width: 3),
                                      borderRadius:  BorderRadius.circular(50)
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
