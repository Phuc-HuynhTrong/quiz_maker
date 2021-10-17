import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_maker/widgets/notice_confirm.dart';

class InformationScreen extends StatefulWidget {
  InformationScreen({Key? key}) : super(key: key);

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  late String displayName;
  final formKey = new GlobalKey<FormState>();
  bool showButton = false;

  AuthService authService = AuthService();
  late String username;
  check() {
    if (displayName != username)
      setState(() {
        showButton = true;
      });
    else {
      setState(() {
        showButton = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    username = authService.getCurrentUser!.displayName.toString();
  }

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return Scaffold(
      backgroundColor: Color(0xff09103b),
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appBar(context),
          ],
        ),
        actions: [
          showButton
              ? IconButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await authService.changeName(displayName);
                      await showConfirm(context, "Name was changed");
                      setState(() {
                        showButton = false;
                      });
                    }
                  },
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ))
              : Text(''),
        ],
        elevation: 0.0,
      ),
      body: StreamBuilder<User?>(
          stream: authService.streamUser(),
          builder: (context, snapshot) {
            User? user = snapshot.data;
            return user == null
                ? Container(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Form(
                    key: formKey,
                    child: ListView(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Column(children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: Center(
                                child: Text(
                                  user.displayName.toString().substring(0, 1),
                                  style: TextStyle(
                                      color: CupertinoColors.white,
                                      fontSize: 50),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                enabled: true,
                                initialValue: user.displayName,
                                keyboardType: TextInputType.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: Colors.white),
                                decoration: InputDecoration(
                                  errorBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 1),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 3),
                                  ),
                                  counterStyle: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                  labelText: 'Name',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.white70),
                                ),
                                onChanged: (value) =>
                                    {displayName = value, check()},
                                validator: (value) {
                                  // nếu giá trị nhập vào trường name rỗng
                                  if (value == null || value.length == 0)
                                    return 'Name is empty';
                                  // nếu giá trị có ký hiệu không hợp lệ
                                  return (value != null && value.contains('@'))
                                      ? 'Do not use the @ char.'
                                      : null;
                                },
                              ),
                              Container(
                                child: TextFormField(
                                  enabled: false,
                                  initialValue: user.email,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .copyWith(color: Colors.white),
                                  decoration: InputDecoration(
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 1),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 3),
                                    ),
                                    counterStyle: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                    labelText: 'Email',
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(color: Colors.white70),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          }),
    );
  }
}
