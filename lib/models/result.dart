class Result {
  String id;
  int times;
  String userid;
  int score;
  String name;
  Result({
    required this.name,
    required this.id,
    required this.score,
    required this.times,
    required this.userid,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'score': score,
      'times': times,
      'userid': userid,
    };
  }

  factory Result.fromMap(Map<String, dynamic> data) {
    return Result(
        name: data['name'],
        id: data['id'],
        score: data['score'],
        times: data['times'],
        userid: data['userid']);
  }
}
