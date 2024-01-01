import 'dart:io';

import 'package:dart_numerics/dart_numerics.dart';

class Day8 {
  final File _input = File('./input/day8.txt');

  Future<List<String>> get _inputLines => _input.readAsLines();

  Future<DesertMap> parseMap() async {
    final List<String> inputLines = await _inputLines;
    final iterator = inputLines.iterator;
    iterator.moveNext();

    final String instructions = iterator.current;
    final regExp = RegExp('[A-Z]{3}');
    final Map<String, Node> map = {};


    iterator.moveNext();
    while (iterator.moveNext()) {
      String nodeLine = iterator.current;
      List<RegExpMatch> matches = regExp.allMatches(nodeLine).toList();
      String nodeName = matches[0].input.substring(matches[0].start, matches[0].end);
      String left = matches[1].input.substring(matches[1].start, matches[1].end);
      String right = matches[2].input.substring(matches[2].start, matches[2].end);
      map[nodeName] = Node(left: left, right: right);
    }

    return DesertMap(instructions: instructions, map: map);
  }

  Future<int> part1() async {
    final DesertMap map = await parseMap();
    return map.stepsCount(start: 'AAA', end: 'ZZZ');
  }

  Future<int> part2() async {
    final DesertMap map = await parseMap();
    return map.ghostStepsCount();
  }
}

class DesertMap {
  final String instructions;
  final Map<String, Node> map;

  int _currentStep = 0;

  DesertMap({required this.instructions, required this.map});

  int stepsCount({required String start, required String end}) {
    int steps = 0;
    String currentNode = start;
    do {
      currentNode = map[currentNode]!.next(currentStep);
      steps++;
    } while (currentNode != end);
    return steps;
  }

  int stepsCountPart2({required String start}) {
    int steps = 0;
    String currentNode = start;
    do {
      currentNode = map[currentNode]!.next(currentStep);
      steps++;
    } while (!currentNode.endsWith('Z'));
    return steps;
  }

  int ghostStepsCount() {
    List<String> startNodes = map.keys.where((element) => element.endsWith('A')).toList();
    List<int> stepsForNodes = startNodes.map((e) => stepsCountPart2(start: e)).toList();

    int steps = leastCommonMultipleOfMany(stepsForNodes);
    return steps;
  }

  String get currentStep {
    String currentStep = instructions[_currentStep];
    _currentStep = (_currentStep + 1) % instructions.length;
    return currentStep;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DesertMap && runtimeType == other.runtimeType && instructions == other.instructions && map == other.map;

  @override
  int get hashCode => instructions.hashCode ^ map.hashCode;
}

class Node {
  final String left;
  final String right;

  Node({required this.left, required this.right});

  String next(String step) {
    if (step == 'L') {
      return left;
    }
    return right;
  }

  @override
  String toString() {
    return 'Node{left: $left, right: $right}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Node && runtimeType == other.runtimeType && left == other.left;

  @override
  int get hashCode => left.hashCode;
}
