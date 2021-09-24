import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/screens/account/accountscreen.dart';
import 'package:quiz_maker/screens/createQuiz/createQuizHome.dart';
import 'package:quiz_maker/screens/PLayQuiz/playquizhome.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/widgets/appbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  AuthService _authService = AuthService();
  String uid = '';
  @override
  void initState() {
    // TODO: implement initState
    uid = _authService.getCurrentUser!.uid;
    super.initState();
    setState(() {});
  }

  void onTapedTap(int id) {
    setState(() {
      index = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appBar(context),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Container(
          child: index == 0
              ? PlayQuizScreen(uid: uid)
              : index == 1
                  ? CreateQuizHome()
                  : AccountScreen(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: 'Play quiz',
                icon: Icon(
              Icons.play_circle_fill,
              size: 30,
              color: Colors.blue,
            )),
            BottomNavigationBarItem(
                label: 'Create quiz',
                icon: Icon(
                  Icons.add_circle_outlined,
                  size: 30,
                  color: Colors.blue,
                )),
            BottomNavigationBarItem(
                label: 'Your information',
                icon: Icon(
                  Icons.account_circle,
                  size: 30,
                  color: Colors.blue,
                )),
          ],
          currentIndex: index,
          selectedItemColor: Colors.blue,
          onTap: onTapedTap,
        ));
  }
}
