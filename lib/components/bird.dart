import 'package:escape_birdie/game/assets.dart';
import 'package:escape_birdie/game/bird_escape_game.dart';
import 'package:escape_birdie/game/bird_movement.dart';
import 'package:escape_birdie/game/configuration.dart';
import 'package:escape_birdie/scoreboard/fetch_score.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<BirdEscapeGame>, CollisionCallbacks {
  int score = 0;

  @override
  Future<void> onLoad() async {
    final birdMidFlap = await gameRef.loadSprite(Assets.birdMidFlap);
    final birdUpFlap = await gameRef.loadSprite(Assets.birdUpFlap);
    final birdDownFlap = await gameRef.loadSprite(Assets.birdDownFlap);

    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    sprites = {
      BirdMovement.middle: birdMidFlap,
      BirdMovement.up: birdUpFlap,
      BirdMovement.down: birdDownFlap,
    };
    current = BirdMovement.middle;
    add(CircleHitbox());
  }

  void fly() {
    add(
      MoveByEffect(
        Vector2(0, Config.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = BirdMovement.down,
      ),
    );
    current = BirdMovement.up;
    FlameAudio.play(Assets.flying);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    gameOver();
  }

 void gameOver() async {
  FlameAudio.play(Assets.collision);
  gameRef.pauseEngine(); // Pause the game engine
  game.isHit = true;
  
  // Update the highest score
  gameRef.updateHighestScore();
  gameRef.overlays.add('gameOver'); // Show regular game over overlay
  
  // Fetch current top scores
  final scores = await fetchScores();

  // Check if the player's score qualifies for the top 10
  if (scores.length < 10 || score > scores.last.score) {
    gameRef.overlays.remove('gameOver'); // Show regular game over overlay
    gameRef.overlays.add('newTopScore'); // Show NewTopScoreScreen overlay
  } 

}


  void reset() {
    score = 0;
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += Config.birdVelocity * dt;
    if (position.y < 1) {
      gameOver();
    }
  }
}
