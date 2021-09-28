class Result {
  String id;
  int times;
  String userid;
  int score;
  Result({
    required this.id,
    required this.score,
    required this.times,
    required this.userid,
  });

  Map<String, dynamic> toMap() {
    return {
      'score': score,
      'times': times,
      'userid': userid,
    };
  }

  factory Result.fromMap(Map<String, dynamic> data) {
    return Result(
        id: data['id'],
        score: data['score'],
        times: data['times'],
        userid: data['userid']);
  }
}
