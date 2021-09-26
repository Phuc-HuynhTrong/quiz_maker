import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:quiz_maker/models/Question.dart';

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
  @override
  void onInit() {
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });
    _animationController.forward();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
  }

  void reSetAnimation() {
    _animationController.reset();
  }

  void creatQuestionList(List<Question> list) {
    this.listQues = list;
  }
  void CheckAns(Question question, int selectedIndex){
    selectedOption = selectedIndex;
    if(question.rightAnswer == selectedIndex)
     {
       isAnswer = true;
       numofCorrect += 1;
     }
    _animationController.stop();
    update();
  }
  int get selected => this.selectedOption;
}
