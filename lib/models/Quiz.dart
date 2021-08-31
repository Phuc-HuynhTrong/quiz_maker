import 'package:quiz_maker/models/Question.dart';

class Quiz {
  String code;
  String id;
  String imageURL;
  String title;
  List<String> listQuestion;
  Quiz({
    required this.id,
    required this.code,
    required this.listQuestion,
    required this.imageURL,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'id': id,
      'listQuestion': listQuestion,
      'title': title,
      'imageURL': imageURL,
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> data) {
    List<String> list = [];
    if (data == null) {
      return Quiz(
          code: '', listQuestion: list, imageURL: '', title: '', id: '');
    }
    return Quiz(
        code: data['code'],
        listQuestion: data['listQuestion'],
        imageURL: data['imageURL'],
        title: data['title'],
        id: data['id']);
  }
}
