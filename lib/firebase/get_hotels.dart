import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class GetHotel extends ChangeNotifier {
  CollectionReference hotel = FirebaseFirestore.instance.collection('hotels');
  CollectionReference offer = FirebaseFirestore.instance.collection('Offer');
  String nameHotels = 'Москва';
  String getHotels = 'rate';
  bool maxtoMinRate = true;

  void setNameHotels(name){
    nameHotels = name;
    notifyListeners();
  }
  void changeRateMin() {
    getHotels = 'rate';
    maxtoMinRate = false;
    notifyListeners();
  }

  void changeRateMax() {
    getHotels = 'rate';
    maxtoMinRate = true;
    notifyListeners();
  }

  void changePriceMin() {
    getHotels = 'price';
    maxtoMinRate = true;
    notifyListeners();
  }

  void changePriceMax() {
    getHotels = 'price';
    maxtoMinRate = false;
    notifyListeners();
  }
}
