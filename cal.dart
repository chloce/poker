import 'dart:math';

main() {
  List<Object> cards = [
    {'numb': 1, 'suit': 'heart'},
    {'numb': 1, 'suit': 'spade'},
    {'numb': 1, 'suit': 'dia'},
    {'numb': 1, 'suit': 'club'},
    {'numb': 2, 'suit': 'heart'},
    {'numb': 2, 'suit': 'spade'},
    {'numb': 2, 'suit': 'dia'},
    {'numb': 2, 'suit': 'club'},
    {'numb': 3, 'suit': 'heart'},
    {'numb': 3, 'suit': 'spade'},
    {'numb': 3, 'suit': 'dia'},
    {'numb': 3, 'suit': 'club'},
    {'numb': 4, 'suit': 'heart'},
    {'numb': 4, 'suit': 'spade'},
    {'numb': 4, 'suit': 'dia'},
    {'numb': 4, 'suit': 'club'},
    {'numb': 5, 'suit': 'heart'},
    {'numb': 5, 'suit': 'spade'},
    {'numb': 5, 'suit': 'dia'},
    {'numb': 5, 'suit': 'club'},
    {'numb': 6, 'suit': 'heart'},
    {'numb': 6, 'suit': 'spade'},
    {'numb': 6, 'suit': 'dia'},
    {'numb': 6, 'suit': 'club'},
    {'numb': 7, 'suit': 'heart'},
    {'numb': 7, 'suit': 'spade'},
    {'numb': 7, 'suit': 'dia'},
    {'numb': 7, 'suit': 'club'},
    {'numb': 8, 'suit': 'heart'},
    {'numb': 8, 'suit': 'spade'},
    {'numb': 8, 'suit': 'dia'},
    {'numb': 8, 'suit': 'club'},
    {'numb': 9, 'suit': 'heart'},
    {'numb': 9, 'suit': 'spade'},
    {'numb': 9, 'suit': 'dia'},
    {'numb': 9, 'suit': 'club'},
    {'numb': 10, 'suit': 'heart'},
    {'numb': 10, 'suit': 'spade'},
    {'numb': 10, 'suit': 'dia'},
    {'numb': 10, 'suit': 'club'},
    {'numb': 11, 'suit': 'heart'},
    {'numb': 11, 'suit': 'spade'},
    {'numb': 11, 'suit': 'dia'},
    {'numb': 11, 'suit': 'club'},
    {'numb': 12, 'suit': 'heart'},
    {'numb': 12, 'suit': 'spade'},
    {'numb': 12, 'suit': 'dia'},
    {'numb': 12, 'suit': 'club'},
    {'numb': 13, 'suit': 'heart'},
    {'numb': 13, 'suit': 'spade'},
    {'numb': 13, 'suit': 'dia'},
    {'numb': 13, 'suit': 'club'},
  ];

  Map randomCardList = randomNumbers(cards); //ランダムな手札と場を作る.
  List first;
  List pairCheckFirst = checkPair(randomCardList['first']);
  List straightCheckFirst = straightCheck(randomCardList['first']);
  List flashCheckFirst = flashCheck(randomCardList['first']);

  if (flashCheckFirst[0] == 5 && straightCheckFirst[0] == 4) {
    first = [8];
  } else if (pairCheckFirst[0] < flashCheckFirst[0]) {
    first = flashCheckFirst;
  } else if (pairCheckFirst[0] < straightCheckFirst[0]) {
    first = straightCheckFirst;
  } else {
    first = pairCheckFirst;
  }
  //straightCheck(randomCardList['first']);
  List second;
  List pairCheckSecond = checkPair(randomCardList['second']);
  List straightCheckSecond = straightCheck(randomCardList['second']);
  List flashCheckSecond = flashCheck(randomCardList['second']);
  if (flashCheckSecond[0] == 5 && straightCheckSecond[0] == 4) {
    second = [8];
  } else if (pairCheckSecond[0] < flashCheckSecond[0]) {
    second = flashCheckSecond;
  } else if (pairCheckSecond[0] < straightCheckSecond[0]) {
    second = straightCheckSecond;
  } else {
    second = pairCheckSecond;
  }
  print(first);
  print(second);

  checkWinner(first, second);
}

Map randomNumbers(cards) {
  Set randomSet = new Set();
  while (randomSet.length < 9) {
    randomSet.add(cards[new Random().nextInt(52)]);
  }
  List<Object> randomList = randomSet.toList();
  List firstPlayer = [
    randomList[0],
    randomList[1],
    randomList[4],
    randomList[5],
    randomList[6],
    randomList[7],
    randomList[8]
  ];
  List secondPlayer = [
    randomList[2],
    randomList[3],
    randomList[4],
    randomList[5],
    randomList[6],
    randomList[7],
    randomList[8]
  ];
  return {'first': firstPlayer, 'second': secondPlayer};
}

List checkPair(cards) {
  int numberOfSet = 0;
  List handAndField = [];
  List<int> setCards = [];
  for (int i = 0; i < 7; i++) {
    int oneCardnumb = cards[i]['numb'];
    handAndField.add(oneCardnumb);
    for (int j = i + 1; j < 7; j++) {
      int anotherCardnumb = cards[j]['numb'];
      if (oneCardnumb == anotherCardnumb) {
        numberOfSet++;
        setCards.add(cards[j]['numb']);
      }
    }
  }
  handAndField.sort();
  //return [numberOfSet, setCards];
  switch (numberOfSet) {
    case 0:
      print('high card');
      return [0, setCards, handAndField];
    case 1:
      print('one pair');
      return [1, setCards, handAndField];
      break;
    case 2:
      setCards.sort();
      print('two pair');
      return [2, setCards, handAndField];
    case 3:
      Set threePairCheck = new Set();
      for (int each in setCards) {
        threePairCheck.add(each);
      }
      if (threePairCheck.length == 3) {
        List threePairToTwoPair = threePairCheck.toList();
        threePairToTwoPair.sort();
        List twoPair =
            threePairToTwoPair.reversed.toList().sublist(0, 2).reversed;
        print('two pair');
        return [2, twoPair, handAndField];
      }
      print('three card');
      return [3, setCards, handAndField];

    case 4:
      print('full house');
      return [6, setCards, handAndField];
    case 6:
      print('four pair');
      return [7, setCards, handAndField];
    default:
      print('what wrong');
      return [-1, setCards, handAndField];
  }
}

List straightCheck(card) {
  List straight = [];
  int count = 0;

  Set cardsets = new Set();
  for (Map each in card) {
    cardsets.add(each['numb']);
  }
  List cardList = cardsets.toList();
  if (cardList.length > 4) {
    cardList.sort();
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

List flashCheck(card) {
  bool isFlash = false;
  List flash = [];
  List flashList = [];
  for (int i = 0; i < 3; i++) {
    int count = 0;
    String oneSuit = card[i]['suit'];
    flash.add(card[i]['numb']);
    for (int j = i + 1; j < card.length; j++) {
      String anotherSuit = card[j]['suit'];
      if (oneSuit == anotherSuit) {
        flash.add(card[j]['numb']);
        count++;
      }
    }
    if (count >= 5) {
      print('flash');
      isFlash = true;
      print(count);
      flash.reversed;
      flashList = flash.reversed.toList().sublist(0, 5).reversed.toList();
    }
  }
  if (!isFlash) {
    return [-1];
  } else {
    return [5, flashList];
  }
}

void checkWinner(List first, List second, [Map randomCardList]) {
  if (first[0] > second[0]) {
    print('first win ');
  } else if (first[0] < second[0]) {
    print('second win');
  } else {
    switch (first[0]) {
      case 0:
      case 1:
    }
  }
}
