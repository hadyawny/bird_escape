import 'dart:convert';
import 'package:http/http.dart' as http;
import 'score_model.dart';

Future<List<Score>> fetchScores() async {
  final response = await http
      .get(Uri.parse('https://escape-birdie-score-list.onrender.com/score'));

  if (response.statusCode == 200) {
    List<dynamic> scoresJson = json.decode(response.body);
    print(scoresJson);
    return scoresJson.map((json) => Score.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load scores');
  }
}
