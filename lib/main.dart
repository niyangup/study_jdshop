import 'package:flutter/material.dart';
import 'package:flutter_jdshop/provider/cart_provider.dart';
import 'package:flutter_jdshop/provider/counter_provider.dart';
import 'package:flutter_jdshop/routers/router.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(primarySwatch: Colors.red, primaryColor: Colors.white),
      ),
    );
  }
}
