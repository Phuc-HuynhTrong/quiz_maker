import 'package:flutter/material.dart';

Future<void> showAlertDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    barrierColor: Colors.black54,
    builder: (BuildContext context) {
      return Container(
        color: Colors.red,
      );
    },
  );
}