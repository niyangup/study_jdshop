import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  add() {
    _count = _count + 1;
    notifyListeners();
  }
}
