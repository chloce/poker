import "dart:collection";

main() {
  Map a = {'b': 2, 'a': 1, 'c': 3};
  print(a['b']);
} // b
/*import 'dart:math';

main() {
  List suits = ['heart', 'spade', 'dia', 'club'];

  Map randomCardList = randomNumbers(suits); //ランダムな手札と場を作る.
  List pairCheckFirst = checkPair(randomCardList['firstPlayerNumbers']);
  print(pairCheckFirst);
  //straightCheck(randomCardList['first']);
  //List pairCheckSecond = checkPair(randomCardList['second']);
}

Map randomNumbers(suits) {
  Set randomSet = new Set();
  while (randomSet.length < 9) {
    randomSet
        .add([new Random().nextInt(13) + 1, suits[new Random().nextInt(4)]]);
  }

  List<List> randomList = randomSet.toList();
  List firstPlayer = [
    randomList[0],
    randomList[1],
    randomList[4],
    randomList[5],
    randomList[6],
    randomList[7],
    randomList[8]
  ];

  List firstPlayerNumbers = [
    randomList[0][0],
    randomList[1][0],
    randomList[4][0],
    randomList[5][0],
    randomList[6][0],
    randomList[7][0],
    randomList[8][0]
  ];
  firstPlayerNumbers.sort();

  List secondPlayer = [
    randomList[2],
    randomList[3],
    randomList[4],
    randomList[5],
    randomList[6],
    randomList[7],
    randomList[8]
  ];
  List secondPlayerNumbers = [
    randomList[2][0],
    randomList[3][0],
    randomList[4][0],
    randomList[5][0],
    randomList[6][0],
    randomList[7][0],
    randomList[8][0]
  ];
  secondPlayerNumbers.sort();

  return {
    'first': firstPlayer,
    'second': secondPlayer,
    'firstPlayerNumbers': firstPlayerNumbers,
    'secondPlayerNumbers': secondPlayerNumbers
  };
}

List checkPair(cardNumbers) {
  List pairs = [];
  List numbers = cardNumbers;
  if (numbers[0] == 1) {
    int last = numbers.lastIndexOf(1);
    if (last >= 1) {
      pairs.add([1, last + 1]);
      numbers.removeRange(0, last + 1);
    }
  }
  numbers = numbers.reversed.toList();
  for (int i = 0; i < numbers.length; i++) {
    int first = numbers.indexOf(numbers[i]);
    int last = numbers.lastIndexOf(numbers[i]);
    if (first != last) {
      pairs.add([numbers[i], last - first + 1]);
      numbers.removeRange(i, last + 1);
      i--;
    }
  }
  if (numbers[numbers.length - 1] == 1) {
    numbers.remove(1);
    numbers = numbers.reversed.toList();
    numbers.add(1);
    numbers = numbers.reversed.toList();
  }
  switch (pairs.length) {
    case 0:
      return [0, numbers.sublist(0, 5).toList()];
    case 1:
      switch (pairs[0][1]) {
        case 2:
          return [1, pairs[0], numbers.sublist(0, 3).toList()];
        case 3:
          return [3, pairs[0], numbers.sublist(0, 2).toList()];
        case 4:
          return [7, pairs[0], numbers[0]];
      }
      return [-1];

    case 2:
      if (pairs[0][1] == 2 && pairs[1][1] == 2) {
        return [2, pairs, numbers[0]];
      } else if (pairs[0][1] == 4) {
        numbers.add(pairs[1][0]);
        numbers.sort();
        numbers = numbers.reversed.toList();
        return [7, pairs[0], numbers[0]];
      } else if (pairs[1][1] == 4) {
        numbers.add(pairs[0][0]);
        numbers.sort();
        numbers = numbers.reversed.toList();
        return [7, pairs[1], numbers[0]];
      } else if (pairs[0][1] == 3) {
        return [6, pairs];
      } else if (pairs[1][1] == 3) {
        return [6, pairs.reversed.toList()];
      }
      return [-1];
    case 3:
      if (pairs[0][1] == 2 && pairs[1][1] == 2 && pairs[2][1] == 2) {
        numbers.add(pairs[2][0]);
        numbers.sort();
        numbers = numbers.reversed.toList();
        return [
          2,
          [pairs[0], pairs[1]],
          numbers[0]
        ];
      } else if (pairs[0][1] == 3) {
        return [
          6,
          [pairs[0], pairs[1]]
        ];
      } else if (pairs[1][1] == 3) {
        return [
          6,
          [pairs[1], pairs[0]]
        ];
      } else if (pairs[2][1] == 3) {
        return [
          6,
          [pairs[2], pairs[0]]
        ];
      }
      return [-1];
    default:
      return [-1];
  }
}
*/
