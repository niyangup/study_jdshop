import 'package:flutter/material.dart';
import 'package:flutter_jdshop/widget/buy_button.dart';
import 'package:flutter_jdshop/widget/loading_widget.dart';
import '../services/screen_adapter.dart';

import 'ProductContent/ProductContentFirst.dart';
import 'ProductContent/ProductContentSecond.dart';
import 'ProductContent/ProductContentThird.dart';
import 'package:dio/dio.dart';
import '../config/config.dart';
import '../model/product_content_model.dart';

class ProductContentPage extends StatefulWidget {
  final Map arguments;

  ProductContentPage({Key key, this.arguments}) : super(key: key);

  _ProductContentPageState createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
  ProductContentItem productContentItem;

  @override
  void initState() {
    super.initState();
    _getContentData();
  }

  _getContentData() async {
    var api = "${Config.domain}api/pcontent?id=${widget.arguments["id"]}";
    var response = await new Dio().get(api);
    var productModel = new ProductContentModel.fromJson(response.data);

    setState(() {
      productContentItem = productModel.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenAdapter.width(400),
                child: TabBar(
                  indicatorColor: Colors.red,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: <Widget>[
                    Tab(child: Text('商品')),
                    Tab(child: Text('详情')),
                    Tab(child: Text('评价'))
                  ],
                ),
              )
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {
                showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(ScreenAdapter.width(600),
                        ScreenAdapter.width(130), ScreenAdapter.width(10), 0),
                    items: [
                      PopupMenuItem(
                        child: Row(
                            children: <Widget>[Icon(Icons.home), Text("首页")]),
                      ),
                      PopupMenuItem(
                        child: Row(
                            children: <Widget>[Icon(Icons.search), Text("搜索")]),
                      )
                    ]);
              },
            )
          ],
        ),
        body: this.productContentItem == null
            ? LoadingWidget()
            : Stack(
                children: <Widget>[
                  TabBarView(
                    children: <Widget>[
                      ProductContentFirst(this.productContentItem),
                      ProductContentSecond(this.productContentItem),
                      ProductContentThird()
                    ],
                    physics: NeverScrollableScrollPhysics(),
                  ),
                  Positioned(
                    width: ScreenAdapter.width(750),
                    height: ScreenAdapter.width(100),
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: Colors.black26),
                          )),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: ScreenAdapter.width(100),
                                right: ScreenAdapter.width(100),
                                top: ScreenAdapter.height(10)),
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.shopping_cart),
                                Text('购物车')
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: BuyButton(
                                  text: "加入购物车",
                                  color: Color.fromRGBO(253, 1, 0, 0.9),
                                  callback: () {})),
                          SizedBox(width: ScreenAdapter.width(20)),
                          Expanded(
                              flex: 1,
                              child: BuyButton(
                                  text: "立即购买",
                                  color: Color.fromRGBO(255, 165, 0, 0.9),
                                  callback: () {})),
                          SizedBox(width: ScreenAdapter.width(10)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
