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
  final _formKey = GlobalKey<FormState>();
  late String ques = '';
  late String op1 = '';
  late String op2 = '';
  late String op3= '';
  late String op4 = '';
  late String answer = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff09103b),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            appBar(context),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ques != '' ?widget.ques.question = ques:null;
                  op1 != ''?widget.ques.option1 = op1:null;
                  op2 != ''?widget.ques.option2 = op2:null;
                  op3 != ''?widget.ques.option3 = op3:null;
                  op4 != ''?widget.ques.option4 = op4:null;
                  answer != '0'?widget.ques.rightAnswer = int.parse(answer):null;
                  Navigator.pop(context);
                }
              },
              icon: Icon(
                Icons.done,
                color: Colors.white,
              ))
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(children: [
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.white, width: 2)),
                  child: TextFormField(
                    initialValue: widget.ques.question== ''?null:widget.ques.question,
                    cursorColor: Colors.white,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    validator: (val) {
                      return val!.isEmpty ? 'Enter question' : null;
                    },
                    minLines: 4,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Question',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[400],
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                      errorBorder: UnderlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 2)),
                      errorStyle: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(
                              color: Colors.red, fontWeight: FontWeight.w500),
                    ),
                    onChanged: (val) {
                      ques = val;
                    },
                  )),
              SizedBox(
                height: 20,
              ),
              Card(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 10,
                          height: 75,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextFormField(
                            initialValue: widget.ques.option1== ''?null:widget.ques.option1,
                            cursorColor: Colors.white,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            minLines: 5,
                            maxLines: 5,
                            validator: (val) {
                              return val!.isEmpty ? 'Enter option 1' : null;
                            },
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.adjust_rounded,
                                color: Colors.white,
                              ),
                              hintText: 'Option 1',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[400],
                              ),
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(25))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              errorBorder: UnderlineInputBorder(),
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 2)),
                              errorStyle: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500),
                            ),
                            onChanged: (val) {
                              op1 = val;
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 10,
                          height: 75,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextFormField(
                            initialValue: widget.ques.option2== ''?null:widget.ques.option2,
                            cursorColor: Colors.white,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            validator: (val) {
                              return val!.isEmpty ? 'Enter option 2' : null;
                            },
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.adjust_rounded,
                                color: Colors.white,
                              ),
                              hintText: 'Option 2',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[400],
                              ),
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(25))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              errorBorder: UnderlineInputBorder(),
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 2)),
                              errorStyle: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500),
                            ),
                            onChanged: (val) {
                              op2 = val;
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 10,
                          height: 75,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextFormField(
                            initialValue: widget.ques.option3== ''?null:widget.ques.option3,
                            cursorColor: Colors.white,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            validator: (val) {
                              return val!.isEmpty ? 'Enter option 3' : null;
                            },
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.adjust_rounded,
                                color: Colors.white,
                              ),
                              hintText: 'Option 3',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[400],
                              ),
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(25))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              errorBorder: UnderlineInputBorder(),
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 2)),
                              errorStyle: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500),
                            ),
                            onChanged: (val) {
                              op3 = val;
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 10,
                          height: 75,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextFormField(
                            initialValue: widget.ques.option4== ''?null:widget.ques.option4,
                            cursorColor: Colors.white,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            validator: (val) {
                              return val!.isEmpty ? 'Enter option 4' : null;
                            },
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.adjust_rounded,
                                color: Colors.white,
                              ),
                              hintText: 'Option 4',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[400],
                              ),
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      bottomRight: Radius.circular(25))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              errorBorder: UnderlineInputBorder(),
                              focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 2)),
                              errorStyle: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500),
                            ),
                            onChanged: (val) {
                              op4 = val;
                            },
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row()
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 90,
                  height: 75,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.white, width: 1)),
                  child: TextFormField(
                    initialValue: widget.ques.rightAnswer== 0?null:widget.ques.rightAnswer.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    validator: (val) {
                      // ignore: unrelated_type_equality_checks
                      if (val != "1" && val != "2" && val != "3" && val != "4")
                        return 'Write the correct answer';
                      return val!.isEmpty ? 'Write the right answer' : null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Answer of question (exp: "1", "2")',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[400],
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      errorBorder: OutlineInputBorder(),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 2)),
                      errorStyle: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(
                              color: Colors.red, fontWeight: FontWeight.w500),
                    ),
                    onChanged: (val) {
                      answer = val;
                    },
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
