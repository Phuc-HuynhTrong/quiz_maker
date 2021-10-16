import 'package:flutter/material.dart';
import 'package:quiz_maker/screens/account/changepasswordscreen.dart';
import 'package:quiz_maker/screens/account/quizsofuser.dart';
import 'package:quiz_maker/screens/account/userinformation.dart';
import 'package:quiz_maker/screens/athentication/signin.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_maker/widgets/appbar.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AuthService _authService = AuthService();
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
      body: StreamBuilder(
        stream: _authService.streamUser(),
        builder: (context, snapshot) {
          User? user = snapshot.data as User;
          return user == null
              ? Container(
                  child: Center(child: CircularProgressIndicator()),
                )
              : Container(
                  color: Color(0xff09103b),
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              user.displayName.toString(),
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              user.email.toString(),
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          //color: Colors.blue[100],
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          width: double.infinity,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            InformationScreen()));
                              },
                              child: Text(
                                'Your imformation',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20),
                              ))),
                      Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                      Container(
                          //color: Colors.blue[100],
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          width: double.infinity,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuizOfUser()));
                              },
                              child: Text(
                                'Your quizs',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20),
                              ))),
                      Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                      Container(
                          //color: Colors.blue[100],
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          width: double.infinity,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangePasswordScreen(user: user,)));
                              },
                              child: Text(
                                'Change password',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20),
                              ))),
                      Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                      Container(
                          //color: Colors.blue[100],
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 50,
                          width: double.infinity,
                          child: TextButton(
                              onPressed: () async {
                                await _authService.signout();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const SignInScreen()),
                                );
                              },
                              child: Text(
                                'Sign out',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20),
                              ))),
                      Divider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
