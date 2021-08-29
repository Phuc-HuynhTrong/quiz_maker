import 'package:flutter/material.dart';
import 'package:quiz_maker/screens/signup.dart';
import 'package:quiz_maker/widgets/appbar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  return val!.isEmpty ? 'Enter your email' : null;
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                onChanged: (val){
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
                onChanged: (val){
                  password = val;
                },
              ),
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
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {},
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
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const SignUpScreen(),
                        ));
                      },
                      child: Text(
                        "Sign up",
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
