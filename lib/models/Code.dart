class Code {
  String id;
  String code ;
  Code({
    required this.id,
    required this.code,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'id': id,
    };
  }

  factory Code.fromMap(Map<String, dynamic> data) {
    return Code(
        id: data['id'],
        code: data['code']);
  }
}
