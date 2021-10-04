import 'package:flutter/material.dart';
InputDecoration inputDecoration(String label, BuildContext context){
  return InputDecoration(
    labelText: label,
    labelStyle: TextStyle(
        color: Colors.white, fontWeight: FontWeight.w500),
    border: UnderlineInputBorder(
        borderSide:
        BorderSide(color: Colors.red, width: 2)),
    enabledBorder: UnderlineInputBorder(
        borderSide:
        BorderSide(color: Colors.white, width: 2)),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: Color(0xff94fc03), width: 2)),
    errorBorder: UnderlineInputBorder(
        borderSide:
        BorderSide(color: Colors.red, width: 2)),
    errorStyle: Theme.of(context)
        .textTheme
        .subtitle1!
        .copyWith(
        color: Colors.red, fontWeight: FontWeight.w500),
  );
}