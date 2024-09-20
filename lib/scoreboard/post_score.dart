import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> postScore(String playerName, int score) async {
  final newScoreData = {
    'name': playerName,
    'score': score,
  };

  final url = Uri.parse('https://escape-birdie-score-list.onrender.com/score');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newScoreData),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  } catch (error) {
    print('Error: $error'); // Log the error for debugging
    return false;
  }
}
