import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quiz_maker/models/Question.dart';
import 'package:quiz_maker/screens/PLayQuiz/scorescreen.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  late List<Question> listQues = [];
  late AnimationController _animationController;
  late Animation _animation;
  late PageController pageController;
  int numofCorrect = 0;
  bool isAnswer = false;
  int selectedOption = 0;
  // so that we can access our animation outside
  Animation get animation => this._animation;
  late int page = 0;
  @override
  void onInit() {
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });
    _animationController.reset();
    _animationController.forward().whenComplete(() => nextQuestion());

    pageController = PageController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    pageController.dispose();
  }

  void reSetAnimation() {
    _animationController.reset();
  }

  void creatQuestionList(List<Question> list) {
    this.listQues = list;
    page = listQues.length;
  }

  void CheckAns(Question question, int selectedIndex) {
    selectedOption = selectedIndex;
    if (question.rightAnswer == selectedIndex) {
      isAnswer = true;
      numofCorrect += 1;
    }
    _animationController.stop();
    update();

    Future.delayed(Duration(seconds: 2), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (page != -1) {
      isAnswer = false;
      selectedOption = 0;
      pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);
      page -= 1;
      _animationController.reset();
      _animationController.forward().whenComplete(() => nextQuestion());
    }
    Get.to(ScoreScreen());
  }
  int get selected => this.selectedOption;
}
