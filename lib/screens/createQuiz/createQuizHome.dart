import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quiz_maker/models/Question.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_maker/models/Quiz.dart';
import 'package:quiz_maker/screens/createQuiz/addquestions.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/services/database.dart';
import 'package:quiz_maker/services/storage.dart';
import 'package:quiz_maker/widgets/auth_error.dart';

class CreateQuizHome extends StatefulWidget {
  const CreateQuizHome({Key? key}) : super(key: key);

  @override
  _CreateQuizHomeState createState() => _CreateQuizHomeState();
}

class _CreateQuizHomeState extends State<CreateQuizHome> {
  final fieldText1 = TextEditingController();
  final fieldText2 = TextEditingController();
  List<Question> listQuestion = <Question>[];
  late String code = '';
  late String title = '';
  late XFile imageFile;
  bool uploadImage = false;
  final ImagePicker picker = ImagePicker();
  AuthService authService = AuthService();
  Storage storage = Storage();
  late String uid = '';
  late DatabaseService databaseService = DatabaseService(uid: uid);
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    uid = authService.getCurrentUser!.uid;
    databaseService = DatabaseService(uid: uid);
    super.initState();
  }

  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      final pickedFile = await picker.pickImage(
        source: source,
      );
      setState(() {
        imageFile = pickedFile!;
        uploadImage = true;
      });
    } catch (e) {
      print(e);
    }
  }
  addQuiz() async {
    if(_formKey.currentState!.validate())
      {
        if(uploadImage == false)
          {
            await showAlertDialog(context,"Please upload image");
          }
        else if(listQuestion.length < 1){
          await showAlertDialog(context,"Please add question");
        }
        else
          {
            Quiz quiz = Quiz(
                id: '', code: code, imageURL: imageFile.path, title: title);
            await databaseService.addQuiz(quiz);
            storage.uploadImageToFirebase(File(imageFile.path));
            final q = await databaseService.getQuizByCode(code);
            for(int i = 0 ;i < listQuestion.length; i++)
            {
              databaseService.addQuestion(listQuestion[i], q.id);
            }
            setState(() {
              uploadImage = false;
              listQuestion = <Question>[];
              code = '';
              title = '';
              fieldText1.clear();
              fieldText2.clear();
            });
          }
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff09103b),
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    children: [
                      GestureDetector(
                        child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width - 10,
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: uploadImage
                                ? Container(
                                    child: Image.file(
                                      File(imageFile.path),
                                      fit: BoxFit.fill,
                                      height: 200,
                                      width:
                                          MediaQuery.of(context).size.width - 10,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                    'Upload image of quiz',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ))),
                        onTap: () {
                          _onImageButtonPressed(ImageSource.gallery,
                              context: context);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: fieldText1,
                        cursorColor: Colors.white,
                        minLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Enter title of quiz',
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
                          title = val;
                        },
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        validator: (val){
                          if(title.length > 100) return "Title is so long";
                          return val!.isEmpty ? 'Enter title of quiz' : null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: fieldText2,
                        cursorColor: Colors.white,
                        minLines: 1,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Enter code of quiz',
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
                          code = val;
                        },
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        validator: (val){
                          if(code.length < 4) return "Code must longer than 3 digits";
                          if(code.length > 8) return "Code must shorter than 9 digits";
                          return val!.isEmpty?"Enter code" :null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  );
                },
                childCount: 1,
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment:  MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                padding: EdgeInsets.all(5),
                                height: 60,
                                width: MediaQuery.of(context).size.width - 80,
                                decoration: BoxDecoration(
                                    color: Colors.blue[900],
                                    border: Border.all(
                                        color: Colors.white, width: 2)),
                                child: Text(
                                  'Question ' +
                                      (index + 1 ).toString() +
                                      ' :' +
                                      listQuestion[index].question.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                )),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  listQuestion.removeAt(index);
                                });
                              },
                              icon: Icon(Icons.clear, color: Colors.white,))
                        ],
                      ),
                    ],
                  ),
                );
              },
              childCount: listQuestion.length,
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        backgroundColor: Colors.grey,
        onPressed: () async {
          Question ques = Question(
              id: '',
              imageURL: '',
              option1: '',
              option2: '',
              option3: '',
              option4: '',
              question: '',
              rightAnswer: 0);
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddQuestionScreen(
                        ques: ques,
                      )));
          print('ques : ' + ques.question);
          if (ques.question != '') {
            setState(() {
              listQuestion.add(ques);
            });
          }
        },
        child: Center(
            child: Text(
          'Add\nques',
          style: TextStyle(fontSize: 16, color: Colors.white),
        )),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 3)),
        child: TextButton(
          onPressed: () async {
            await addQuiz();
          },
          child: Text(
            'Add quiz',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
