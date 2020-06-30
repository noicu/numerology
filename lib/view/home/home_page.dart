import 'package:flutter/material.dart';

import 'package:numerology/view/hall/hall_page.dart';
import 'package:numerology/view/mall/mall_page.dart';
import 'package:numerology/view/mein/mein_page.dart';
import 'package:numerology/view/style/theme.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _children = [
    HallPage(),
    MallPage(),
    MeinPage(),
  ];

  buildTextStyle(int i) {
    if (_currentIndex == i) return TextStyle(color: Themes.mainText);
    return TextStyle(color: Themes.secondary);
  }

  buildIconColor(int i) {
    if (_currentIndex == i) return Themes.mainText;
    return Themes.secondary;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Themes.backgroundB,
      body: _children[_currentIndex],

      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   onTap: (i) => setState(() => _currentIndex = i),
      //   backgroundColor: Color(0xff4E4141),
      //   selectedLabelStyle: TextStyle(color: Color(0xffFFC679)),
      //   items: [
      //     BottomNavigationBarItem(
      //       title: new Text("大厅", style: buildTextStyle(0)),
      //       icon: new Icon(Icons.home, color: buildIconColor(0)),
      //     ),
      //     BottomNavigationBarItem(
      //       title: new Text("商城", style: buildTextStyle(1)),
      //       icon: new Icon(Icons.list, color: buildIconColor(1)),
      //     ),
      //     BottomNavigationBarItem(
      //       title: new Text("我的", style: buildTextStyle(2)),
      //       icon: new Icon(Icons.message, color: buildIconColor(2)),
      //     ),
      //   ],
      // ),
      bottomNavigationBar: BottomAppBar(
        color: Themes.backgroundH,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home, color: buildIconColor(0)),
                  onPressed: () => setState(() => _currentIndex = 0),
                ),
                Text("大厅", style: buildTextStyle(0)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 47,
                ),
                Text("商城", style: buildTextStyle(1)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home, color: buildIconColor(2)),
                  onPressed: () => setState(() => _currentIndex = 2),
                ),
                Text("我的", style: buildTextStyle(2)),
              ],
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () => setState(() => _currentIndex = 1),
        child: Container(
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0)
            ],
          ),
          child: Image.asset('assets/tool_icon/tj.png', width: 80, height: 80),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
