import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:quiz_maker/controllers/questionController.dart';
import 'package:quiz_maker/models/Question.dart';
class ProcessBar extends StatelessWidget {
  final List<Question> listQues;
  ProcessBar({Key? key, required this.listQues}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        //color: Colors.white,
        border: Border.all(color: Colors.white, width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: GetBuilder<QuestionController>(
        init:  QuestionController(),
        builder: (controller) {
          controller.creatQuestionList(listQues);
          return Stack(children: [
            LayoutBuilder(
              builder: (context, constraints) => Container(
                width: constraints.maxWidth*controller.animation.value,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.red,
                      Colors.green,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${(controller.animation.value*30).round()} sec",
                        style: TextStyle(
                            color: Colors.white, fontSize: 20),
                      ),
                      Icon(
                        Icons.add_alarm_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                )),
          ]);
        }
      ),
    );
  }
}
