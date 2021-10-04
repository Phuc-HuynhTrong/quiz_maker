import 'package:flutter/material.dart';
import 'package:quiz_maker/screens/home/home.dart';
import 'package:quiz_maker/screens/athentication/signup.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/widgets/InputDercoration.dart';
import 'package:quiz_maker/widgets/appbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_maker/widgets/auth_error.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  bool isLoading = false;
  final authService = AuthService();
  late String pasHid = '';
  signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final res = await authService.signInWithEmailAndPass(email, password);
      setState(() {
        isLoading = false;
      });
      if (res != 'sign in') {
        await showAlertDialog(context,"Incorrect email or password");
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    }
  }

  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print('completed');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff09103b),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: appBar(context),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
      ),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Spacer(),
                    TextFormField(
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      validator: (val) {
                        return val!.isEmpty ? 'Enter your email' : null;
                      },
                      decoration: inputDecoration('Email', context),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                        cursorColor: Colors.white,
                        validator: (val) {
                          return val!.isEmpty ? 'Enter your password' : null;
                        },
                        decoration: inputDecoration('Password', context),
                        onChanged: (val) {
                          password = val;
                        },
                        obscureText: true,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 40,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        onPressed: () async {
                          await signIn();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const SignUpScreen(),
                                  ));
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w800),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
