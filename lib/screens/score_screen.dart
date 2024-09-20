import 'package:escape_birdie/scoreboard/fetch_score.dart';
import 'package:escape_birdie/scoreboard/score_model.dart';
import 'package:flutter/material.dart';
import 'package:escape_birdie/game/bird_escape_game.dart';

class ScoreScreen extends StatelessWidget {
  static const String id = 'score';

  final BirdEscapeGame game;

  const ScoreScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: SafeArea(
        child: Center(
          child: FutureBuilder<List<Score>>(
            future: fetchScores(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: Colors.orange,
                );
              } else if (snapshot.hasError) {
                String errorMessage = snapshot.error.toString();

                // Custom error message for no internet connection
                if (errorMessage.contains('No Internet connection')) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wifi_off,
                          size: 100, color: Colors.orange),
                      const SizedBox(height: 20),
                      const Text(
                        'No Internet connection',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          onRestart();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text(
                          'Play Again',
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'Game',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return Text('Error: $errorMessage');
              } else if (snapshot.hasData) {
                final scores = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),

                    // Enhanced "Top Scores" Title
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 40),
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
                        'Top 10 Scores Ever',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontFamily: 'Game',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Score List
                    Expanded(
                      child: ListView.builder(
                        itemCount: scores.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Card(
                              color: Colors.black54,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 8.0,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.orangeAccent,
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  scores[index].name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Text(
                                  scores[index].score.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // "Try to Beat Them" Button
                    ElevatedButton(
                      onPressed: () {
                        onRestart();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        'Try to Beat Them',
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Game',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              } else {
                return const Text('No scores found.');
              }
            },
          ),
        ),
      ),
    );
  }

  void onRestart() {
    game.bird.reset();
    game.overlays.remove('score');
    game.resumeEngine();
  }
}
