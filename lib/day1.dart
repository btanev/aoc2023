import 'dart:io';

class Day1 {
  final File _input = File('./input/day1.txt');
  Future<List<String>> get _inputLines => _input.readAsLines();

  /// The newly-improved calibration document consists of lines of text; each line originally contained a specific
  /// calibration value that the Elves now need to recover. On each line, the calibration value can be found by combining
  /// the first digit and the last digit (in that order) to form a single two-digit number.
  Future<int> part1() async {
    final List<String> inputLines = await _inputLines;
    final RegExp regExp = RegExp('[0-9]');

    List<int> lineResults = [];
    for (String line in inputLines) {
      int firstPosition = line.indexOf(regExp);
      int lastPosition = line.lastIndexOf(regExp);

      int lineResult = int.parse('${line[firstPosition]}${line[lastPosition]}');
      lineResults.add(lineResult);
    }

    return lineResults.reduce((value, element) => value + element);
  }

  /// Your calculation isn't quite right. It looks like some of the digits are actually spelled out with letters: one,
  /// two, three, four, five, six, seven, eight, and nine also count as valid "digits".
  Future<int> part2() async {
    List<String> inputLines = await _inputLines;
    List<int> lineResults = [];

    final List<String> numberStrings = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'];
    final RegExp regExp = RegExp('[(0-9)]|${numberStrings.map((e) => '($e)').join('|')}');

    int matchNumber(String matchingString) {
      int groupIndex = numberStrings.indexOf(matchingString);
      if (groupIndex == -1) {
        return int.parse(matchingString);
      } else {
        return groupIndex + 1;
      }
    }

    for (String line in inputLines) {
      List<RegExpMatch> matches = regExp.allMatches(line).toList();
      RegExpMatch firstMatch = matches.first;
      RegExpMatch lastMatch = matches.last;

      String firstMatchString = firstMatch.group(0)!;
      String lastMatchString = lastMatch.group(0)!;

      int lineResult = matchNumber(firstMatchString) * 10 + matchNumber(lastMatchString);
      lineResults.add(lineResult);
    }

    return lineResults.reduce((value, element) => value + element);
  }
}
