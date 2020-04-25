import 'package:flutter/material.dart';
import '../services/screen_adapter.dart';
import '../services/search_services.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  var _keyWords = "";
  List _historyListData = [];

  @override
  void initState() {
    super.initState();
    this._getHistoryData();
  }

  _getHistoryData() async {
    var value = await SearchServices.getHistoryList();
    setState(() {
      this._historyListData = value;
    });
  }

  Widget _historyListWidget() {
    return _historyListData.length <= 0
        ? Text('')
        : Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text("历史记录", style: Theme.of(context).textTheme.title),
              ),
              Divider(),
              Column(
                children: this._historyListData.map((v) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text('$v'),
                        onLongPress: () {
                          this._showAlertDialog(v);
                        },
                      ),
                      Divider()
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 50),
              InkWell(
                child: Container(
                    width: ScreenAdapter.width(400),
                    height: ScreenAdapter.height(80),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 1)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.delete),
                          Text("清空历史记录")
                        ])),
                onTap: () async {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: Text('提示信息'),
                          content: Text('确定要清空历史记录吗?'),
                          actions: <Widget>[
                            FlatButton(
                                child: Text('取消'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Dismiss alert dialog
                                }),
                            FlatButton(
                                child: Text('确定'),
                                onPressed: () async {
                                  await SearchServices.clearHistoryList();
                                  this._getHistoryData();
                                  Navigator.of(context).pop();
                                })
                          ]);
                    },
                  );
                },
              ),
              SizedBox(height: 10),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.only(bottom: 5),
            height: ScreenAdapter.height(72),
            child: TextField(
              onChanged: (value) => this._keyWords = value,
              textAlign: TextAlign.start,
              autofocus: true,
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
              onTap: () {
                if (_keyWords.trim().length > 0) {
                  SearchServices.setHistoryData(this._keyWords);
                }
                Navigator.pushReplacementNamed(context, "/productList",
                    arguments: {"keyWords": _keyWords});
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                child: Text("热搜", style: Theme.of(context).textTheme.title),
              ),
              Divider(),
              Wrap(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("女装"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("女装"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("笔记本电脑"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("女装111"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("女装"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("女装"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text("女装"),
                  )
                ],
              ),
              SizedBox(height: 10),
              _historyListWidget(),
            ],
          ),
        ));
  }

  void _showAlertDialog(v) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('提示信息'),
            content: Text('您确定要删除吗?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('取消')),
              FlatButton(
                  onPressed: () async {
                    await SearchServices.removeHistoryData(v);
                    this._getHistoryData();
                    Navigator.pop(context);
                  },
                  child: Text('确定')),
            ],
          );
        });
  }
}
