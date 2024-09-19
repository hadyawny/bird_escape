import 'dart:async';
import 'dart:math';

import 'package:escape_birdie/components/pipe.dart';
import 'package:escape_birdie/game/assets.dart';
import 'package:escape_birdie/game/bird_escape_game.dart';
import 'package:escape_birdie/game/configuration.dart';
import 'package:escape_birdie/game/pipe_position.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

class PipeGroup extends PositionComponent with HasGameRef<BirdEscapeGame> {
  PipeGroup();

  final _random = Random();

  @override
  FutureOr<void> onLoad() async {
    position.x = gameRef.size.x;

    // Define the height of the game area minus the ground height
    final heightMinusGround = gameRef.size.y - Config.groundHeight;

    // Define a reasonable gap range between pipes (adjust these values for difficulty)
    const double minPipeGap = 150; // Minimum gap size
    const double maxPipeGap = 250; // Maximum gap size

    // Calculate a random gap between the two pipes within the defined range
    final double pipeGap =
        minPipeGap + _random.nextDouble() * (maxPipeGap - minPipeGap);

    // Define a safe range for the centerY, so it's not too high or too low
    final double minYPosition =
        pipeGap / 2 + 50; // Avoid pipes spawning too high
    final double maxYPosition =
        heightMinusGround - (pipeGap / 2 + 50); // Avoid pipes spawning too low

    // Randomly choose the vertical center of the gap, but within safe limits
    final double centerY =
        minYPosition + _random.nextDouble() * (maxYPosition - minYPosition);

    // Add the top and bottom pipes with the calculated gap
    addAll([
      Pipe(pipePosition: PipePosition.top, height: centerY - pipeGap / 2),
      Pipe(
          pipePosition: PipePosition.bottom,
          height: heightMinusGround - (centerY + pipeGap / 2)),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Move the pipes from right to left
    position.x -= Config.gameSpeed * dt;

    // Remove the pipes when they move off-screen
    if (position.x < -10) {
      removeFromParent();
      updateScore();
    }

    // Remove pipes on bird collision
    if (gameRef.isHit) {
      removeFromParent();
      gameRef.isHit = false;
    }
  }

  void updateScore() {
    gameRef.bird.score += 1;
    FlameAudio.play(Assets.point);
  }
}
