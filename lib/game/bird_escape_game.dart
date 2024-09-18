import 'dart:async';
import 'package:bird_escape/components/background.dart';
import 'package:bird_escape/components/bird.dart';
import 'package:bird_escape/components/ground.dart';
import 'package:bird_escape/components/pipe_group.dart';
import 'package:bird_escape/game/configuration.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

class BirdEscapeGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  Timer? pipeSpawnTimer;  // Define the Dart Timer
  bool isHit = false;

  @override
  FutureOr<void> onLoad() async {
    addAll([
      Background(),
      Ground(),
      bird = Bird(),
    ]);

    pipeSpawnTimer = Timer.periodic(
      Duration(milliseconds: 1500),  // Define the interval
      (timer) {
        add(PipeGroup());
      },
    );
  }

  @override
  void onTap() {
    bird.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isHit) {
      removePipes();
      isHit = false;
    }
  }

  void removePipes() {
    // Remove only the pipes
    children.where((c) => c is PipeGroup).forEach((component) {
      component.removeFromParent();
    });
  }

  void restartGame() {
    // Reset the bird's position
    bird.reset();

    // Remove only the pipes
    removePipes();

    // Restart the pipe spawn timer
    pipeSpawnTimer?.cancel();
    pipeSpawnTimer = Timer.periodic(
      Duration(milliseconds: 1500),
      (timer) {
        add(PipeGroup());
      },
    );
  }
}
