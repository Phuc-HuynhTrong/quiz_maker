import 'package:flutter/material.dart';
import 'package:quiz_maker/widgets/appbar.dart';
class QuizOfUser extends StatefulWidget {
  const QuizOfUser({Key? key}) : super(key: key);

  @override
  _QuizOfUserState createState() => _QuizOfUserState();
}

class _QuizOfUserState extends State<QuizOfUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.blue,),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: appBar(context),
      ),
      body: Container(
        color: Colors.blue[100],
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 60),
            color: Colors.blue[100],
            child: Column(
            ),
          ),
        ),
      ),
    );
  }
}
