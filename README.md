# Crossword Game App
A simple and interactive Flutter Crossword Game where users can solve crosswords of different difficulty levels (Easy, Medium, Hard). This app demonstrates dynamic crossword generation, cell selection, and interactive clue navigation.

## 📂 Features
1. Multiple difficulty levels: Easy (6x6), Medium (8x8), Hard (10x10)
2. Interactive crossword grid with tap-to-select cells
3. Highlighting of selected words (Across/Down)
4. Letter input using a custom dialog keyboard
5. Validation: correct/incorrect words are highlighted
6. Scrollable and zoomable grid for larger puzzles
7. Tap on clues to jump to the corresponding word
8. Responsive layout


```plaintext
lib/
├─ main.dart                # Entry point
├─ screens/
│  ├─ home_screen.dart      # Difficulty selection
│  ├─ crossword_screen.dart # Crossword grid and gameplay
│  └─ keyboard_dialog.dart  # Letter input dialog
├─ utils/
│  └─ crossword_data.dart   # Puzzle data for each level
```



## 🚀 Getting Started
Prerequisites: 

Flutter SDK >= 3.0.0
Dart >= 2.18.0
Android Studio / VS Code or any IDE for Flutter development

## Installation
1. Clone the repository:
git clone https://github.com/yourusername/crossword_game_app.git
cd crossword_game_app

2. Install dependencies:
flutter pub get

3. Run the app:
flutter run

## 🕹 How to Play
1. Open the app → Home screen appears with difficulty levels.
2. Tap Easy, Medium, or Hard to start a puzzle.
3. Tap a cell in the grid to select a word (Across/Down automatically detected).
4. Input a letter using the custom keyboard.
5. Correct words turn green, incorrect words turn red, and incomplete words are highlighted yellow.
6. Tap a clue to jump directly to that word.

## 🧩 Crossword Data
The crossword puzzles are stored in lib/utils/crossword_data.dart:
• solution → The correct letters for each cell.
• blocked → Cells that are blacked out.
• across & down → Clues for each direction.
• acrossWords & downWords → Word positions for navigation.

## ⚙️ Customization
• Add new puzzles by editing the CrosswordData.getPuzzle() function.
• Change grid size, clues, and solutions per level.
• Customize the theme in main.dart using ThemeData.

## 📌 Screenshots
(Add screenshots here using GitHub Markdown syntax)



