import 'package:flutter/material.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/widgets/InputDercoration.dart';
import 'package:quiz_maker/widgets/appbar.dart';
import 'package:quiz_maker/widgets/auth_error.dart';
import 'package:quiz_maker/widgets/notice_confirm.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = "";
    AuthService authService = AuthService();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Color(0xff09103b),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appBar(context),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                validator: (val) {
                  return val!.isEmpty ? 'Enter your email' : null;
                },
                decoration: inputDecoration('Email', context),
                onChanged: (val) {
                  email = val;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.blue,
              child: TextButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      final res = await authService.resetPassword(email);
                      if(res != "Sent email")
                      {
                        await showAlertDialog(context, "Email wasn't sign up");
                      }
                      else {
                        await showConfirm(context, "Sent email");
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text(
                    "Send email for me",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800),
                  )),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
