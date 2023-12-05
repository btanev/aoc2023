import 'package:aoc2023/day1.dart';
import 'package:aoc2023/day2.dart';
import 'package:aoc2023/day3.dart';
import 'package:aoc2023/day4.dart';
import 'package:aoc2023/day5.dart';

Future<void> main(List<String> arguments) async {
  print('Hello Advent of Code 2023 with Dart!');

  {
    var day = Day1();
    var part1 = await day.part1();
    var part2 = await day.part2();

    print('Day 1 results:');
    print('- Part 1: $part1');
    print('- Part 2: $part2');
  }

  {
    var day = Day2();
    var part1 = await day.part1();
    var part2 = await day.part2();

    print('Day 2 results:');
    print('- Part 1: $part1');
    print('- Part 2: $part2');
  }

  {
    var day = Day3();
    var part1 = await day.part1();
    var part2 = await day.part2();

    print('Day 3 results:');
    print('- Part 1: $part1');
    print('- Part 2: $part2');
  }

  {
    var day = Day4();
    var part1 = await day.part1();
    var part2 = await day.part2();

    print('Day 4 results:');
    print('- Part 1: $part1');
    print('- Part 2: $part2');
  }

  {
    var day = Day5();
    var part1 = await day.part1();
    // var part2 = await day.part2(); // slow running computations

    print('Day 5 results:');
    print('- Part 1: $part1');
    // print('- Part 2: $part2');
  }
}
