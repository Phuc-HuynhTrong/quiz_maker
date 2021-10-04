import 'package:flutter/material.dart';

Future<void> showAlertDialog(BuildContext context, String text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    barrierColor: Colors.black54,
    builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Color(0xff09103b),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width / 1.8,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                  color: Colors.yellow, width: 3),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:  Color(0xff09103b),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                    color: Colors.red, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      text,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.redAccent),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),
                  MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Close',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
