import 'package:flutter/cupertino.dart';

class LockDepartment extends ChangeNotifier {
  dynamic list;

  void setList(dynamic dataList) {
    list = dataList;
    notifyListeners();
  }
}