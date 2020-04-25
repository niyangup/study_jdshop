import 'package:flutter/material.dart';
import 'package:flutter_jdshop/routers/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.white
      ),
    );
  }
}
