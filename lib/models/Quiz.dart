import 'package:quiz_maker/models/Question.dart';

class Quiz {
  String code;
  String id;
  String imageURL;
  String title;
  Quiz({
    required this.id,
    required this.code,
    required this.imageURL,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'id': id,
      'title': title,
      'imageURL': imageURL,
    };
  }

  Map<String, dynamic> toMapCode() {
    return {
      'code': code,
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return Quiz(
          code: '', imageURL: '', title: '', id: '');
    }
    return Quiz(
        code: data['code'],
        imageURL: data['imageURL'],
        title: data['title'],
        id: data['id']);
  }
}
