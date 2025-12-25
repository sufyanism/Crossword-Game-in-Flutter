class CrosswordData {
  static Map<String, dynamic> getPuzzle(String level) {
    // EASY (6x6)
    if (level == "Easy") {
      final across = {
        1: "Small pet animal",
        3: "A loyal barking pet",
      };
      final down = {
        2: "Opposite of up",
      };

      return {
        "solution": [
          ["C", "A", "T", "", "", ""],
          ["", "", "A", "", "", ""],
          ["D", "O", "G", "", "", ""],
          ["", "", "", "", "", ""],
          ["", "", "", "", "", ""],
          ["", "", "", "", "", ""],
        ],
        "blocked": [
          [false, false, false, true, true, true],
          [true, true, false, true, true, true],
          [false, false, false, true, true, true],
          [true, true, true, true, true, true],
          [true, true, true, true, true, true],
          [true, true, true, true, true, true],
        ],
        "across": across,
        "down": down,
        "across_clues": across.entries.map((e) => "${e.key}. ${e.value}").toList(),
        "down_clues": down.entries.map((e) => "${e.key}. ${e.value}").toList(),
        "acrossWords": [
          {"num": 1, "row": 0, "col": 0, "length": 3},
          {"num": 3, "row": 2, "col": 0, "length": 3},
        ],
        "downWords": [
          {"num": 2, "row": 0, "col": 2, "length": 3},
        ],
      };
    }

    // MEDIUM (8x8)
    if (level == "Medium") {
      final across = {
        1: "UI development framework",
        2: "Programming language (short)",
      };
      final down = {
        3: "What you use to build apps",
      };

      return {
        "solution": [
          ["F", "L", "U", "T", "T", "E", "R", ""],
          ["", "", "", "A", "", "", "", ""],
          ["D", "A", "R", "T", "", "", "", ""],
          ["", "", "T", "", "", "", "", ""],
          ["", "", "", "", "", "", "", ""],
          ["", "", "", "", "", "", "", ""],
          ["", "", "", "", "", "", "", ""],
          ["", "", "", "", "", "", "", ""],
        ],
        "blocked": List.generate(8, (r) => List.generate(8, (c) => false)),
        "across": across,
        "down": down,
        "across_clues": across.entries.map((e) => "${e.key}. ${e.value}").toList(),
        "down_clues": down.entries.map((e) => "${e.key}. ${e.value}").toList(),
        "acrossWords": [
          {"num": 1, "row": 0, "col": 0, "length": 7},
          {"num": 2, "row": 2, "col": 0, "length": 4},
        ],
        "downWords": [
          {"num": 3, "row": 0, "col": 3, "length": 4},
        ],
      };
    }

    // HARD (10x10) — empty puzzle with no clues (placeholder)
    final across = <int, String>{};
    final down = <int, String>{};

    return {
      "solution": List.generate(10, (r) => List.generate(10, (c) => "")),
      "blocked": [
        [false, false, true, false, false, false, true, false, false, false],
        [false, false, true, false, false, false, true, false, false, false],
        [true, true, true, false, false, false, true, true, true, false],
        [false, false, false, false, true, false, false, false, false, false],
        [false, true, false, false, true, false, false, true, false, false],
        [false, false, false, true, true, true, false, false, false, false],
        [false, false, false, false, true, false, false, false, false, false],
        [false, true, true, false, false, false, true, true, false, false],
        [false, false, false, false, false, false, false, false, false, false],
        [true, false, false, true, false, false, true, false, false, true],
      ],
      "across": across,
      "down": down,
      "across_clues": [],
      "down_clues": [],
      "acrossWords": [],
      "downWords": [],
    };
  }
}
