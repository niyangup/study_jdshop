import 'package:flutter/material.dart';
import 'package:flutter_jdshop/model/product_content_model.dart';
import 'package:flutter_jdshop/services/screen_adapter.dart';

///购物车item数量加减区域 用于BottomSheet
class CartNum extends StatefulWidget {
  final ProductContentItem productContentItem;

  CartNum(this.productContentItem, {Key key}) : super(key: key);

  @override
  _CartNumState createState() {
    return _CartNumState();
  }
}

class _CartNumState extends State<CartNum> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(
      width: ScreenAdapter.width(164),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _leftBtn(),
          _centerArea(),
          _rightBtn(),
        ],
      ),
    );
  }

  ///左侧按钮
  Widget _leftBtn() {
    return InkWell(
      onTap: () {
        setState(() {
          if (widget.productContentItem.count > 1) {
            widget.productContentItem.count--;
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text('-'),
      ),
    );
  }

  ///右侧按钮
  Widget _rightBtn() {
    return InkWell(
      onTap: () {
        setState(() {
          widget.productContentItem.count++;
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text('+'),
      ),
    );
  }

  ///中间区域
  Widget _centerArea() {
    return Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(70),
      height: ScreenAdapter.height(45),
      decoration: BoxDecoration(
        border: Border(
            left: BorderSide(width: 1, color: Colors.black12),
            right: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: Text('${widget.productContentItem.count}'),
    );
  }
}
