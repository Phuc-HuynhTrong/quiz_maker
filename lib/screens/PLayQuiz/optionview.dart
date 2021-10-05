import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_maker/controllers/questionController.dart';
import 'package:get/get.dart';
import 'package:quiz_maker/models/Question.dart';

class OptionView extends StatelessWidget {
  final int index;
  final Question ques;
  final VoidCallback press;
  final Color correct = Color(0xFF50de2c);
  final Color incorrect = Color(0xFFeb1515);
  OptionView(
      {Key? key, required this.index, required this.ques, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String option = index == 1
        ? ques.option1
        : index == 2
            ? ques.option2
            : index == 3
                ? ques.option3
                : ques.option4;
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (controller) {
          Color rightColor() {
            if (controller.selectedOption == 0) {
              return Colors.black;
            } else {
              if (index == controller.selectedOption)
                {
                  if (ques.rightAnswer == index) return correct;
                  else
                    return incorrect;
                }
              if (index == ques.rightAnswer) return correct;
            }
            return Colors.black;
          }

          return InkWell(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: rightColor(), width: 3),
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    option,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: rightColor()),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: rightColor() == Colors.black
                            ? Colors.white
                            : rightColor(),
                        border: Border.all(color: rightColor(), width: 3),
                        borderRadius: BorderRadius.circular(50)),
                    child: rightColor() == Colors.black
                        ? Container()
                        : rightColor() == correct
                            ? Icon(
                                Icons.done,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.clear,
                                color: Colors.white,
                              ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
