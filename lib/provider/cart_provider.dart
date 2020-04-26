import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List _cartList = [];
  int cartNum = 0;

  List get getCartList => _cartList;

  int get getCartNum => _cartList.length;

  addList(value) {
    _cartList.add(value);
    notifyListeners();
  }
}
