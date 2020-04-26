import 'package:flutter/material.dart';
import 'package:flutter_jdshop/cart/cart_num.dart';
import 'package:flutter_jdshop/services/screen_adapter.dart';

///购物车item
class CartItem extends StatefulWidget {
  CartItem({Key key}) : super(key: key);

  @override
  _CartItemState createState() {
    return _CartItemState();
  }
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      height: ScreenAdapter.height(200),
      child: Padding(
        padding: EdgeInsets.all(ScreenAdapter.width(10)),
        child: Row(
          children: <Widget>[
            Container(
              width: ScreenAdapter.width(60),
              child: Checkbox(
                value: true,
                onChanged: (v) {},
                activeColor: Colors.pink,
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: ScreenAdapter.width(10)),
              width: ScreenAdapter.width(160),
              child: Image.network(
                "https://www.itying.com/images/flutter/list2.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '啊哈哈哈哈哈哈哈哈哈哈哈哈这又点少啊哈哈哈哈哈哈哈哈哈',
                    maxLines: 2,
                  ),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('￥30'),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CartNum(),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
