import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

class ProductContentSecond extends StatefulWidget {
  ProductContentSecond({Key key}) : super(key: key);

  _ProductContentSecondState createState() => _ProductContentSecondState();
}

class _ProductContentSecondState extends State<ProductContentSecond> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrl: "http://jd.itying.com/pcontent?id=5a0432f4010e71123466144c",
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {},
            ),
          )
        ],
      ),
    );
  }
}
