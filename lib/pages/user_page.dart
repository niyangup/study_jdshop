import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../provider/Counter.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() {
    return _UserPageState();
  }
}

class _UserPageState extends State<UserPage> {
  sendCode() async {
    Response response = await Dio()
        .post("http://jd.itying.com/api/sendCode", data: {"tel": 16678625709});
    print(response.data);
  }

  @override
  void initState() {
    super.initState();
    initJpush();
  }

  JPush jpush = new JPush();

  initJpush() {
    jpush.setup(
      appKey: "37021c77619c299d95b1c29c",
      channel: "theChannel",
      production: false,
      debug: false, // 设置是否打印 debug 日志
    );

    jpush.addEventHandler(
      // 接收通知回调方法。
      onReceiveNotification: (Map<String, dynamic> message) async {
        print("flutter onReceiveNotification: $message");
      },
      // 点击通知回调方法。
      onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
      },
      // 接收自定义消息回调方法。
      onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
      },
    );
    jpush.setAlias("jp2").then((map) {
      print('别名设置成功');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("我的"),
      ),
    );
  }
}
