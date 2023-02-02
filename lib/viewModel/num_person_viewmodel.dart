import 'package:flutter/cupertino.dart';

// This class describes the logic of choosing the number of seats in the hotel
class NumPersonViewModel extends ChangeNotifier {
  int counterAdults = 1;
  int counterChildren = 0;
  int counterHotelRoom = 1;
  int total = 1;

  void incrementCounterAdults() {
    if (counterAdults >= 15) {
      counterAdults = 15;
    } else {
      counterAdults++;
    }
    notifyListeners();
  }

  void decrementCounterAdults() {
    if (counterAdults <= 1) {
      counterAdults = 1;
    } else {
      counterAdults--;
    }
    notifyListeners();
  }

  void incrementCounterChildren() {
    if (counterChildren >= 15) {
      counterChildren = 15;
    } else {
      counterChildren++;
    }
    notifyListeners();
  }

  void decrementCounterChildren() {
    if (counterChildren <= 0) {
      counterChildren = 0;
    } else {
      counterChildren--;
    }
    notifyListeners();
  }

  void incrementCounterHotelRoom() {
    if (counterHotelRoom >= 15) {
      counterHotelRoom = 15;
    } else {
      counterHotelRoom++;
    }
    notifyListeners();
  }

  void decrementCounterHotelRoom() {
    if (counterHotelRoom <= 1) {
      counterHotelRoom = 1;
    } else {
      counterHotelRoom--;
    }
    notifyListeners();
  }

  void totalPeople() {
    total = counterAdults + counterChildren;

    notifyListeners();
  }
}
