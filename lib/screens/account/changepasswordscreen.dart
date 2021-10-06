import 'package:flutter/material.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_maker/widgets/auth_error.dart';
import 'package:quiz_maker/widgets/notice_confirm.dart';

class ChangePasswordScreen extends StatefulWidget {
  final User user;
  ChangePasswordScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String currentlyPass = "";

  String newPass = "";

  String renewPass = "";

  AuthService authService = AuthService();

  final _formKey = new GlobalKey<FormState>();

  bool showButton = false;
  checckVal() {
    if (currentlyPass != "" && renewPass != "" && newPass != "") {
      setState(() {
        showButton = true;
      });
    } else {
      setState(() {
        showButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff09103b),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                appBar(context),
                Text(
                  'Change password',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          ],
        ),
        actions: [
          showButton
              ? IconButton(
                  onPressed: () async {
                    if(_formKey.currentState!.validate())
                      {
                        final re = await authService.changePassword(widget.user.email,currentlyPass,newPass);
                        if(re != "Update password completed")
                          await showAlertDialog(context, "Incorrect password");
                        else {
                          await showConfirm(context, "Update password completed");
                          Navigator.pop(context);
                        }
                      }
                  },
                  icon: Icon(
                    Icons.done,
                    color: Colors.white,
                  ))
              : Text('')
        ],
        elevation: 0.0,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  minLines: 1,
                  maxLines: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintStyle: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Colors.grey[400]),
                    hintText: 'Your currently password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 2)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.red, width: 2)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                  ),
                  obscureText: true,
                  validator: (val) {
                    return val!.isEmpty
                        ? 'Enter your currently password'
                        : null;
                  },
                  onChanged: (val) {
                    currentlyPass = val;
                    checckVal();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  minLines: 1,
                  maxLines: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintStyle: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Colors.grey[400]),
                    hintText: 'Your new password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 2)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.red, width: 2)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                  ),
                  obscureText: true,
                  validator: (val) {
                    if (newPass.length < 8)
                      return "New passord must longer than 8 digits";
                    return val!.isEmpty ? 'Enter your new password' : null;
                  },
                  onChanged: (val) {
                    newPass = val;
                    checckVal();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  minLines: 1,
                  maxLines: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintStyle: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Colors.grey[400]),
                    hintText: 'Confirm you new password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide:
                            BorderSide(color: Colors.transparent, width: 2)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.red, width: 2)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.white, width: 2)),
                  ),
                  obscureText: true,
                  validator: (val) {
                    if (renewPass != newPass)
                      return "Confirmed password was wrong";
                    return val!.isEmpty ? 'Enter your re-password' : null;
                  },
                  onChanged: (val) {
                    renewPass = val;
                    checckVal();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
