import 'package:flutter/material.dart';
import 'crossword_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crossword Game")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DifficultyButton(level: "Easy", gridSize: 6),
            DifficultyButton(level: "Medium", gridSize: 8),
            DifficultyButton(level: "Hard", gridSize: 10),
          ],
        ),
      ),
    );
  }
}

class DifficultyButton extends StatelessWidget {
  final String level;
  final int gridSize;

  const DifficultyButton({super.key, required this.level, required this.gridSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(200, 50)),
        child: Text(level, style: const TextStyle(fontSize: 20)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CrosswordScreen(level: level, gridSize: gridSize),
            ),
          );
        },
      ),
    );
  }
}
