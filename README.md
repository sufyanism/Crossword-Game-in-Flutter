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


## 📂 Project Structure
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

## 📌 Screencasts
https://github.com/user-attachments/assets/6d5827ef-fffb-4cac-b13b-f8b34078cfc6

## About Me 
✨ I’m **Sufyan bin Uzayr**, an open-source developer passionate about building and sharing meaningful projects.
You can learn more about me and my work at [sufyanism.com](https://sufyanism.com/) or connect with me on [Linkedin](https://www.linkedin.com/in/sufyanism)

## Your all-in-one learning hub! 
🚀 Explore courses and resources in coding, tech, and development at **zeba.academy** and **code.zeba.academy**. Empower yourself with practical skills through curated tutorials, real-world projects, and hands-on experience. Level up your tech game today! 💻✨

**Zeba Academy**  is a learning platform dedicated to **coding**, **technology**, and **development**.  
➡ Visit our main site: [zeba.academy](https://zeba.academy)   </br>
➡ Explore hands-on courses and resources at: [code.zeba.academy](https://code.zeba.academy)   </br>
➡ Check out our YouTube for more tutorials: [zeba.academy](https://www.youtube.com/@zeba.academy)  </br>
➡ Follow us on Instagram: [zeba.academy](https://www.instagram.com/zeba.academy/)  </br>

**Thank you for visiting!**


