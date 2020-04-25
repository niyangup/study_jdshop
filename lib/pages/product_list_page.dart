import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_jdshop/services/search_services.dart';
import '../config/config.dart';
import '../model/product_model.dart';
import '../services/screen_adapter.dart';
import '../widget/loading_widget.dart';

class ProductListPage extends StatefulWidget {
  Map arguments;

  ProductListPage({Key key, this.arguments}) : super(key: key);

  @override
  _ProductListPageState createState() {
    return _ProductListPageState();
  }
}

class _ProductListPageState extends State<ProductListPage> {
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey();
  int _page = 1;
  List<ProductItemModel> _productList = [];
  String _sort = "";
  ScrollController _scrollController = new ScrollController();
  bool flag = true;
  int _pageSize = 8;
  bool hasMore = true;
  bool _ONE = true;
  bool _TOW = false;
  bool _THREE = false;
  bool _FOUR = false;

  ///配置搜索框的值
  TextEditingController _searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.arguments["keyWords"] ?? "";
    _getProductListData();
    _scrollController.addListener(() {
      var height = _scrollController.position.pixels; //获取滚动条滚动的高度

      var totalHeight = _scrollController.position.maxScrollExtent; //获取页面高度

      if (height >= totalHeight - 20 && flag && hasMore) {
        _getProductListData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  ///获取商品列表数据
  _getProductListData({bool refresh = false}) async {
    String api;

    flag = false;
    print(widget.arguments["keyWords"]);
    if (widget.arguments["keyWords"] == null) {
      api =
          "${Config.domain}api/plist?cid=${widget.arguments["cid"]}&page=$_page&sord=$_sort&pageSize=$_pageSize";
    } else {
//      api =
//          "${Config.domain}api/plist?search=${widget.arguments["keyWords"]}&page=$_page&sord=$_sort&pageSize=$_pageSize";
      api =
          "${Config.domain}api/plist?search=${this._searchController.text}&page=$_page&sord=$_sort&pageSize=$_pageSize";
    }

    print(api);
    var response = await new Dio().get(api);
    if (response.statusCode == 200) {
      var productData = ProductModel.fromJson(response.data);
      print(productData.result.length);

      if (productData.result.length < _pageSize) {
        //没有数据了
        hasMore = false;
      }
      setState(() {
        if (refresh) {
          _productList = productData.result;
        } else {
          _productList.addAll(productData.result);
          _page++;
        }
      });
    } else {
      _globalKey.currentState.showSnackBar(new SnackBar(content: Text('请求错误')));
    }
    flag = true;
  }

  ///底部列表
  Widget _productListWidget() {
    return _productList.isEmpty
        ? LoadingWidget()
        : Container(
            padding: const EdgeInsets.all(10.0),
            margin: EdgeInsets.only(top: ScreenAdapter.height(90)),
            child: ListView.separated(
              controller: _scrollController,
              itemCount: this._productList.length,
              itemBuilder: (context, index) {
                String pic = this._productList[index].pic;
                pic = Config.domain + pic.replaceAll("\\", "/");

                return Row(
                  children: <Widget>[
                    Container(
                      width: ScreenAdapter.width(180),
                      height: ScreenAdapter.height(180),
                      child: Image.network("$pic", fit: BoxFit.cover),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        height: ScreenAdapter.height(180),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("${this._productList[index].title}",
                                maxLines: 2, overflow: TextOverflow.ellipsis),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: ScreenAdapter.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                                  //注意 如果Container里面加上decoration属性，这个时候color属性必须得放在BoxDecoration
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(230, 230, 230, 0.9),
                                  ),

                                  child: Text("4g"),
                                ),
                                Container(
                                  height: ScreenAdapter.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(230, 230, 230, 0.9),
                                  ),
                                  child: Text("126"),
                                ),
                              ],
                            ),
                            Text(
                              "¥${this._productList[index].price}",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          );
  }

  ///顶部导航按钮选中颜色切换
  _subHeaderChange(id) {
    switch (id) {
      case 0:
        setState(() {
          _ONE = true;
          _TOW = false;
          _THREE = false;
          _FOUR = false;
        });
        break;

      case 1:
        setState(() {
          _ONE = false;
          _TOW = true;
          _THREE = false;
          _FOUR = false;
        });
        break;
      case 2:
        setState(() {
          _ONE = false;
          _TOW = false;
          _THREE = true;
          _FOUR = false;
        });
        break;
      case 3:
        setState(() {
          _ONE = false;
          _TOW = false;
          _THREE = false;
          _FOUR = true;
        });
        break;
      default:
        break;
    }
  }

  ///顶部导航
  Widget _subHeaderWidget() {
    return Positioned(
      width: ScreenAdapter.width(750),
      height: ScreenAdapter.height(90),
      top: 0,
      child: Container(
        width: ScreenAdapter.width(750),
        height: ScreenAdapter.height(90),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 1,
          color: Colors.grey,
        ))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  _subHeaderChange(0);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      top: ScreenAdapter.width(20),
                      bottom: ScreenAdapter.width(20)),
                  child: Text(
                    "综合",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _ONE ? Colors.red : Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  _subHeaderChange(1);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      top: ScreenAdapter.width(20),
                      bottom: ScreenAdapter.width(20)),
                  child: Text(
                    "销量",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _TOW ? Colors.red : Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: ScreenAdapter.width(20),
                      bottom: ScreenAdapter.width(20)),
                  child: Text(
                    "价格",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _THREE ? Colors.red : Colors.black),
                  ),
                ),
                onTap: () {
                  _subHeaderChange(2);
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: ScreenAdapter.width(20),
                      bottom: ScreenAdapter.width(20)),
                  child: Text(
                    "筛选",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _FOUR ? Colors.red : Colors.black),
                  ),
                ),
                onTap: () {
                  _subHeaderChange(3);
                  _globalKey.currentState.openEndDrawer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(bottom: 5),
          height: ScreenAdapter.height(72),
          child: TextField(
            controller: _searchController,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none)),
          ),
          decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30)),
        ),
        actions: <Widget>[
          InkWell(
              child: Container(
                  alignment: Alignment.center,
                  width: ScreenAdapter.width(80),
                  height: ScreenAdapter.height(72),
                  child: Text('搜索', style: TextStyle(fontSize: 18))),
              onTap: () async {
                String value = _searchController.text.trim();
                if (value.length > 0) {
                  SearchServices.setHistoryData(value);
                }
                await _getProductListData(refresh: true);
              })
        ],
      ),
      endDrawer: Drawer(
        child: Container(
          child: Text('实现筛选'),
        ),
      ),
      body: Stack(
        children: <Widget>[
          _productListWidget(),
          _subHeaderWidget(),
        ],
      ),
    );
  }
}
