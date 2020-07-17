import 'package:flutter/material.dart';
import 'package:numerology/view/forum/forum_page.dart';
import 'package:numerology/view/ftf/ftf_page.dart';

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
    FtfPage(),
    MallPage(),
    ForumPage(),
    MeinPage(),
  ];

  buildTextStyle(int i) {
    if (_currentIndex == i)
      return TextStyle(color: Themes.mainText, fontSize: 12);
    return TextStyle(color: Themes.secondary, fontSize: 12);
  }

  buildIconColor(int i) {
    if (_currentIndex == i) return Themes.mainText;
    return Themes.secondary;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Themes.backgroundB,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Themes.backgroundH,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: [
            InkWell(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(IconData(0xe60e, fontFamily: 'iconfont'),
                        color: buildIconColor(0)),
                    Text("大厅", style: buildTextStyle(0)),
                  ],
                ),
              ),
              onTap: () => setState(() => _currentIndex = 0),
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(IconData(0xe616, fontFamily: 'iconfont'),
                        color: buildIconColor(1)),
                    Text("面对面", style: buildTextStyle(1)),
                  ],
                ),
              ),
              onTap: () => setState(() => _currentIndex = 1),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 80,
                  height: 55,
                ),
                // Text("商城", style: buildTextStyle(1)),
              ],
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(IconData(0xe71d, fontFamily: 'iconfont'),
                        color: buildIconColor(3)),
                    Text("命理圈", style: buildTextStyle(3)),
                  ],
                ),
              ),
              onTap: () => setState(() => _currentIndex = 3),
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(IconData(0xe601, fontFamily: 'iconfont'),
                        color: buildIconColor(4)),
                    Text("我的", style: buildTextStyle(4)),
                  ],
                ),
              ),
              onTap: () => setState(() => _currentIndex = 4),
            ),
            // Column(
            //   mainAxisSize: MainAxisSize.min,
            //   children: <Widget>[
            //     IconButton(
            //       icon: Icon(Icons.home, color: buildIconColor(2)),
            //       onPressed: () => setState(() => _currentIndex = 2),
            //     ),
            //     Text("我的", style: buildTextStyle(2)),
            //   ],
            // ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () => setState(() => _currentIndex = 2),
        child: Container(
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0.0, 0.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              )
            ],
          ),
          child: Image.asset('assets/tool_icon/tj.png', width: 80, height: 80),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
