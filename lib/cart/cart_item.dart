import 'package:flutter/material.dart';
import 'package:flutter_jdshop/cart/cart_num.dart';
import 'package:flutter_jdshop/services/screen_adapter.dart';

///购物车item
class CartItem extends StatefulWidget {
  final Map _itemData;

  CartItem(this._itemData, {Key key}) : super(key: key);

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
                "${widget._itemData['pic']}",
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('${widget._itemData["title"]}', maxLines: 2),
                  Text("${widget._itemData["selectedAttr"]}", maxLines: 2),
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text('￥${widget._itemData["price"]}'),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CartNum(widget._itemData),
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
