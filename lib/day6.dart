import 'dart:io';

class Day6 {
  final File _input = File('./input/day6.txt');

  Future<List<String>> get _inputLines => _input.readAsLines();

  Future<int> part1() async {
    List<Race> games = await parseGames();
    return games.map(getWinHoldTimes).map((e) => e.length).reduce((value, element) => value * element);
  }

  Future<int> part2() async {
    Race race = await parseGame();
    return getWinHoldTimes(race).length;
  }

  Future<List<Race>> parseGames() async {
    final List<String> inputLines = await _inputLines;
    final timeStr = inputLines[0].replaceFirst('Time:', '').trim();
    final distanceStr = inputLines[1].replaceFirst('Distance:', '').trim();

    List<int> timeArr = timeStr.split(RegExp('\\s+')).map((e) => int.parse(e)).toList();
    List<int> distanceArr = distanceStr.split(RegExp('\\s+')).map((e) => int.parse(e)).toList();

    List<Race> games = [];
    for (int i = 0; i < timeArr.length; i++) {
      games.add((timeMs: timeArr[i], recordMm: distanceArr[i]));
    }
    return games;
  }

  Future<Race> parseGame() async {
    final List<String> inputLines = await _inputLines;
    final timeStr = inputLines[0].replaceFirst('Time:', '').replaceAll(RegExp('\\s+'), '');
    final distanceStr = inputLines[1].replaceFirst('Distance:', '').replaceAll(RegExp('\\s+'), '');

    return (timeMs: int.parse(timeStr), recordMm: int.parse(distanceStr));
  }
}

typedef Race = ({int timeMs, int recordMm});

List<int> getWinHoldTimes(Race race) {
  int velocityCharge = 1; // mm/ms

  List<int> holdTimes = [];
  for (int i = 0; i < race.timeMs; i++) {
    int holdTimeMs = i;
    int velocity = holdTimeMs * velocityCharge;
    int movingTimeMs = race.timeMs - holdTimeMs;
    int distanceMm = movingTimeMs * velocity;

    if (distanceMm > race.recordMm) {
      holdTimes.add(holdTimeMs);
    } else if (holdTimes.isNotEmpty) {
      break;
    }
  }

  return holdTimes;
}
