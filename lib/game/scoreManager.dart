import 'package:shared_preferences/shared_preferences.dart';

class ScoreManager {
  static const String _highestScoreKey = 'highestScore';

  static Future<int> getHighestScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_highestScoreKey) ?? 0;
  }

  static Future<void> setHighestScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_highestScoreKey, score);
  }
}
