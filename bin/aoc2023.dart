
import 'package:aoc2023/day1.dart';

Future<void> main(List<String> arguments) async {
  print('Hello Advent of Code 2023!');

  Day1 day1 = Day1();
  int day1Part1Result = await day1.part1Result();
  int day1Part2Result = await day1.part2Result();

  print('Day1 results:');
  print('- Part 1: $day1Part1Result');
  print('- Part 2: $day1Part2Result');
}
