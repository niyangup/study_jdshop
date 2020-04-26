import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:flutter_jdshop/model/product_content_model.dart';

class ProductContentSecond extends StatefulWidget {
  final ProductContentItem productContentItem;

  ProductContentSecond(this.productContentItem, {Key key}) : super(key: key);

  _ProductContentSecondState createState() => _ProductContentSecondState();
}

class _ProductContentSecondState extends State<ProductContentSecond>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrl:
                  "http://jd.itying.com/pcontent?id=${widget.productContentItem.sId}",
            ),
          )
        ],
      ),
    );
  }
}
