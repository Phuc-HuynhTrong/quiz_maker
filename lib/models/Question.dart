class Question {
  String imageURL;
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  String rightAnswer;
  Question({
    required this.imageURL,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.question,
    required this.rightAnswer,
  });
  factory Question.fromMap(Map<String, dynamic> data) {
    if (data == null)
      return Question(
          imageURL: '',
          option1: '',
          option2: '',
          option3: '',
          option4: '',
          question: '',
          rightAnswer: '');
    return Question(
        imageURL: data['imageURl'],
        option1: data['option1'],
        option2: data['option2'],
        option3: data['option3'],
        option4: data['option4'],
        question: data['question'],
        rightAnswer: data['rightAnswer']);
  }
  Map<String, dynamic> toMap() {
    return {
      'imageURL': imageURL,
      'question': question,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
      'rightAnswer': rightAnswer,
    };
  }
}
