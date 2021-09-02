import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({Key? key}) : super(key: key);

  @override
  _EnterCodeScreenState createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  String code = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 60),
            color: Colors.blue[100],
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox.shrink(
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.5)),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: TextFormField(
                            style: TextStyle(fontSize: 20, ),
                            maxLength: 10,
                            validator: (val) {
                              return val!.isEmpty ? 'Enter Code' : null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Code Quiz',
                              hintStyle: TextStyle(fontSize: 20, color: Colors.grey[400]),
                            ),
                            onChanged: (val) {
                              val.toUpperCase();
                              code = val;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blue[400],
                            border: Border.all(color: Colors.black, width: 1.0)
                        ),
                        child: TextButton(
                            autofocus: true,
                            onPressed: () {},
                            child: Text(
                              'Play',
                              style: TextStyle(color: Colors.black87, fontSize: 26),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
