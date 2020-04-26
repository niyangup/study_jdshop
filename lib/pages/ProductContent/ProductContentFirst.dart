import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/model/product_content_model.dart';
import 'package:flutter_jdshop/services/screen_adapter.dart';
import 'package:flutter_jdshop/widget/buy_button.dart';

class ProductContentFirst extends StatefulWidget {
  final ProductContentItem productContentItem;

  ProductContentFirst(this.productContentItem, {Key key}) : super(key: key);

  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst>
    with AutomaticKeepAliveClientMixin {
  List<Attr> attr;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    this.attr = widget.productContentItem.attr;
    _initAttr();
  }

  //初始化Attr 格式化数据
  _initAttr() {
    var attr = this.attr;
    for (var i = 0; i < attr.length; i++) {
      attr[i].attrList.clear(); //清空数组里面的数据

      for (var j = 0; j < attr[i].list.length; j++) {
        if (j == 0) {
          attr[i].attrList.add({"title": attr[i].list[j], "checked": true});
        } else {
          attr[i].attrList.add({"title": attr[i].list[j], "checked": false});
        }
      }
    }

    _getSelectedAttrValue();
  }

  //获取选中的值
  _getSelectedAttrValue() {
    var _list = this.attr;
    List tempArr = [];
    for (var i = 0; i < _list.length; i++) {
      for (var j = 0; j < _list[i].list.length; j++) {
        if (_list[i].attrList[j]['checked'] == true) {
          tempArr.add(_list[i].attrList[j]["title"]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    //处理图片
    String pic = Config.domain + widget.productContentItem.pic;
    pic = pic.replaceAll('\\', '/');

    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network("$pic", fit: BoxFit.contain),
          ),
          //标题
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text("${widget.productContentItem.title}",
                style: TextStyle(
                    color: Colors.black87, fontSize: ScreenAdapter.size(36))),
          ),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: Text("${widget.productContentItem.subTitle}",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: ScreenAdapter.size(28)))),
          //价格
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Text("特价: "),
                      Text("¥${widget.productContentItem.price}",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: ScreenAdapter.size(46)))
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("原价: "),
                      Text("¥${widget.productContentItem.oldPrice}",
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: ScreenAdapter.size(28),
                              decoration: TextDecoration.lineThrough))
                    ],
                  ),
                ),
              ],
            ),
          ),
          //筛选
          attr.length <= 0
              ? Text('')
              : Container(
                  margin: EdgeInsets.only(top: 10),
                  height: ScreenAdapter.height(80),
                  child: InkWell(
                    child: Row(
                      children: <Widget>[
                        Text("已选: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("115，黑色，XL，1件")
                      ],
                    ),
                    onTap: () {
                      _attrBottomSheet();
                    },
                  ),
                ),
          Divider(),
          Container(
            height: ScreenAdapter.height(80),
            child: Row(
              children: <Widget>[
                Text("运费: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("免运费")
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  void _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setBottomState) {
              return Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: ListView(
                        children: <Widget>[
                          Column(
                              children: this.attr.map((v) {
                            return Wrap(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      top: ScreenAdapter.height(24)),
                                  alignment: Alignment.center,
                                  width: ScreenAdapter.width(100),
                                  child: Text('${v.cate}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: ScreenAdapter.width(20)),
                                  width: ScreenAdapter.width(590),
                                  child: Wrap(
                                    spacing: 10,
                                    children: v.attrList.map((item) {
                                      return GestureDetector(
                                        onTap: () {
                                          _changeAttr(v.cate, item["title"],
                                              setBottomState);
                                        },
                                        child: Chip(
                                          label: Text('${item["title"]}'),
                                          backgroundColor: item["checked"]
                                              ? Colors.pink
                                              : Colors.grey,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            );
                          }).toList()),
                        ],
                      ),
                    ),
                    Positioned(
                      width: ScreenAdapter.width(750),
                      height: ScreenAdapter.height(76),
                      bottom: 0,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: ScreenAdapter.width(750),
                            height: ScreenAdapter.height(76),
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: ScreenAdapter.width(20)),
                                Expanded(
                                  flex: 1,
                                  child: BuyButton(
                                      text: "加入购物车",
                                      color: Color.fromRGBO(253, 1, 0, 0.9),
                                      callback: () {}),
                                ),
                                SizedBox(width: ScreenAdapter.width(20)),
                                Expanded(
                                  flex: 1,
                                  child: BuyButton(
                                      text: "立即购买",
                                      color: Color.fromRGBO(255, 165, 0, 0.9),
                                      callback: () {}),
                                ),
                                SizedBox(width: ScreenAdapter.width(10)),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  //改变属性值
  _changeAttr(cate, title, setBottomState) {
    var attr = this.attr;
    for (var i = 0; i < attr.length; i++) {
      if (attr[i].cate == cate) {
        for (var j = 0; j < attr[i].attrList.length; j++) {
          attr[i].attrList[j]["checked"] = false;
          if (title == attr[i].attrList[j]["title"]) {
            attr[i].attrList[j]["checked"] = true;
          }
        }
      }
    }
    setBottomState(() {
      //注意  改变showModalBottomSheet里面的数据 来源于StatefulBuilder
      this.attr = attr;
    });
    _getSelectedAttrValue();
  }
}
