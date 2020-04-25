import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/screen_adapter.dart';

class BuyButton extends StatelessWidget {
  String text;
  Color color;
  GestureTapCallback callback;

  BuyButton({@required this.text, this.color = Colors.black, this.callback});

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(
      height: ScreenAdapter.height(68),
      child: RaisedButton(
        elevation: 0,
        color: this.color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Text(this.text, style: TextStyle(color: Colors.white)),
        onPressed: this.callback,
      ),
    );
  }
}
