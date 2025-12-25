import 'package:flutter/material.dart';
import '../utils/crossword_data.dart';
import 'keyboard_dialog.dart';

class CrosswordScreen extends StatefulWidget {
  final String level;
  final int gridSize;

  const CrosswordScreen({
    super.key,
    required this.level,
    required this.gridSize,
  });

  @override
  State<CrosswordScreen> createState() => _CrosswordScreenState();
}

class _CrosswordScreenState extends State<CrosswordScreen> {
  late List<List<String>> board;
  late List<List<bool>> isBlackCell;
  late List<String> acrossClues;
  late List<String> downClues;

  late Map<int, Map<String, int>> acrossWords;
  late Map<int, Map<String, int>> downWords;

  int? selectedRow;
  int? selectedCol;
  bool selectingAcross = true;

  @override
  void initState() {
    super.initState();
    var data = CrosswordData.getPuzzle(widget.level);

    // Safe conversion -> List<List<String>>
    board = (data["solution"] as List)
        .map<List<String>>((row) => (row as List).map((c) => c.toString()).toList())
        .toList();

    isBlackCell = (data["blocked"] as List).map<List<bool>>((r) => List<bool>.from(r)).toList();

    acrossClues = List<String>.from(data["across_clues"] ?? []);
    downClues = List<String>.from(data["down_clues"] ?? []);

    acrossWords = {
      for (var w in (data["acrossWords"] as List)) w["num"]: Map<String, int>.from(w),
    };
    downWords = {
      for (var w in (data["downWords"] as List)) w["num"]: Map<String, int>.from(w),
    };
  }

  // ---------- word helpers ----------
  List<Map<String, int>> getAcrossWordCells(int row, int col) {
    int start = col;
    while (start > 0 && !isBlackCell[row][start - 1]) start--;
    int end = col;
    while (end < widget.gridSize - 1 && !isBlackCell[row][end + 1]) end++;
    return [for (int c = start; c <= end; c++) {"r": row, "c": c}];
  }

  List<Map<String, int>> getDownWordCells(int row, int col) {
    int start = row;
    while (start > 0 && !isBlackCell[start - 1][col]) start--;
    int end = row;
    while (end < widget.gridSize - 1 && !isBlackCell[end + 1][col]) end++;
    return [for (int r = start; r <= end; r++) {"r": r, "c": col}];
  }

  // ---------- validation helpers ----------
  bool isWordComplete(List<Map<String, int>> cells) {
    for (var cell in cells) {
      if (board[cell["r"]!][cell["c"]!].isEmpty) return false;
    }
    return true;
  }

  bool isWordCorrect(List<Map<String, int>> cells, List<List<String>> solution) {
    for (var cell in cells) {
      int r = cell["r"]!;
      int c = cell["c"]!;
      if (board[r][c] != solution[r][c]) return false;
    }
    return true;
  }

  // ---------- highlight / color ----------
  bool isCellInSelectedWord(int r, int c) {
    if (selectedRow == null || selectedCol == null) return false;
    var cells = selectingAcross ? getAcrossWordCells(selectedRow!, selectedCol!) : getDownWordCells(selectedRow!, selectedCol!);
    return cells.any((e) => e["r"] == r && e["c"] == c);
  }

  Color getCellColor(int r, int c) {
    if (isBlackCell[r][c]) return Colors.black;

    // if selected word contains this cell, show validation background or highlight
    if (isCellInSelectedWord(r, c)) {
      var cells = selectingAcross ? getAcrossWordCells(selectedRow!, selectedCol!) : getDownWordCells(selectedRow!, selectedCol!);

      if (isWordComplete(cells)) {
        // check against solution from data
        var solution = (CrosswordData.getPuzzle(widget.level)["solution"] as List)
            .map<List<String>>((row) => (row as List).map((c) => c.toString()).toList())
            .toList();

        bool correct = isWordCorrect(cells, solution);
        return correct ? Colors.green.shade200 : Colors.red.shade200;
      }

      // incomplete but selected -> highlight
      return Colors.yellow.shade200;
    }

    return Colors.white;
  }

  // ---------- navigation ----------
  void moveToNextCell() {
    if (selectedRow == null || selectedCol == null) return;
    var cells = selectingAcross ? getAcrossWordCells(selectedRow!, selectedCol!) : getDownWordCells(selectedRow!, selectedCol!);
    int idx = cells.indexWhere((e) => e["r"] == selectedRow && e["c"] == selectedCol);
    if (idx < 0) return;
    if (idx < cells.length - 1) {
      setState(() {
        selectedRow = cells[idx + 1]["r"];
        selectedCol = cells[idx + 1]["c"];
      });
    }
  }

  // ---------- input ----------
  void onCellTap(int row, int col) async {
    if (isBlackCell[row][col]) return;

    // detect direction: prefer across if left exists, otherwise down
    bool canLeft = col > 0 && !isBlackCell[row][col - 1];
    bool canUp = row > 0 && !isBlackCell[row - 1][col];
    selectingAcross = canLeft || !canUp;

    setState(() {
      selectedRow = row;
      selectedCol = col;
    });

    String? letter = await showDialog(context: context, builder: (_) => LetterKeyboardDialog());
    if (letter == null) return;
    if (letter == "DELETE") {
      setState(() => board[row][col] = "");
      return;
    }

    setState(() {
      board[row][col] = letter.toUpperCase();
    });

    moveToNextCell();
  }

  void jumpToClue(int number, bool across) {
    var w = across ? acrossWords[number] : downWords[number];
    if (w == null) return;
    setState(() {
      selectingAcross = across;
      selectedRow = w["row"];
      selectedCol = w["col"];
    });
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cellSize = (screenWidth - 40) / widget.gridSize; // slightly smaller to give margins

    return Scaffold(
      appBar: AppBar(title: Text("${widget.level} Crossword")),
      body: Column(
        children: [
          // grid area
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: InteractiveViewer(
                  minScale: 0.6,
                  maxScale: 3.5,
                  child: Column(
                    children: [
                      for (int r = 0; r < widget.gridSize; r++)
                      // FittedBox ensures row never overflows horizontally
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            children: [
                              for (int c = 0; c < widget.gridSize; c++)
                                GestureDetector(
                                  onTap: () => onCellTap(r, c),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 120),
                                    width: cellSize,
                                    height: cellSize,
                                    margin: const EdgeInsets.all(2),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: getCellColor(r, c),
                                      border: Border.all(
                                        color: (selectedRow == r && selectedCol == c) ? Colors.blue : Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: isBlackCell[r][c]
                                        ? null
                                        : Text(
                                      board[r][c],
                                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // clues area
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Across", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 6),
                for (String clue in acrossClues)
                  GestureDetector(
                    onTap: () {
                      int num = int.tryParse(clue.split(".").first) ?? -1;
                      if (num > 0) jumpToClue(num, true);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text("• $clue", style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                const SizedBox(height: 10),
                const Text("Down", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 6),
                for (String clue in downClues)
                  GestureDetector(
                    onTap: () {
                      int num = int.tryParse(clue.split(".").first) ?? -1;
                      if (num > 0) jumpToClue(num, false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text("• $clue", style: const TextStyle(fontSize: 16)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
