import 'package:flutter/material.dart';
import 'package:quiz_maker/screens/athentication/signin.dart';
import 'package:quiz_maker/screens/home/home.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _authService.streamUser(),
      builder: (context, snapshot) {
        User? user = snapshot.data as User;
        return Container(
          color: Colors.white,
          child: Column(
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
                      user == null ? 'your email' : user.displayName.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 20),
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
                      user == null ? 'your email' : user.email.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  color: Colors.blue[100],
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Your imformation',
                        style: TextStyle(color: Colors.blue[900], fontSize: 20),
                      ))),
              SizedBox(
                height: 5,
              ),
              Container(
                  color: Colors.blue[100],
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Your quizs',
                        style: TextStyle(color: Colors.blue[900], fontSize: 20),
                      ))),
              SizedBox(
                height: 5,
              ),
              Container(
                  color: Colors.blue[100],
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Quiz comleted',
                        style: TextStyle(color: Colors.blue[900], fontSize: 20),
                      ))),
              SizedBox(
                height: 5,
              ),
              Container(
                  color: Colors.blue[100],
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Change password',
                        style: TextStyle(color: Colors.blue[900], fontSize: 20),
                      ))),
              SizedBox(
                height: 5,
              ),
              Container(
                  color: Colors.blue[100],
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () async {
                        await  _authService.SignOut();
                        Navigator.pushReplacement(context,
                          MaterialPageRoute (
                            builder: (BuildContext context) => const SignInScreen()
                          ),
                        );
                      },
                      child: Text(
                        'Sign out',
                        style: TextStyle(color: Colors.blue[900], fontSize: 20),
                      ))),
            ],
          ),
        );
      },
    );
  }
}
