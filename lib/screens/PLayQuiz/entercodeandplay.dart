import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/models/Question.dart';
import 'package:quiz_maker/models/Quiz.dart';
import 'package:quiz_maker/screens/PLayQuiz/playquiz.dart';
import 'package:quiz_maker/services/database.dart';
import 'package:quiz_maker/widgets/appbar.dart';

class EnterCodeScreen extends StatefulWidget {
  final String uid;
  const EnterCodeScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _EnterCodeScreenState createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  late DatabaseService databaseService;
  String code = '';
  final _formKey = GlobalKey<FormState>();
  String note = '';
  @override
  void initState() {
    // TODO: implement initState
    databaseService = DatabaseService(uid: widget.uid);
    super.initState();
  }

  play() async {
    if(_formKey.currentState!.validate())
      {
        Quiz quz =
            await databaseService.getQuizByCode(code);
        if (quz.id != '') {
          List<Question> listQuestion = [];
          listQuestion = await databaseService
              .getQuestionsbyQuizid(quz);
          print(listQuestion.length);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  PlayQuiz(
                    quiz: quz,
                    listQuestion: listQuestion,
                  ),
            ),
          );
        } else {
          setState(() {
            note = 'Code does not exist';
          });
        }
      }
  }

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
            color: Colors.blue,
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
      ),
      body: Container(
        child: Center(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox.shrink(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        note != ''
                            ? Center(
                                child: Container(
                                  child: Text(
                                    note,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 20),
                                  ),
                                ),
                              )
                            : Row(),
                        TextFormField(
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          validator: (val) {
                            return val!.isEmpty ? 'Enter Code' : null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Code Quiz',
                            hintStyle: TextStyle(
                                fontSize: 20, color: Colors.grey[400]),
                            border: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.white, width: 2),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.red, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.white, width: 2)),
                          ),
                          onChanged: (val) {
                            val.toUpperCase();
                            code = val;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                          decoration: BoxDecoration(
                              color: Colors.blue[400],
                              border:
                                  Border.all(color: Colors.lightBlueAccent, width: 1.0),
                          ),

                          child: TextButton(
                              autofocus: true,
                              onPressed: () async {
                                play();
                              },
                              child: Text(
                                'Play',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 26),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
