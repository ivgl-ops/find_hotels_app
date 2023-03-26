import 'package:flutter/material.dart';

class FlexibleData extends ChangeNotifier {
  dynamic list;

  void setList(dynamic dataList) {
    list = dataList;
    notifyListeners();
  }
}
