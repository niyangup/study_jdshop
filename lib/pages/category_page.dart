import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../config/config.dart';
import '../model/category_model.dart';
import '../services/screen_adapter.dart';


class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() {
    return _CategoryPageState();
  }
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  List<CateItemModel> _leftCateList = [];

  List<CateItemModel> _rightCateList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getLeftData();
  }

  ///获取左侧数据
  _getLeftData() async {
    Response<Map> response = await Dio().get("${Config.domain}api/pcate");
    if (response.statusCode == 200) {
      CategoryModel model = new CategoryModel.fromJson(response.data);
      _getRightData(model.result[0].sId);
      setState(() {
        this._leftCateList = model.result;
      });
    } else {
      Scaffold.of(context).showSnackBar(new SnackBar(content: Text('请求异常')));
    }
  }

  ///获取右侧数据
  _getRightData(pid) async {
    Response<Map> response =
        await Dio().get("${Config.domain}api/pcate?pid=$pid");
    if (response.statusCode == 200) {
      CategoryModel model = new CategoryModel.fromJson(response.data);
      setState(() {
        this._rightCateList = model.result;
      });
    } else {
      Scaffold.of(context).showSnackBar(new SnackBar(content: Text('请求异常')));
    }
  }

  ///左侧控件
  Widget _leftCateWidget(leftWidth) {
    return _leftCateList.isEmpty
        ? Container(width: leftWidth, height: double.infinity)
        : Container(
            width: leftWidth,
            height: double.infinity,
            child: ListView.builder(
              itemCount: _leftCateList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedItem = index;
                          _getRightData(_leftCateList[index].sId);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 14),
                        width: double.infinity,
                        height: ScreenAdapter.height(84),
                        child: Text(
                          '${_leftCateList[index].title}',
                          textAlign: TextAlign.center,
                        ),
                        color: _selectedItem == index
                            ? Color.fromRGBO(240, 246, 246, 0.9)
                            : Colors.white,
                      ),
                    ),
                    Divider(height: 1),
                  ],
                );
              },
            ),
          );
  }

  ///右侧控件
  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    return _rightCateList.isEmpty
        ? Expanded(
            child: Container(
                width: rightItemWidth,
                padding: EdgeInsets.all(10),
                color: Color.fromRGBO(240, 246, 246, 0.9),
                height: double.infinity,
                child: Center(child: CircularProgressIndicator())))
        : Expanded(
            child: Container(
              width: rightItemWidth,
              padding: EdgeInsets.all(10),
              color: Color.fromRGBO(240, 246, 246, 0.9),
              height: double.infinity,
              child: GridView.builder(
                itemCount: this._rightCateList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: rightItemWidth / rightItemHeight,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  //处理图片
                  String pic = this._rightCateList[index].pic;
                  pic = Config.domain + pic.replaceAll("\\", "/");

                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/productList",
                          arguments: {"cid": this._rightCateList[index].sId});
                    },
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Image.network("$pic", fit: BoxFit.cover),
                          ),
                          Container(
                            height: ScreenAdapter.height(35),
                            child: Text(this._rightCateList[index].title),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            flex: 1,
          );
  }

  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    var leftWidth = ScreenAdapter.getScreenWidth() / 4;
    var rightItemWidth = (ScreenAdapter.getScreenWidth() - leftWidth - 20) / 3;
    rightItemWidth = ScreenAdapter.width(rightItemWidth);
    var rightItemHeight = rightItemWidth + ScreenAdapter.height(28);

    return Row(
      children: <Widget>[
        _leftCateWidget(leftWidth),
        _rightCateWidget(rightItemWidth, rightItemHeight)
      ],
    );
  }
}
