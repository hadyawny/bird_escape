import 'package:escape_birdie/game/bird_escape_game.dart';
import 'package:escape_birdie/scoreboard/post_score.dart';
import 'package:flutter/material.dart';

class NewTopScoreScreen extends StatefulWidget {
  static const String id = 'newTopScore';

  final BirdEscapeGame game;
  const NewTopScoreScreen({super.key, required this.game});

  @override
  _NewTopScoreScreenState createState() => _NewTopScoreScreenState();
}

class _NewTopScoreScreenState extends State<NewTopScoreScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        color: Colors.black38,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Text(
                  'You Entered The Top 10',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.yellow,
                    fontFamily: 'Game',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'what should we call you?',
                    hintStyle: TextStyle(color: Colors.grey),
                    errorText: _errorMessage,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _isSubmitting
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submitScore,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                      child: const Text(
                        'Submit Score',
                        style: TextStyle(fontSize: 30, fontFamily: 'Game'),
                      ),
                    ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  widget.game.overlays.remove('newTopScore');
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text(
                  'Restart',
                  style: TextStyle(fontSize: 30, fontFamily: 'Game'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitScore() async {
    final playerName = _nameController.text;

    if (playerName.isEmpty) {
      setState(() {
        _errorMessage = "Name cannot be empty";
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    final success = await postScore(playerName, widget.game.bird.score);

    setState(() {
      _isSubmitting = false;
    });

    if (success) {
      // Handle success, maybe switch to leaderboard screen
      widget.game.overlays.remove('newTopScore');
      widget.game.overlays.add('score');
    } else {
      setState(() {
        _errorMessage = "Failed to submit score, try again";
      });
    }
  }
}
