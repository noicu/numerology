import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:numerology/view/style/theme.dart';
import 'package:numerology/view/widgets/chassis.dart';

class HallModC extends StatefulWidget {
  HallModC({Key key}) : super(key: key);

  @override
  _HallModCState createState() => _HallModCState();
}

class _HallModCState extends State<HallModC> {
  List mods = [
    {
      "name": '八字',
      "icon": 'assets/tool_icon/s.png',
      "on": "editor",
    },
    {
      "name": '解梦',
      "icon": 'assets/tool_icon/z.png',
      "on": "editor",
    },
    {
      "name": '黄历',
      "icon": 'assets/tool_icon/w.png',
      "on": "almanac",
    },
    {
      "name": '风水',
      "icon": 'assets/tool_icon/l.png',
      "on": "editor",
    },
    {
      "name": '姻缘',
      "icon": 'assets/tool_icon/sz.png',
      "on": "editor",
    },
    {
      "name": '星座',
      "icon": 'assets/tool_icon/xz.png',
      "on": "editor",
    },
    {
      "name": '塔罗牌',
      "icon": 'assets/tool_icon/tlp.png',
      "on": "editor",
    },
    {
      "name": '姓名',
      "icon": 'assets/tool_icon/tlp.png',
      "on": "editor",
    },
    {
      "name": '相术',
      "icon": 'assets/tool_icon/tlp.png',
      "on": "editor",
    },
    {
      "name": '运势',
      "icon": 'assets/tool_icon/tlp.png',
      "on": "editor",
    },
    {
      "name": '生肖',
      "icon": 'assets/tool_icon/tlp.png',
      "on": "editor",
    },
    {
      "name": '周易',
      "icon": 'assets/tool_icon/tlp.png',
      "on": "editor",
    },
    {
      "name": '血型',
      "icon": 'assets/tool_icon/tlp.png',
      "on": "editor",
    },
  ];

  Widget _buildItem(it) => InkWell(
        child: Container(
          // margin: EdgeInsets.only(right: 10, left: 10),
          child: Column(
            children: <Widget>[
              Image.asset(it['icon'], width: 50, height: 50),
              Text(
                "${it['name']}",
                style: TextStyle(color: Themes.mainText),
              ),
            ],
          ),
        ),
        onTap: () => Navigator.of(context).pushNamed(it['on']),
      );

  @override
  Widget build(BuildContext context) {
    inspect(this);
    return Chassis(
      leading: Text(
        '热门功能',
        style: TextStyle(color: Themes.mainText),
      ),
      suffix: Text(
        '更多',
        style: TextStyle(color: Themes.mainText),
      ),
      child: Container(
        height: 70,
        width: double.infinity,
        child: GridView(
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 0,
            crossAxisSpacing: 5,
          ),
          children: mods.map((e) => _buildItem(e)).toList(),
        ),
      ),
    );
  }
}
