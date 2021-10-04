import 'package:flutter/material.dart';
import 'package:quiz_maker/screens/home/home.dart';
import 'package:quiz_maker/screens/athentication/signin.dart';
import 'package:quiz_maker/services/auth.dart';
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
  final _authService =  AuthService();
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
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                validator: (val) {
                  return val!.isEmpty ? 'Enter your name' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
                onChanged: (val) {
                  name = val;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (val) {
                  return val!.isEmpty ? 'Enter your email' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                onChanged: (val) {
                  email = val;
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (val) {
                  return val!.isEmpty ? 'Enter your password' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                onChanged: (val) {
                  password = val;
                },
                obscureText: true,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (val) {
                  return val!.isEmpty ? 'Confirm your password' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Confirm password',
                ),
                onChanged: (val) {
                  confirmpass = val;
                },
                obscureText: true,
              ),
              SizedBox(
                height: 5,
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
                    final res = await _authService.signUpWithEmailAndPass(email, password, name);
                    if(res != "sign up")
                      {
                        await showAlertDialog(context);
                      }
                    else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const Home(),
                          ));
                    }
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 16),
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
                          color: Colors.black,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
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
