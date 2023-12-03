import 'dart:io';

class Day3 {
  /// The engine schematic (your puzzle input) consists of a visual representation of the engine. There are lots of
  /// numbers and symbols you don't really understand, but apparently any number adjacent to a symbol,
  /// even diagonally, is a "part number" and should be included in your sum. (Periods (.) do not count as a symbol.)
  final File _input = File('./input/day3.txt');

  Future<List<String>> get _inputLines => _input.readAsLines();

  Future<List<String>> loadEngineSchematics() async {
    final List<String> inputLines = await _inputLines;
    return inputLines;
  }

  /// What is the sum of all of the part numbers in the engine schematic?
  Future<int> part1() async {
    List<String> engineSchematics = await loadEngineSchematics();

    List<int> validPartNumbers = [];
    for (int y = 0; y < engineSchematics.length; y++) {
      String currentLine = engineSchematics[y];
      for (int x = 0; x < currentLine.length; /* NOOP */) {
        String currChar = currentLine[x];
        // is the char a digit?
        if (isDigit(currChar)) {
          // if true, extract the actual number
          String numberStr = extractNumberFromPosition(currentLine, x);
          // is the number is a valid part number according to the task
          bool valid = isValidPartNumber(numberStr, y, x, engineSchematics);
          if (valid) {
            validPartNumbers.add(int.parse(numberStr));
          }

          x += numberStr.length;
        } else {
          x++;
        }
      }
    }

    return validPartNumbers.reduce((value, element) => value + element);
  }

  /// A gear is any * symbol that is adjacent to exactly two part numbers. Its gear ratio is the result of
  /// multiplying those two numbers together.
  /// What is the sum of all of the gear ratios in your engine schematic?
  Future<int> part2() async {
    List<String> engineSchematics = await loadEngineSchematics();

    List<List<int>> gearsRatios = [];
    for (int y = 0; y < engineSchematics.length; y++) {
      String currentLine = engineSchematics[y];

      for (int x = 0; x < currentLine.length; x++) {
        bool isGearCharacter = currentLine[x] == '*';
        if (isGearCharacter) {
          Set<(int row, int startCol, int endCol)> gearsStrStartEnd = {};

          // if is gear, get position to check for number
          List<(int gY, int gX)> adjacentGerPositions = positionToValidate(y, x, engineSchematics);

          for ((int pY, int pX) pos in adjacentGerPositions) {
            if (isDigit(engineSchematics[pos.$1][pos.$2])) {
              // is adjacent position is digit, extract complete number and add to the set
              (int, int) gearStrStartEnd = extractNumberComplete(engineSchematics[pos.$1], pos.$2);
              gearsStrStartEnd.add((pos.$1, gearStrStartEnd.$1, gearStrStartEnd.$2));
            }
          }

          if (gearsStrStartEnd.isNotEmpty) {
            List<int> gears;
            gears = gearsStrStartEnd.map((e) => int.parse(engineSchematics[e.$1].substring(e.$2, e.$3))).toList();
            gearsRatios.add(gears);
          }
        }
      }
    }

    int result = gearsRatios
        .where((e) => e.length == 2) // filter
        .map((e) => e.reduce((value, element) => value * element)) // compute gear ratio
        .reduce((value, element) => value + element); // sum

    return result;
  }

  bool isDigit(String char) {
    if (char.isEmpty || char.length > 1) {
      return false;
    }

    int charCode = char.codeUnits.first;
    return charCode >= 48 /* 0 */ && charCode <= 57 /* 9 */;
  }

  String extractNumberFromPosition(String str, int startIndex) {
    int endIndex = startIndex;
    for (int i = endIndex; i < str.length; /* NOOP */) {
      if (!isDigit(str[i])) break;
      endIndex = ++i;
    }
    return str.substring(startIndex, endIndex);
  }

  (int startIndex, int endIndex) extractNumberComplete(String str, int index) {
    int startIndex = index;
    int endIndex = startIndex;

    for (int i = startIndex; i >= 0; i--) {
      if (!isDigit(str[i])) break;
      startIndex = i;
    }

    for (int i = endIndex; i < str.length; /* NOOP */) {
      if (!isDigit(str[i])) break;
      endIndex = ++i;
    }
    return (startIndex, endIndex);
  }

  bool isValidPartNumber(String partNumber, int startRow, int startCol, List<String> engineSchematics) {
    bool isValidPosition(int y, int x, List<String> engineSchematics) {
      List<(int, int)> positions = positionToValidate(y, x, engineSchematics);
      for ((int pY, int pX) pos in positions) {
        String testValue = engineSchematics[pos.$1][pos.$2];
        if (isDigit(testValue)) continue;
        if (testValue == '.') continue;
        return true;
      }
      return false;
    }

    // iterate over all number positions in the matrix
    for (int i = startCol; i < startCol + partNumber.length; i++) {
      if (isValidPosition(startRow, i, engineSchematics)) {
        return true;
      }
    }
    return false;
  }

  List<(int y, int x)> positionToValidate(int y, int x, List<String> engineSchematics) {
    List<(int y, int x)> resultPosition = [
      (y - 1, x - 1),
      (y - 1, x),
      (y - 1, x + 1),
      (y, x - 1),
      (y, x + 1),
      (y + 1, x - 1),
      (y + 1, x),
      (y + 1, x + 1),
    ];

    int maxY = engineSchematics.length;
    int maxX = engineSchematics[y].length;

    resultPosition.removeWhere((element) {
      int y = element.$1;
      int x = element.$2;

      if (y < 0 || x < 0) return true;
      if (y >= maxY || x >= maxX) return true;

      return false;
    });

    return resultPosition;
  }
}
