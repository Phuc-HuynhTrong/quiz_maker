import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return Center(
    child: RichText(
        text: TextSpan(style: TextStyle(fontSize: 25), children: <TextSpan>[
      TextSpan(
          text: 'Quiz',
          style: TextStyle(
            color: Color(0xfff3fc38),
            fontWeight: FontWeight.w500,
          )),
      TextSpan(
          text: 'Maker',
          style: TextStyle(
            color: Colors.blue[400],
            fontWeight: FontWeight.w600,
          )),
    ])),
  );
}
