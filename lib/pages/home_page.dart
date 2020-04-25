import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/product_model.dart';
import '../services/screen_adapter.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../model/focus_model.dart';
import 'package:dio/dio.dart';
import '../config/config.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  List<FocusItemModel> _focusList = [];
  List<ProductItemModel> _hotProductData = [];
  List<ProductItemModel> _bestProductData = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getFocusData();
    _getHotProductData();
    _getBestProductData();
  }

  ///获取轮播图数据
  _getFocusData() async {
    try {
      Response<Map> response =
          await Dio().get("http://jd.itying.com/api/focus");
      if (response.statusCode == 200) {
        FocusModel model = new FocusModel.fromJson(response.data);
        setState(() {
          this._focusList = model.result;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  ///获取猜你喜欢数据
  _getHotProductData() async {
    var api = "${Config.domain}api/plist?is_hot=1";
    Response response = await Dio().get(api);
    ProductModel productModel = new ProductModel.fromJson(response.data);
    setState(() {
      this._hotProductData = productModel.result;
    });
  }

  ///获取热门推荐喜欢数据
  _getBestProductData() async {
    var api = "${Config.domain}api/plist?is_best=1";
    Response response = await Dio().get(api);
    ProductModel productModel = new ProductModel.fromJson(response.data);
    setState(() {
      this._bestProductData = productModel.result;
    });
  }

  ///轮播图
  Widget _swiperWidget() {
    return _focusList.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            child: AspectRatio(
              aspectRatio: 2 / 1,
              child: Swiper(
                autoplay: true,
                itemBuilder: (BuildContext context, int index) {
                  String pic = this._focusList[index].pic;
                  pic = Config.domain + pic.replaceAll('\\', '/');
                  return new Image.network(
                    "$pic",
                    fit: BoxFit.fill,
                  );
                },
                itemCount: this._focusList.length,
//                pagination: new SwiperPagination(),
              ),
            ),
          );
  }

  ///标题
  Widget _titleWidget(String title) {
    return Container(
      height: ScreenAdapter.height(40),
      margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
      padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
      child: Text(
        title,
        style: TextStyle(color: Colors.black54),
      ),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
        color: Colors.pink,
        width: ScreenAdapter.width(10),
      ))),
    );
  }

  ///热门商品
  Widget _hotProductList() {
    if (_hotProductData != null && _hotProductData.length > 0) {
      return Container(
        padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
        height: ScreenAdapter.width(230),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _hotProductData.length,
          itemBuilder: (context, index) {
            String sPic = this._hotProductData[index].sPic;
            sPic = Config.domain + sPic.replaceAll("\\", "/");
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: ScreenAdapter.width(21)),
                  width: ScreenAdapter.width(140),
                  height: ScreenAdapter.height(140),
                  child: Image.network(sPic, fit: BoxFit.cover),
                ),
                Container(
                  height: ScreenAdapter.height(44),
                  padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                  child: Text("¥${this._hotProductData[index].price}",
                      style: TextStyle(color: Colors.red, fontSize: 16)),
                )
              ],
            );
          },
        ),
      );
    } else {
      return Text('没数据');
    }
  }

  ///热门推荐
  Widget _recProductListWidget() {
    var itemWidth = (ScreenAdapter.getScreenWidth() - 50) / 2;
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 5,
        spacing: 10,
        children: this._bestProductData.map((value) {
          var sImg = value.sPic;
          sImg = Config.domain + sImg.replaceAll("\\", "/");

          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/productContent",
                  arguments: {"id": value.sId});
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                width: itemWidth,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(sImg, fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                      child: Text(
                        '${value.title}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text("¥${value.price}",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16)),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text("¥${value.oldPrice}",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    decoration: TextDecoration.lineThrough)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(height: ScreenAdapter.width(20)),
        _titleWidget("猜你喜欢"),
        SizedBox(height: ScreenAdapter.width(20)),
        _hotProductList(),
        SizedBox(height: ScreenAdapter.width(20)),
        _titleWidget("热门推荐"),
        _recProductListWidget(),
      ],
    );
  }
}
