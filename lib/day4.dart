import 'dart:io';
import 'dart:math';

class Day4 {
  /// It looks like each card has two lists of numbers separated by a vertical bar (|): a list of winning numbers
  /// and then a list of numbers you have. You organize the information into a table (your puzzle input).
  final File _input = File('./input/day4.txt');

  Future<List<String>> get _inputLines => _input.readAsLines();

  Future<List<Card>> parseCards() async {
    final List<String> inputLines = await _inputLines;
    return inputLines.map((e) => Card.fromString(e)).toList();
  }

  /// Figure out which of the numbers you have appear in the list of winning numbers. The first match makes
  /// the card worth one point and each match after the first doubles the point value of that card.
  Future<int> part1() async {
    List<Card> cards = await parseCards();
    int totalScore = cards.fold(0, (previousValue, element) => previousValue + element.computeScore());
    return totalScore;
  }

  /// Instead, scratchcards only cause you to win more scratchcards equal to the number of winning numbers you have.
  /// Process all of the original and copied scratchcards until no more scratchcards are won.
  /// Including the original set of scratchcards, how many total scratchcards do you end up with?
  Future<int> part2() async {
    List<Card> cards = await parseCards();

    for (int i = 0; i < cards.length; i++) {
      int cardCopies = cards[i].copies;
      int matchingNumbers = cards[i].matchingNumbers();
      if (matchingNumbers == 0) continue;

      int original = i + 1;
      for (int j = original + 1; j <= original + matchingNumbers; j++) {
        if (j - 1 >= cards.length) break;
        cards[j - 1].copies += 1 + cardCopies;
      }
    }

    int totalCard = cards.fold(0, (previousValue, element) => previousValue + element.totalCard());
    return totalCard;
  }
}

class Card {
  final String name;
  late final int cardNumber;
  final Set<int> winningNumbers;
  final Set<int> numbers;

  int copies = 0;

  Card({
    required this.name,
    required this.winningNumbers,
    required this.numbers,
  }) {
    cardNumber = int.parse(name.split(RegExp('\\s+')).last);
  }

  factory Card.fromString(String input) {
    List<String> nameNumbers = input.split(':');
    String name = nameNumbers.first.trim();

    List<String> numbers = nameNumbers.last.split('|');

    Set<int> extractNumbers(String numberInput) {
      List<String> numbersStr = numberInput.trim().split(RegExp('\\s+'));
      return numbersStr.map((e) => int.parse(e.trim())).toSet();
    }

    Set<int> winningNumbers = extractNumbers(numbers.first);
    Set<int> userNumbers = extractNumbers(numbers.last);

    return Card(
      name: name,
      winningNumbers: winningNumbers,
      numbers: userNumbers,
    );
  }

  int computeScore() {
    Set<int> matchingNumbers = numbers.intersection(winningNumbers);
    if (matchingNumbers.isEmpty) {
      return 0;
    }
    return pow(2, matchingNumbers.length - 1).toInt();
  }

  //region used in part2
  int matchingNumbers() => numbers.intersection(winningNumbers).length;

  int totalCard() => 1 + copies;
  //endregion
}
