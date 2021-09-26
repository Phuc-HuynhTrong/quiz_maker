import 'package:flutter/material.dart';
import 'package:quiz_maker/models/Question.dart';
import 'package:quiz_maker/widgets/appbar.dart';

class AddQuestionScreen extends StatefulWidget {
  final Question ques;
  const AddQuestionScreen({Key? key, required this.ques}) : super(key: key);

  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  late String ques;
  late String op1;
  late String op2;
  late String op3;
  late String op4;
  late int answer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: appBar(context),
      ),
      body: ListView(children: [
        Container(
          height: MediaQuery.of(context).size.height - 80,
          padding: EdgeInsets.symmetric(horizontal: 20),
          color: Colors.blue[100],
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue, width: 1)),
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    minLines: 5,
                    maxLines: 5,
                    maxLength: 200,
                    validator: (val) {
                      return val!.isEmpty ? 'Enter question' : null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Question',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[400],
                      ),
                    ),
                    onChanged: (val) {
                      ques = val;
                    },
                  )),
              SizedBox(
                height: 20,
              ),
              Card(
                shape: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.adjust_rounded),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 90,
                            height: 60,
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              minLines: 5,
                              maxLines: 5,
                              //smaxLength: 200,
                              validator: (val) {
                                return val!.isEmpty ? 'Enter option 1' : null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Option 1',
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[400],
                                ),
                              ),
                              onChanged: (val) {
                                op1 = val;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.adjust_rounded),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 90,
                            height: 60,
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              minLines: 5,
                              maxLines: 5,
                              //smaxLength: 200,
                              validator: (val) {
                                return val!.isEmpty ? 'Enter option 2' : null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Option 2',
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[400],
                                ),
                              ),
                              onChanged: (val) {
                                op2 = val;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.adjust_rounded),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 90,
                            height: 60,
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              minLines: 5,
                              maxLines: 5,
                              //smaxLength: 200,
                              validator: (val) {
                                return val!.isEmpty ? 'Enter option 3' : null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Option 3',
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[400],
                                ),
                              ),
                              onChanged: (val) {
                                op3 = val;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.adjust_rounded),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 90,
                            height: 60,
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              minLines: 5,
                              maxLines: 5,
                              //smaxLength: 200,
                              validator: (val) {
                                return val!.isEmpty ? 'Enter option 4' : null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Option 4',
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[400],
                                ),
                              ),
                              onChanged: (val) {
                                op4 = val;
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 90,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    minLines: 5,
                    maxLines: 5,
                    //smaxLength: 200,
                    validator: (val) {
                      // ignore: unrelated_type_equality_checks
                      if(val != 1 || val != 2 || val != 3|| val != 4)
                        return 'Write the right answer';
                      return val!.isEmpty ? 'Write the right answer' : null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Answer of question (exp: "1", "2")',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[400],
                      ),
                    ),
                    onChanged: (val) {
                      answer = int.parse(val);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),

              Center(
                  child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: TextButton(
                  onPressed: () {
                    widget.ques.question = ques;
                    widget.ques.option1 = op1;
                    widget.ques.option2 = op2;
                    widget.ques.option3 = op3;
                    widget.ques.option4 = op4;
                    widget.ques.rightAnswer = answer;
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Add question',
                    style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ))
            ],
          ),
        ),
      ]),
    );
  }
}
