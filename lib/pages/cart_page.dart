import 'package:flutter/material.dart';
import 'package:flutter_jdshop/cart/cart_item.dart';
import 'package:provider/provider.dart';
import '../provider/counter_provider.dart';
import '../services/screen_adapter.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    return Scaffold(
        body: Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            CartItem(),
          ],
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(width: 1, color: Colors.black12))),
            width: ScreenAdapter.width(750),
            height: ScreenAdapter.height(78),
            child: Stack(
              children: <Widget>[
                Align(
                  child: Row(
                    children: <Widget>[
                      Checkbox(value: true, onChanged: (v) {}),
                      Text('全选')
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      color: Colors.pink,
                      onPressed: () {},
                      child: Text(
                        '结算',
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
              ],
            ),
          ),
        )
      ],
    ));
  }
}
