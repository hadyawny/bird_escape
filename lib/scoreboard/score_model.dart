class Score {
  final String name;
  final int score;

  Score({required this.name, required this.score});

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      name: json['name'],
      score: json['score'],
    );
  }
}
