import 'package:escape_birdie/scoreboard/post_score.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:escape_birdie/game/bird_escape_game.dart';
import 'package:flutter/cupertino.dart';

class NewTopScoreScreen extends StatefulWidget {
  static const String id = 'newTopScore';

  final BirdEscapeGame game;
  final int playerScore;

  const NewTopScoreScreen(
      {super.key, required this.game, required this.playerScore});

  @override
  State<NewTopScoreScreen> createState() => _NewTopScoreScreenState();
}

class _NewTopScoreScreenState extends State<NewTopScoreScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool isSubmitting = false;

  Future<void> _submitScore() async {
    setState(() {
      isSubmitting = true;
    });

    final playerName = _nameController.text;

    if (playerName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name!')),
      );
      setState(() {
        isSubmitting = false;
      });
      return;
    }

    final success = await postScore(playerName, widget.playerScore);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Score submitted successfully!')),
      );
      widget.game.overlays.remove('newTopScore');
      widget.game.overlays.add('score');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit score.')),
      );
    }

    setState(() {
      isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'New High Score!',
              style: TextStyle(
                fontSize: 40,
                color: Colors.orange,
                fontFamily: 'Game',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter Your Name',
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontFamily: 'Game',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.game.overlays.remove('newTopScore');

                widget.game.overlays.add('score');
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
}
