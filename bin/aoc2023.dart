import 'package:aoc2023/day1.dart';
import 'package:aoc2023/day2.dart';
import 'package:aoc2023/day3.dart';

Future<void> main(List<String> arguments) async {
  print('Hello Advent of Code 2023 with Dart!');

  {
    var day = Day1();
    int part1Result = await day.part1();
    int part2Result = await day.part2();

    print('Day 1 results:');
    print('- Part 1: $part1Result');
    print('- Part 2: $part2Result');
  }

  {
    var day = Day2();
    int part1Result = await day.part1();
    int part2Result = await day.part2();

    print('Day 2 results:');
    print('- Part 1: $part1Result');
    print('- Part 2: $part2Result');
  }

  {
    var day = Day3();
    int part1Result = await day.part1();
    int part2Result = await day.part2();

    print('Day 3 results:');
    print('- Part 1: $part1Result');
    print('- Part 2: $part2Result');
  }
}
