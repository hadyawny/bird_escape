import 'package:escape_birdie/game/assets.dart';
import 'package:escape_birdie/game/bird_escape_game.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  static const String id = 'gameOver';

  final BirdEscapeGame game;
  const GameOverScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.gameOver),
            const SizedBox(height: 20),
            Text(
              'Score: ${game.bird.score}',
              style: const TextStyle(
                fontSize: 60,
                color: Colors.white,
                fontFamily: 'Game',
              ),
            ),
            Text(
              'High Score: ${game.highest}', // Display highest score
              style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontFamily: 'Game',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRestart,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text(
                'Restart',
                style: TextStyle(fontSize: 40, fontFamily: 'game'),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                game.overlays.remove('gameOver');

                game.overlays.add('score');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text(
                'View Top Scores',
                style: TextStyle(fontSize: 40, fontFamily: 'game'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onRestart() {
    game.bird.reset();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}
