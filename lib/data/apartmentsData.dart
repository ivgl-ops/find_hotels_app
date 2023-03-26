import 'package:flutter/material.dart';

class ApartmentDataView extends ChangeNotifier {
  final dynamic searchResult;
  final String id;
  final int price;
  final String people;
  final Duration days;
  dynamic list;
  
  void setList(dynamic dataList){
    list = dataList;
  }
  ApartmentDataView(
       this.searchResult,this.id, this.price, this.people, this.days);
}
