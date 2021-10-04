import 'package:flutter/material.dart';
import 'package:quiz_maker/services/auth.dart';
import 'package:quiz_maker/widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class InformationScreen extends StatelessWidget {
  InformationScreen({Key? key}) : super(key: key);
  late String displayName;
  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return Scaffold(
      backgroundColor: Color(0xff1d2859),
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
                : ListView(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                            ),
                            TextButton(
                                onPressed: () {}, child: Text('Change avatar'))
                          ],
                        ),
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
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 3),
                                ),
                                counterStyle: TextStyle(
                                    color: Colors.white, fontSize: 12),
                                labelText: 'Name',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(color: Colors.white70),
                              ),
                              onChanged: (value) => displayName = value,
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
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 1),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white, width: 1),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white, width: 3),
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
                  );
          }),
    );
  }
}
