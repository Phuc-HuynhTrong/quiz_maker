import 'package:flutter/material.dart';
import 'package:quiz_maker/screens/home/home.dart';
import 'package:quiz_maker/screens/athentication/signin.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/widgets/InputDercoration.dart';
import 'package:quiz_maker/widgets/appbar.dart';
import 'package:quiz_maker/widgets/auth_error.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name, email, password, confirmpass;
  final _authService = AuthService();
  bool isLoading = false;
  signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final res =
          await _authService.signUpWithEmailAndPass(email, password, name);
      setState(() {
        isLoading = false;
      });
      if (res != 'sign up') {
        await showAlertDialog(context,"Email was uesd or not exist");
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    }
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
                child: ListView(
                  reverse: true,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
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
                                        const SignInScreen(),
                                  ));
                            },
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w800),
                            ))
                      ],
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
                          'Sign up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () async {
                          signUp();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      validator: (val) {
                        if(confirmpass != password) return 'Confirm password wrong';
                        return val!.isEmpty ? 'Confirm your password' : null;
                      },
                      decoration:
                          inputDecoration('Confirm your password', context),
                      onChanged: (val) {
                        confirmpass = val;
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      validator: (val) {
                        if(password.length < 8 ) return "Password must longer than 8 digits";
                        return val!.isEmpty ? 'Enter your password' : null;
                      },
                      decoration: inputDecoration("Password", context),
                      onChanged: (val) {
                        password = val;
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      validator: (val) {
                        return val!.isEmpty ? 'Enter your name' : null;
                      },
                      decoration: inputDecoration('Name', context),
                      onChanged: (val) {
                        name = val;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      cursorColor: Colors.white,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      validator: (val) {
                        return val!.isEmpty ? 'Enter your email' : null;
                      },
                      decoration: inputDecoration("Email", context),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
