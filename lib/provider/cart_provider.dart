import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/storage_service.dart';

class Cart with ChangeNotifier {
  List _cartList = [];

  List get getCartList => _cartList;

  Cart() {
    init();
  }

  ///初始化时获取购物车数据
  init() async {
    try {
      List cartListData = json.decode(await Storage.getString("cartList"));
      _cartList = cartListData;
    } catch (e) {
      _cartList = [];
    }

    notifyListeners();
  }

  updateCartList() {
    init();
  }
}
