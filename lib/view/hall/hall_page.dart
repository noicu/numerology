import 'package:flutter/material.dart';
import 'package:numerology/view/hall/hall_banner.dart';
import 'package:numerology/view/hall/hall_mod_c.dart';
import 'package:numerology/view/style/theme.dart';
import 'package:numerology/view/widgets/chassis.dart';
import 'package:numerology/view/widgets/news_item.dart';
import 'package:numerology/view/widgets/search_app_bar.dart';

class HallPage extends StatefulWidget {
  HallPage({Key key}) : super(key: key);

  @override
  _HallPageState createState() => _HallPageState();
}

class _HallPageState extends State<HallPage> {
  List news = [
    NewsItem(),
    NewsItem(),
    NewsItem(),
    NewsItem(),
  ];
  buildNews() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: SearchAppBarWidget(
        backgroundColor: Themes.backgroundH,
        color: Themes.mainText,
      ),
      backgroundColor: Themes.backgroundB,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          HallBanner(),
          HallModC(),
          Chassis(
            leading: Text(
              '热门资讯',
              style: TextStyle(color: Themes.mainText),
            ),
            suffix: InkWell(
              child: Text(
                "更多",
                style: TextStyle(color: Themes.mainText),
              ),
              onTap: () => Navigator.of(context).pushNamed("editor"),
            ),
          ),
          ...news.map((e) => e).toList(),
        ],
      ),
      // body: Column(
      //   children: <Widget>[
      //     HallBanner(),
      //     HallModC(),
      //     Chassis(
      //       leading: Text(
      //         '热门资讯',
      //         style: TextStyle(color: Themes.mainText),
      //       ),
      //       suffix: FlatButton(
      //         child: Text("Open editor"),
      //         onPressed: () => Navigator.of(context).pushNamed("editor"),
      //       ),
      //     ),
      //     Expanded(
      //       child: ListView.separated(
      //         physics: BouncingScrollPhysics(),
      //         itemCount: news.length,
      //         separatorBuilder: (c, i) => Divider(
      //           height: 10,
      //           thickness: 10,
      //           color: Themes.backgroundH,
      //         ),
      //         itemBuilder: (c, i) => news[i],
      //       ),
      //     ),
      //   ],
      // ),
      floatingActionButton: Container(
        child: Image.asset('assets/tool_icon/q.png', width: 50, height: 100),
      ),
      // floatingActionButtonAnimator: ,
    );
  }
}
