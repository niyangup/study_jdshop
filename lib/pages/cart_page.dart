import 'package:flutter/material.dart';
import 'package:flutter_jdshop/cart/cart_item.dart';
import 'package:flutter_jdshop/provider/cart_provider.dart';
import 'package:provider/provider.dart';
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

    var cartProvider = Provider.of<Cart>(context);

    return Scaffold(
        body: cartProvider.getCartList.length <= 0
            ? Center(
                child: Text('购物车空空的...'),
              )
            : Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Column(
                        children: cartProvider.getCartList.map((v) {
                          return CartItem(v);
                        }).toList(),
                      ),
                      SizedBox(height: ScreenAdapter.height(100)),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top:
                                  BorderSide(width: 1, color: Colors.black12))),
                      width: ScreenAdapter.width(750),
                      height: ScreenAdapter.height(78),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Checkbox(value: true, onChanged: (v) {}),
                                  Text('全选')
                                ],
                              ),
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
