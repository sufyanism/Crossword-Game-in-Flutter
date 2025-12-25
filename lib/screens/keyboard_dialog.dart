import 'package:flutter/material.dart';

class LetterKeyboardDialog extends StatelessWidget {
  final List<String> letters = List.generate(26, (i) => String.fromCharCode(65 + i));

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Letter"),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 320,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (String letter in letters)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: const Size(45, 45)),
                  onPressed: () => Navigator.pop(context, letter),
                  child: Text(letter, style: const TextStyle(fontSize: 18)),
                ),
              TextButton(
                onPressed: () => Navigator.pop(context, "DELETE"),
                child: const Text("Clear"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
