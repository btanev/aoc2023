import 'dart:io';
import 'dart:math';

class Day2 {
  final File _input = File('./input/day2.txt');

  Future<List<String>> get _inputLines => _input.readAsLines();

  Future<List<Game>> loadGames() async {
    final List<String> inputLines = await _inputLines;
    List<Game> games = inputLines.map((e) => Game.fromLine(e)).toList();
    return games;
  }

  /// Determine which games would have been possible if the bag had been loaded with only
  /// 12 red cubes, 13 green cubes, and 14 blue cubes. What is the sum of the IDs of those games?
  Future<int> part1() async {
    final GameSet configuration = GameSet(red: 12, green: 13, blue: 14);
    final List<Game> allGames = await loadGames();

    List<Game> possibleGames = allGames.where((game) {
      return game.sets.every((element) {
        return element.red <= configuration.red &&
            element.green <= configuration.green &&
            element.blue <= configuration.blue;
      });

      // GameSet maxCubeColoursInSet = game.sets.reduce((value, element) => value + element);
      // return maxCubeColoursInSet.red <= configuration.red &&
      //     maxCubeColoursInSet.green <= configuration.green &&
      //     maxCubeColoursInSet.blue <= configuration.blue;
    }).toList();

    int gamesSum = possibleGames.fold(0, (previousValue, element) => previousValue + element.id);
    return gamesSum;
  }

  /// The power of a set of cubes is equal to the numbers of red, green, and blue cubes multiplied together.
  /// For each game, find the minimum set of cubes that must have been present. What is the sum of the power of
  /// these sets?
  Future<int> part2() async {
    final List<Game> allGames = await loadGames();
    List<GameSet> minGameCubesConfiguration = allGames.map((game) {
      return game.sets.reduce(
        (value, element) => GameSet(
          red: max(value.red, element.red),
          green: max(value.green, element.green),
          blue: max(value.blue, element.blue),
        ),
      );
    }).toList();

    int sum = minGameCubesConfiguration
        .map((e) => e.power())
        .reduce((value, element) => value + element);
    return sum;
  }
}

class GameSet {
  final int red;
  final int green;
  final int blue;

  GameSet({
    required this.red,
    required this.green,
    required this.blue,
  });

  factory GameSet.fromLine(String setInput) {
    Map<String, int> gameSet = {};

    Iterable<String> cubesCount = setInput.split(',').map((e) => e.trim());
    for (String cubes in cubesCount) {
      List<String> countColor = cubes.split(' ');
      gameSet[countColor[1].toLowerCase()] = int.parse(countColor[0]);
    }

    return GameSet.fromMap(gameSet);
  }

  static GameSet fromMap(Map<String, int> gameSet) {
    return GameSet(
      red: gameSet['red'] ?? 0,
      green: gameSet['green'] ?? 0,
      blue: gameSet['blue'] ?? 0,
    );
  }

  int power() => red * green * blue;

  GameSet operator +(GameSet other) {
    return GameSet(
      red: red + other.red,
      green: green + other.green,
      blue: blue + other.blue,
    );
  }

  @override
  String toString() => 'GameSet{red: $red, green: $green, blue: $blue}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameSet &&
          runtimeType == other.runtimeType &&
          red == other.red &&
          green == other.green &&
          blue == other.blue;

  @override
  int get hashCode => red.hashCode ^ green.hashCode ^ blue.hashCode;
}

class Game {
  final int id;
  final List<GameSet> sets;

  Game({
    required this.id,
    required this.sets,
  });

  factory Game.fromLine(String gameInput) {
    int gameId = -1;
    List<GameSet> sets = [];

    List<String> gameAndSets = gameInput.split(':').map((e) => e.trim()).toList();
    String gameString = gameAndSets[0];
    String setsString = gameAndSets[1];

    gameId = int.parse(gameString.replaceAll('Game', '').trim());

    List<String> setsArray = setsString.split(';').map((e) => e.trim()).toList();
    sets.addAll(setsArray.map((e) => GameSet.fromLine(e)));

    return Game(id: gameId, sets: sets);
  }

  @override
  String toString() => 'Game{id: $id}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Game && runtimeType == other.runtimeType && id == other.id && sets == other.sets;

  @override
  int get hashCode => id.hashCode ^ sets.hashCode;
}
