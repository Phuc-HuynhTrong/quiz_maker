import 'package:flutter/material.dart';
import 'package:quiz_maker/screens/PLayQuiz/entercodeandplay.dart';
import 'package:quiz_maker/screens/account/quizsofuser.dart';
import 'package:quiz_maker/widgets/appbar.dart';
class PlayQuizScreen extends StatefulWidget {
  final String uid;
  const PlayQuizScreen({Key? key,required this.uid}) : super(key: key);

  @override
  _PlayQuizScreenState createState() => _PlayQuizScreenState();
}

class _PlayQuizScreenState extends State<PlayQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff09103b),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        color: Color(0xff09103b),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue, width: 5)),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  QuizOfUser()));
                    },
                    child: Text(
                      'Your quiz',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.w800),
                    ))),
            SizedBox(
              height: 10,
            ),
            Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blue, width: 5)),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EnterCodeScreen(uid: widget.uid)));
                    },
                    child: Text(
                      'Play with code',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.w800),
                    ))),
          ],
        ),
      ),
    );
  }
}
