import 'package:bird_escape/components/background.dart';
import 'package:bird_escape/components/bird.dart';
import 'package:bird_escape/components/ground.dart';
import 'package:bird_escape/components/pipe_group.dart';
import 'package:bird_escape/game/configuration.dart';
import 'package:bird_escape/game/scoreManager.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'package:flutter/painting.dart';

class BirdEscapeGame extends FlameGame with TapDetector, HasCollisionDetection {
  BirdEscapeGame();

  late Bird bird;
  Timer interval = Timer(Config.pipeInterval, repeat: true);
  bool isHit = false;
  late TextComponent score;
  late TextComponent highestScore;
  int highest = 0;

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
      score = buildScore(),

    ]);

   // Load the highest score from shared preferences
    highest = await ScoreManager.getHighestScore();

    interval.onTick = () => add(PipeGroup());
  }

  TextComponent buildScore() {
    return TextComponent(
        position: Vector2(size.x / 2, size.y / 2 * 0.2),
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: const TextStyle(
              fontSize: 40, fontFamily: 'Game', fontWeight: FontWeight.bold),
        ));
  }



  @override
  void onTap() {
    bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'Score: ${bird.score}';

  }
    void updateHighestScore() async{
    if (bird.score > highest) {
      highest = bird.score;
      await ScoreManager.setHighestScore(highest); // Save the new highest score

    }
  } 
}
