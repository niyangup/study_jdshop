import 'package:flutter/material.dart';
import '../cart_page.dart';
import '../category_page.dart';
import '../home_page.dart';
import '../user_page.dart';
import '../../services/screen_adapter.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabsState createState() {
    return _TabsState();
  }
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  PageController _pageController;

  List<Widget> _pages = [HomePage(), CategoryPage(), CartPage(), UserPage()];

  @override
  void initState() {
    super.initState();
    _pageController = new PageController(initialPage: this._currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    return Scaffold(
      appBar: _currentIndex >= 2
          ? AppBar(
              title: _currentIndex == 2 ? Text('购物车') : Text('用户中心'),
            )
          : AppBar(
              leading: IconButton(
                  icon: Icon(Icons.center_focus_weak), onPressed: () {}),
              title: InkWell(
                borderRadius: BorderRadius.circular(30),
                highlightColor: Colors.grey,
                onTap: () {
                  Navigator.pushNamed(context, "/search");
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  height: ScreenAdapter.height(72),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.8),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: <Widget>[Icon(Icons.search), Text("笔记本")],
                  ),
                ),
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.message, size: 28, color: Colors.black),
                    onPressed: () {}),
              ],
            ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: this._pages,
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex,
        fixedColor: Colors.pink,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            this._currentIndex = index;
            this._pageController.jumpToPage(index);
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text('分类')),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text('购物车')),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('我的'),
          ),
        ],
      ),
    );
  }
}
