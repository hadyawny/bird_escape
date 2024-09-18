import 'package:bird_escape/game/assets.dart';
import 'package:bird_escape/game/bird_escape_game.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  static const String id = 'mainMenu';
  final BirdEscapeGame game;

  const MainMenuScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          game.overlays.remove('mainMenu');
          game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.menu),
              fit: BoxFit.cover,
            ),
          ),
          child: Image.asset(Assets.message),
        ),
      ),
    );
  }
}
