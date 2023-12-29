import 'dart:io';
import 'dart:isolate';
import 'dart:math';

class Day5 {
  final File _input = File('./input/day5.txt');

  Future<List<String>> get _inputLines => _input.readAsLines();

  Future<Almanac> parseMap() async {
    final List<String> inputLines = await _inputLines;
    String seedsInput = inputLines[0];

    List<int> seed = seedsInput.split(':').last.trim().split(RegExp('\\s+')).map((e) => int.parse(e)).toList();

    Map<Type, TypeMap> maps = {};
    Type? currSource;
    Type? currDestination;
    TypeMap? currMap;
    for (int i = 1; i < inputLines.length; i++) {
      String currLine = inputLines[i];
      if (currLine.isEmpty) {
        if (currSource != null && currMap != null) {
          maps[currSource] = currMap;
        }
        currSource = null;
        currDestination = null;
        currMap = null;

        continue;
      }

      if (currLine.endsWith(' map:')) {
        String sourceToDestinationString = currLine.substring(0, currLine.length - ' map:'.length).trim();
        List<Type?> sourceToDestination = sourceToDestinationString.split('-to-').map((e) => Type.fromCode(e)).toList();

        currSource = sourceToDestination.first;
        currDestination = sourceToDestination.last;
        currMap = TypeMap(destination: currDestination!, source: currSource!);

        continue;
      }

      if (currMap != null) {
        currMap.addTypeRange(TypeRange.fromString(currLine));
      }
    }
    if (currSource != null && currMap != null) {
      maps[currSource] = currMap;
    }

    return Almanac(seeds: seed, maps: maps);
  }

  Future<int> part1() async {
    Almanac almanac = await parseMap();

    List<int> locations = almanac.seeds.map((e) => almanac.typeFromSeed(Type.location, e)).toList()..sort();
    return locations[0];
  }

  Future<int> part2() async {
    Almanac almanac = await parseMap();
    List<int> seedStartAndRange = almanac.seeds;

    // /ideas how to improve the algorithm
    // - start traversing from locations to seeds, locations sets is much less than seeds
    // - add a 1st / 2nd level caching of results

    DateTime start = DateTime.timestamp();

    List<Future<int>> runners = [];
    for (int i = 0; i < seedStartAndRange.length; i += 2) {
      Future<int> runner = Isolate.run(() {
        int result = -1 >>> 1;

        int start = seedStartAndRange[i];
        int range = seedStartAndRange[i + 1];

        for (int j = 0; j < range; j++) {
          int destination = almanac.typeFromSeed(Type.location, start + j);
          result = min(destination, result);
        }

        return result;
      });

      runners.add(runner);
    }

    List<int> results = await Future.wait(runners);
    int result = results.reduce((value, element) => value > element ? element : value);

    print('${start.difference(DateTime.timestamp()).inSeconds} s');
    return result;
  }
}

class Almanac {
  final List<int> seeds;
  final Map<Type, TypeMap> maps;

  Almanac({required this.seeds, required this.maps});

  int typeFromSeed(Type resultType, int seedSource) {
    int currDestination = seedSource;
    Type sourceType = Type.seed;

    while (sourceType != resultType) {
      TypeMap currMap = maps[sourceType]!;
      currDestination = currMap.destinationForSource(currDestination);
      // print('${currMap.source}-to-${currMap.destination} = $currDestination');
      sourceType = currMap.destination;
    }

    return currDestination;
  }
}

enum Type {
  seed,
  soil,
  fertilizer,
  water,
  light,
  temperature,
  humidity,
  location;

  static Type? fromCode(String code) {
    for (final type in Type.values) {
      if (type.name.toLowerCase() == code.toLowerCase()) {
        return type;
      }
    }
    return null;
  }
}

class TypeMap {
  final Type destination;
  final Type source;

  List<TypeRange> _ranges = [];

  TypeMap({
    required this.destination,
    required this.source,
  });

  void addTypeRange(TypeRange range) => _ranges.add(range);

  int destinationForSource(int sourceInput) {
    for (var range in _ranges) {
      if (range.isSourceInRange(sourceInput)) {
        return range.destinationForSource(sourceInput);
      }
    }

    // Any source numbers that aren't mapped correspond to the same destination number
    return sourceInput;
  }
}

class TypeRange {
  final int destinationStart;
  final int sourceStart;
  final int rangeLength;

  TypeRange({
    required this.destinationStart,
    required this.sourceStart,
    required this.rangeLength,
  });

  factory TypeRange.fromString(String input) {
    // the destination range start, the source range start, and the range length.
    List<int> rangesInput = input.trim().split(RegExp('\\s+')).map((e) => int.parse(e)).toList();
    return TypeRange(
      destinationStart: rangesInput[0],
      sourceStart: rangesInput[1],
      rangeLength: rangesInput[2],
    );
  }

  bool isSourceInRange(int sourceInput) => (sourceStart <= sourceInput) && (sourceInput < sourceStart + rangeLength);

  int destinationForSource(int sourceInput) {
    if (isSourceInRange(sourceInput)) {
      int delta = sourceInput - sourceStart;
      return destinationStart + delta;
    }
    // Any source numbers that aren't mapped correspond to the same destination number
    return sourceInput;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeRange &&
          runtimeType == other.runtimeType &&
          destinationStart == other.destinationStart &&
          sourceStart == other.sourceStart &&
          rangeLength == other.rangeLength;

  @override
  int get hashCode => destinationStart.hashCode ^ sourceStart.hashCode ^ rangeLength.hashCode;

  @override
  String toString() {
    return 'TypeRange{destinationStart: $destinationStart, sourceStart: $sourceStart, rangeLength: $rangeLength}';
  }
}
