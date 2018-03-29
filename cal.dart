import 'dart:math';

main() {
  List suits = ['heart', 'spade', 'dia', 'club'];

  Map randomCardList = randomNumbers(suits); //ランダムな手札と場を作る
  List firstHand = randomCardList['firstHand'];
  List firstFinal;
  List pairFirst = checkPair(randomCardList['firstPlayerNumbers']);
  List straightFirst = straightCheck(randomCardList['firstPlayerNumbers']);
  List flashFirst = flashCheck(randomCardList['first']);

  if (straightFirst != -1 && straightFirst == flashFirst) {
    firstFinal = [8, straightFirst];
  } else if (pairFirst[0] < flashFirst[0]) {
    firstFinal = flashFirst;
  } else if (pairFirst[0] < straightFirst[0]) {
    firstFinal = straightFirst;
  } else {
    firstFinal = pairFirst;
  }
  //straightCheck(randomCardList['first']);
  List secondHand = randomCardList['secondHand'];
  List secondFinal;
  List pairSecond = checkPair(randomCardList['secondPlayerNumbers']);
  List straightSecond = straightCheck(randomCardList['secondPlayerNumbers']);

  List flashSecond = flashCheck(randomCardList['second']);
  if (straightSecond != -1 && straightSecond == flashSecond) {
    secondFinal = [8, straightSecond];
  } else if (pairSecond[0] < flashSecond[0]) {
    secondFinal = flashSecond;
  } else if (pairSecond[0] < straightSecond[0]) {
    secondFinal = straightSecond;
  } else {
    secondFinal = pairSecond;
  }
  checkWinner(firstFinal, secondFinal, firstHand, secondHand);
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
    'secondPlayerNumbers': secondPlayerNumbers,
    'firstHand': [randomList[0], randomList[1]],
    'secondHand': [randomList[2], randomList[3]]
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

List straightCheck(numbers) {
  List straight = [];
  int count = 0;

  Set cardset = new Set();
  for (Map each in numbers) {
    cardset.add(each);
  }
  List cardList = cardset.toList();
  if (cardList[0] == 1) {
    cardList.removeAt(0);
    cardList.add(1);
  }
  if (cardList.length > 4) {
    int formerCard = cardList[0];

    for (int i = 1; i < cardList.length; i++) {
      if (formerCard + 1 == cardList[i]) {
        count++;
        straight.add(cardList[i]);
      } else {
        count = 0;
        straight = [];
      }
      formerCard = cardList[i];
    }
    if (count >= 4 && cardList[cardList.length - 1] == 13 && cardList[0] == 1) {
      count++;
      straight.add(1);
    }
  }
  if (count >= 5) {
    List straightList =
        straight.reversed.toList().sublist(0, 5).reversed.toList();
    return [4, straightList];
  } else {
    return [-1];
  }
}

List flashCheck(cards) {
  List card = cards;
  if (card[0][0] == 1) {
    List aceCard = card[0];
    card.removeAt(0);
    card.add(aceCard);
  }
  bool isFlash = false;

  List flash = [];
  List flashList = [];
  for (int i = 0; i < 3; i++) {
    int count = 0;
    String oneSuit = card[i][1];
    flash.add(card[i][0]);
    for (int j = i + 1; j < card.length; j++) {
      String anotherSuit = card[j][1];
      if (oneSuit == anotherSuit) {
        flash.add(card[j][0]);
        count++;
      }
    }
    if (count == 5) {
      isFlash = true;
      flashList = flash.reversed.toList().reversed.toList();
    }
  }
  if (!isFlash) {
    return [-1];
  } else {
    return [5, flashList];
  }
}

void checkWinner(List first, List second, List firstHand, List secondHand) {
  if (first[0] > second[0]) {
    print('first win $first $firstHand');
  } else if (first[0] < second[0]) {
    print('second win $second $secondHand');
  } else {
    switch (first[0]) {
      case 0:
      case 1:
    }
  }
}
