import 'dart:math';
import 'dart:collection';

main() {
  List<Object> cards = [
    [1, 'heart'],
    [1, 'spade'],
    [1, 'dia'],
    [1, 'club'],
    [2, 'heart'],
    [2, 'spade'],
    [2, 'dia'],
    [2, 'club'],
    [3, 'heart'],
    [3, 'spade'],
    [3, 'dia'],
    [3, 'club'],
    [4, 'heart'],
    [4, 'spade'],
    [4, 'dia'],
    [4, 'club'],
    [5, 'heart'],
    [5, 'spade'],
    [5, 'dia'],
    [5, 'club'],
    [6, 'heart'],
    [6, 'spade'],
    [6, 'dia'],
    [6, 'club'],
    [7, 'heart'],
    [7, 'spade'],
    [7, 'dia'],
    [7, 'club'],
    [8, 'heart'],
    [8, 'spade'],
    [8, 'dia'],
    [8, 'club'],
    [9, 'heart'],
    [9, 'spade'],
    [9, 'dia'],
    [9, 'club'],
    [10, 'heart'],
    [10, 'spade'],
    [10, 'dia'],
    [10, 'club'],
    [11, 'heart'],
    [11, 'spade'],
    [11, 'dia'],
    [11, 'club'],
    [12, 'heart'],
    [12, 'spade'],
    [12, 'dia'],
    [12, 'club'],
    [13, 'heart'],
    [13, 'spade'],
    [13, 'dia'],
    [13, 'club'],
  ];
  Map<String, int> wincounter = {};
  Map<String, int> losecounter = {};
  for (int i = 0; i < 1000000000; i++) {
    Map randomCardList = randomNumbers(cards); //ランダムな手札と場を作る
    List firstHand = randomCardList['firstHand'];
    List firstFinal;
    List pairFirst = checkPair(randomCardList['firstPlayerNumbers']);
    List straightFirst = straightCheck(randomCardList['firstPlayerNumbers']);
    List flashFirst = flashCheck(randomCardList['first']);

    if (straightFirst != -1 && straightFirst == flashFirst) {
      firstFinal = [8, straightFirst].toList();
    } else if (pairFirst[0] < flashFirst[0]) {
      firstFinal = flashFirst.toList();
    } else if (pairFirst[0] < straightFirst[0]) {
      firstFinal = straightFirst.toList();
    } else {
      firstFinal = pairFirst.toList();
    }
    //straightCheck(randomCardList['first']);
    List secondHand = randomCardList['secondHand'];
    List secondFinal;
    List pairSecond = checkPair(randomCardList['secondPlayerNumbers']);
    List straightSecond = straightCheck(randomCardList['secondPlayerNumbers']);

    List flashSecond = flashCheck(randomCardList['second']);
    if (straightSecond != -1 && straightSecond == flashSecond) {
      secondFinal = [8, straightSecond].toList();
    } else if (pairSecond[0] < flashSecond[0]) {
      secondFinal = flashSecond.toList();
    } else if (pairSecond[0] < straightSecond[0]) {
      secondFinal = straightSecond.toList();
    } else {
      secondFinal = pairSecond.toList();
    }
    checkWinner(firstFinal, secondFinal, firstHand, secondHand, wincounter,
        losecounter);
  }
  Map percentage = <String, double>{};
  for (String key in wincounter.keys) {
    int total = wincounter[key] + losecounter[key];
    double percent = (wincounter[key] / total * 100).floorToDouble();
    percentage.addAll({key: '$percent %'});
  }

  var sortedKeys = percentage.keys.toList(growable: false)
    ..sort((k1, k2) => percentage[k1].compareTo(percentage[k2]));
  LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
      key: (k) => k, value: (k) => percentage[k]);
  var sortedWins = percentage.keys.toList(growable: false)
    ..sort((k1, k2) => percentage[k1].compareTo(percentage[k2]));
  LinkedHashMap sortedwinMap = new LinkedHashMap.fromIterable(sortedWins,
      key: (k) => k, value: (k) => percentage[k]);

  print(sortedMap);
  print('--------------------------');
  print(sortedwinMap);
}

Map randomNumbers(cards) {
  Set randomSet = new Set();
  while (randomSet.length < 9) {
    randomSet.add(cards[new Random().nextInt(52)]);
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
  List firstHand = [randomList[0][0], randomList[1][0]];
  firstHand.sort();
  firstHand.add(handSuit(randomList[0][1], randomList[1][1]));

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
  List secondHand = [randomList[2][0], randomList[3][0]];
  secondHand.sort();
  secondHand.add(handSuit(randomList[2][1], randomList[3][1]));

  return {
    'first': firstPlayer,
    'second': secondPlayer,
    'firstPlayerNumbers': firstPlayerNumbers,
    'secondPlayerNumbers': secondPlayerNumbers,
    'firstHand': [firstHand],
    'secondHand': [secondHand]
  };
}

String handSuit(suitA, suitB) {
  if (suitA == suitB) {
    return 'o';
  } else {
    return 's';
  }
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
  if (numbers.length >= 1) {
    if (numbers[numbers.length - 1] == 1) {
      numbers.remove(1);
      numbers = numbers.reversed.toList();
      numbers.add(1);
      numbers = numbers.reversed.toList();
    }
  }

  switch (pairs.length) {
    case 0:
      return [0, numbers.sublist(0, 5).toList()];
    case 1:
      switch (pairs[0][1]) {
        case 2:
          return [
            1,
            [pairs[0][0], pairs[0][0], numbers[0], numbers[1], numbers[2]]
          ];
        case 3:
          return [
            3,
            [pairs[0][0], pairs[0][0], pairs[0][0], numbers[0], numbers[1]]
          ];
        case 4:
          return [
            7,
            [pairs[0][0], pairs[0][0], pairs[0][0], pairs[0][0], numbers[0]]
          ];
      }

      return [-1, '1 pair'];

    case 2:
      if (pairs[0][1] == 2 && pairs[1][1] == 2) {
        return [
          2,
          [pairs[0][0], pairs[0][0], pairs[1][0], pairs[1][0], numbers[0]]
        ];
      } else if (pairs[0][1] == 4) {
        numbers.add(pairs[1][0]);
        numbers.sort();
        numbers = numbers.reversed.toList();
        return [
          7,
          [pairs[0][0], pairs[0][0], pairs[0][0], pairs[0][0], numbers[0]]
        ];
      } else if (pairs[1][1] == 4) {
        numbers.add(pairs[0][0]);
        numbers.sort();
        numbers = numbers.reversed.toList();
        return [
          7,
          [pairs[1][0], pairs[1][0], pairs[1][0], pairs[1][0], numbers[0]]
        ];
      } else if (pairs[0][1] == 3) {
        return [
          6,
          [pairs[0][0], pairs[0][0], pairs[0][0], pairs[1][0], pairs[1][0]]
        ];
      } else if (pairs[1][1] == 3) {
        return [
          6,
          [pairs[1][0], pairs[1][0], pairs[1][0], pairs[0][0], pairs[0][0]]
        ];
      }

      return [-1, '2 pairs'];
    case 3:
      if (pairs[0][1] == 2 && pairs[1][1] == 2 && pairs[2][1] == 2) {
        numbers.add(pairs[2][0]);
        numbers.sort();
        numbers = numbers.reversed.toList();
        return [
          2,
          [pairs[0][0], pairs[0][0], pairs[1][0], pairs[1][0], numbers[0]]
        ];
      } else if (pairs[0][1] == 3) {
        return [
          6,
          [pairs[0][0], pairs[0][0], pairs[0][0], pairs[1][0], pairs[1][0]]
        ];
      } else if (pairs[1][1] == 3) {
        return [
          6,
          [pairs[1][0], pairs[1][0], pairs[1][0], pairs[0][0], pairs[0][0]]
        ];
      } else if (pairs[2][1] == 3) {
        return [
          6,
          [pairs[2][0], pairs[2][0], pairs[2][0], pairs[0][0], pairs[0][0]]
        ];
      }

      return [-1, '3 pairs'];
    default:
      return [-1, 'default'];
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
    return [-1, 'straight'];
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
    return [-1, 'flash'];
  } else {
    return [5, flashList];
  }
}

void checkWinner(List first, List second, List firstHand, List secondHand,
    Map wincounter, Map losecounter) {
  if (first[0] > second[0]) {
    countWinRate(firstHand, secondHand, wincounter, losecounter);
  } else if (first[0] < second[0]) {
    countWinRate(secondHand, firstHand, wincounter, losecounter);
  } else {
    int i = 0;
    while (true) {
      if (i == 5) {
        countWinRate(['split'], ['split'], wincounter, losecounter);
        break;
      }
      if (first[1][i] == 1 && second[1][i] == 1) {
        i++;
      } else if (first[1][i] == 1 && second[1][i] != 1) {
        countWinRate(firstHand, secondHand, wincounter, losecounter);
        break;
      } else if (first[1][i] != 1 && second[1][i] == 1) {
        countWinRate(secondHand, firstHand, wincounter, losecounter);
        break;
      } else if (first[1][i] > second[1][i]) {
        countWinRate(firstHand, secondHand, wincounter, losecounter);
        break;
      } else if (first[1][i] < second[1][i]) {
        countWinRate(secondHand, firstHand, wincounter, losecounter);
        break;
      } else {
        i++;
      }
    }
  }
}

countWinRate(winhand, losehand, wincounter, losecounter) {
  Map winCounter = wincounter;
  Map loseCounter = losecounter;
  String win = winhand.toString();
  String lose = losehand.toString();
  if (winCounter.containsKey(win)) {
    winCounter[win]++;
  } else {
    winCounter.addAll({win: 1});
  }
  if (loseCounter.containsKey(lose)) {
    loseCounter[lose]++;
  } else {
    loseCounter.addAll({lose: 1});
  }
}
