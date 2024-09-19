import 'package:escape_birdie/game/bird_escape_game.dart';
import 'package:escape_birdie/screens/game_over_screen.dart';
import 'package:escape_birdie/screens/main_menu_screen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final game = BirdEscapeGame();

  runApp(GameWidget(
    game: game,
    initialActiveOverlays: const [MainMenuScreen.id],
    overlayBuilderMap: {
      'mainMenu': (context, _) => MainMenuScreen(game: game),
      'gameOver': (context, _) => GameOverScreen(game: game),

    },
  ));
}
