import 'dart:io';

class Day7 {
  /// A hand consists of five cards labeled one of A, K, Q, J, T, 9, 8, 7, 6, 5, 4, 3, or 2.
  /// The relative strength of each card follows this order, where A is the highest and 2 is the lowest.
  final File _input = File('./input/day7.txt');

  Future<List<String>> get _inputLines => _input.readAsLines();

  Future<int> part1() async {
    List<Hand> hands = await parseHands();
    hands.sort();

    int totalWinning = 0;
    for (int i = 0; i < hands.length; i++) {
      int rank = i + 1;
      totalWinning += hands[i].bid * rank;
    }
    return totalWinning;
  }

  Future<int> part2() async {
    List<Hand> hands = await parseHands(jokerRule: true);
    hands.sort();

    int totalWinning = 0;
    for (int i = 0; i < hands.length; i++) {
      int rank = i + 1;
      totalWinning += hands[i].bid * rank;
    }
    return totalWinning;
  }

  Future<List<Hand>> parseHands({bool jokerRule = false}) async {
    final List<String> inputLines = await _inputLines;

    List<Hand> hands = [];
    for (String line in inputLines) {
      List<String> splitLine = line.trim().split(RegExp('\\s+'));
      hands.add(Hand(
        hand: splitLine[0],
        bid: int.parse(splitLine[1]),
        jokerRule: jokerRule,
      ));
    }
    return hands;
  }
}

class Hand implements Comparable<Hand> {
  final String hand;
  final int bid;
  final bool jokerRule;

  Map<String, int> get strengthForCard => {
        if (jokerRule) 'J': 1,
        for (int i = 2; i <= 9; i++) '$i': i,
        'T': 10,
        if (!jokerRule) 'J': 11,
        'Q': 12,
        'K': 13,
        'A': 14,
      };

  Hand({required this.hand, required this.bid, this.jokerRule = false});

  Type get type => Type.fromHand(hand, jokerRule: jokerRule)!;

  @override
  int compareTo(Hand other) {
    int typesCompare = type.compareTo(other.type);
    if (typesCompare != 0) {
      return typesCompare;
    }

    for (int i = 0; i < hand.length; i++) {
      int cardCompare = strengthForCard[hand[i]]! - strengthForCard[other.hand[i]]!;
      if (cardCompare != 0) {
        return cardCompare;
      }
    }

    return 0;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Hand && runtimeType == other.runtimeType && hand == other.hand && bid == other.bid;

  @override
  int get hashCode => hand.hashCode ^ bid.hashCode;

  @override
  String toString() {
    return 'Hand{hand: $hand, bid: $bid, type: $type}';
  }
}

enum Type implements Comparable<Type> {
  kind5(6),
  kind4(5),
  fullHouse(4),
  kind3(3),
  pairTwo(2),
  pairOne(1),
  highCard(0);

  final int strength;

  const Type(this.strength);

  static Type? fromHand(String hand, {bool jokerRule = false}) {
    Map<String, int> cards = {};
    for (int i = 0; i < hand.length; i++) {
      cards[hand[i]] = (cards[hand[i]] ?? 0) + 1;
    }

    if (jokerRule) {
      int jokersCount = cards.remove('J') ?? 0;
      if (cards.keys.isEmpty) {
       // corner case
        cards['A'] = jokersCount;
      } else {
        List<String> keys = cards.keys.toList();
        String maxKey = keys.first;
        int maxVal = cards[maxKey] ?? 0;
        for (var key in keys) {
          if ((cards[key] ?? 0) > maxVal) {
            maxKey = key;
            maxVal = cards[key] ?? 0;
          }
        }

        cards[maxKey] = (cards[maxKey] ?? 0) + jokersCount;
      }
    }
    List<String> keys = cards.keys.toList();

    switch (cards.length) {
      case 1:
        return kind5;
      case 2:
        for (var key in keys) {
          if (jokerRule && key == 'J') continue;

          if (cards[key] == 4 || cards[key] == 1) {
            return Type.kind4;
          }
          if (cards[key] == 3 || cards[key] == 2) {
            return Type.fullHouse;
          }
        }
      case 3:
        for (var key in keys) {
          if (cards[key] == 3) {
            return Type.kind3;
          }

          if (cards[key] == 2) {
            return Type.pairTwo;
          }
        }
      case 4:
        return Type.pairOne;
      case 5:
      default:
        return Type.highCard;
    }
  }

  @override
  int compareTo(Type other) => strength - other.strength;
}
