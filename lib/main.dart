import 'package:bird_escape/game/bird_escape_game.dart';
import 'package:bird_escape/screens/game_over_screen.dart';
import 'package:bird_escape/screens/main_menu_screen.dart';
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
