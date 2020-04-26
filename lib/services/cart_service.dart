import 'dart:convert';

import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/services/storage_service.dart';

///购物车工具类
class CartService {
  static addCart(item) async {
    item = formatCartData(item);

    /**
     * 购物车数据存储
     * 先从本地中尝试过去是否存在
     *      若不存在,直接添加数据
     *      若存在,检查数据中是否有当前id的数据
     *        若不存在,添加当前id数据
     *        若存在,将该id数据的count加1
     *
     */
    try {
      List cartListData = json.decode(await Storage.getString("cartList"));

      bool hasData = cartListData.any((vaule) {
        if (vaule["id"] == item["id"] &&
            vaule["selectedAttr"] == item["selectedAttr"]) {
          return true;
        } else {
          return false;
        }
      });

      if (hasData) {
        cartListData.forEach((v) {
          if (v["id"] == item["id"] &&
              v["selectedAttr"] == item["selectedAttr"]) {
            v["count"]++;
          }
        });
        await Storage.setString('cartList', json.encode(cartListData));
      } else {
        cartListData.add(item);
        await Storage.setString('cartList', json.encode(cartListData));
      }
    } catch (e) {
      List tempList = [];
      tempList.add(item);
      await Storage.setString('cartList', json.encode(tempList));
    }
  }

  static formatCartData(item) {
    //处理图片
    String pic = item.pic;
    pic = Config.domain + pic.replaceAll('\\', '/');

    final Map data = new Map<String, dynamic>();
    data['_id'] = item.sId;
    data['title'] = item.title;
    //处理 string 和int类型的价格
    if (item.price is int || item.price is double) {
      data['price'] = item.price;
    } else {
      data['price'] = double.parse(item.price);
    }
    data['selectedAttr'] = item.selectedAttr;
    data['count'] = item.count;
    data['pic'] = pic;
    //是否选中
    data['checked'] = true;
    return data;
  }
}
