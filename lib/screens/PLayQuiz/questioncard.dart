import 'package:flutter/material.dart';
import 'package:quiz_maker/controllers/questionController.dart';
import 'package:quiz_maker/models/Question.dart';
import 'package:quiz_maker/screens/PLayQuiz/optionview.dart';
import 'package:get/get.dart';

class QuestionCard extends StatefulWidget {
  final List<Question> list;
  final int index;
  QuestionCard({Key? key, required this.list, required this.index})
      : super(key: key);

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  late Question ques;
  @override
  void initState() {
    ques = widget.list[widget.index];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    QuestionController controller = Get.put(QuestionController());
    return Container(
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              ques.question.toString(),
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 30,
            ),
            ...List.generate(
                4,
                (index) => OptionView(
                    index: index + 1,
                    ques: ques,
                    press: () => controller.checkAns(ques, index+1))),
          ],
        ),
      ),
    );
  }
}
