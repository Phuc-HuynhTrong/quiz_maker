import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quiz_maker/models/Question.dart';
import 'package:quiz_maker/models/Quiz.dart';
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
  late int page = 0;
  // so that we can access our animation outside
  Animation get animation => this._animation;
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
    _animationController.reset();
    _animationController.dispose();
    pageController.dispose();
    print('close controller');
  }
  void reSetAnimation() {
    _animationController.reset();
  }
  late Quiz _quiz;
  void creatQuestionList(List<Question> list, Quiz quiz) {
    this.listQues = list;
    this._quiz = quiz;
    if(page == 0)
    {
      page =list.length;
    }
  }

  Quiz get quiz => this._quiz;
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

  Future<void> nextQuestion() async {
    print('page ' + page.toString());
    if (page != 1) {
      isAnswer = false;
      selectedOption = 0;
      page = page -1;
      pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);
      _animationController.reset();
      _animationController.forward().whenComplete(() => nextQuestion());
    }
    else {
      await Get.to(ScoreScreen());
      setData();
      numofCorrect = 0;
    }
  }
  void setData(){
    _animationController.reset();
    _animationController.forward();
    pageController = new PageController();
    selectedOption = 0;
    isAnswer = false;
    page = listQues.length;
    print('set data controller');
  }
  int get selected => this.selectedOption;
}
