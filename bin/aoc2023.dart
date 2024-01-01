import 'package:aoc2023/day1.dart';
import 'package:aoc2023/day2.dart';
import 'package:aoc2023/day3.dart';
import 'package:aoc2023/day4.dart';
import 'package:aoc2023/day5.dart';
import 'package:aoc2023/day6.dart';
import 'package:aoc2023/day7.dart';
import 'package:aoc2023/day8.dart';

Future<void> main(List<String> arguments) async {
  print('Hello Advent of Code 2023 with Dart!');

  {
    var day = Day1();

    var startTime = DateTime.now();
    var part1 = await day.part1();
    var durationPart1 = DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;

    startTime = DateTime.now();
    var part2 = await day.part2();
    var durationPart2 = DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;

    print('Day 1 results:');
    print('- Part 1 ($durationPart1 ms): $part1');
    print('- Part 2 ($durationPart2 ms): $part2');
  }

  {
    var day = Day2();

    var startTime = DateTime.now();
    var part1 = await day.part1();
    var durationPart1 = DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;

    startTime = DateTime.now();
    var part2 = await day.part2();
    var durationPart2 = DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;

    print('Day 2 results:');
    print('- Part 1 ($durationPart1 ms): $part1');
    print('- Part 2 ($durationPart2 ms): $part2');
  }

  {
    var day = Day3();

    var startTime = DateTime.now();
    var part1 = await day.part1();
    var durationPart1 = DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;

    startTime = DateTime.now();
    var part2 = await day.part2();
    var durationPart2 = DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;

    print('Day 3 results:');
    print('- Part 1 ($durationPart1 ms): $part1');
    print('- Part 2 ($durationPart2 ms): $part2');
  }

  {
    var day = Day4();

    var startTime = DateTime.now();
    var part1 = await day.part1();
    var durationPart1 = DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;

    startTime = DateTime.now();
    var part2 = await day.part2();
    var durationPart2 = DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;

    print('Day 4 results:');
    print('- Part 1 ($durationPart1 ms): $part1');
    print('- Part 2 ($durationPart2 ms): $part2');
  }

  {
    var day = Day5();

    var startTime = DateTime.now();
    var part1 = await day.part1();
    var durationPart1 = DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;

    startTime = DateTime.now();
    // var part2 = await day.part2(); // slow running operation
    var durationPart2 = DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;

    print('Day 5 results:');
    print('- Part 1 ($durationPart1 ms): $part1');
    // print('- Part 2 ($durationPart2 ms): $part2');
  }

  {
    var day = Day6();

    var startTime = DateTime.now();
    var part1 = await day.part1();
    var durationPart1 = DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;

    startTime = DateTime.now();
    var part2 = await day.part2();
    var durationPart2 = DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;

    print('Day 6 results:');
    print('- Part 1 ($durationPart1 ms): $part1');
    print('- Part 2 ($durationPart2 ms): $part2');
  }

  {
    var day = Day7();

    var startTime = DateTime.now();
    var part1 = await day.part1();
    var durationPart1 = DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;

    startTime = DateTime.now();
    var part2 = await day.part2();
    var durationPart2 = DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;

    print('Day 7 results:');
    print('- Part 1 ($durationPart1 ms): $part1');
    print('- Part 2 ($durationPart2 ms): $part2');
  }

  {
    var day = Day8();

    var startTime = DateTime.now();
    var part1 = await day.part1();
    var durationPart1 = DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;

    startTime = DateTime.now();
    var part2 = await day.part2();
    var durationPart2 = DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;

    print('Day 8 results:');
    print('- Part 1 ($durationPart1 ms): $part1');
    print('- Part 2 ($durationPart2 ms): $part2');
  }
}
