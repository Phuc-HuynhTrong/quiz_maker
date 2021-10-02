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
              color: Colors.blue[100],
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
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black, width: 1.5)),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              maxLength: 10,
                              validator: (val) {
                                return val!.isEmpty ? 'Enter Code' : null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Code Quiz',
                                hintStyle: TextStyle(
                                    fontSize: 20, color: Colors.grey[400]),
                              ),
                              onChanged: (val) {
                                val.toUpperCase();
                                code = val;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[400],
                              border:
                                  Border.all(color: Colors.black, width: 1.0)),
                          child: TextButton(
                              autofocus: true,
                              onPressed: () async {
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
                                    note = 'code does not exist';
                                  });
                                }
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
