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
      appBar: SearchAppBarWidget(
        backgroundColor: Themes.backgroundH,
        color: Themes.mainText,
      ),
      backgroundColor: Themes.backgroundB,
      body: Column(
        children: <Widget>[
          HallBanner(),
          HallModC(),
          Chassis(
            leading: Text(
              '热门资讯',
              style: TextStyle(color: Themes.mainText),
            ),
            suffix: Text(
              '更多',
              style: TextStyle(color: Themes.mainText),
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: news.length,
              separatorBuilder: (c, i) => i > 0
                  ? Divider(
                      height: 10,
                      thickness: 10,
                      color: Themes.backgroundH,
                    )
                  : SizedBox(),
              itemBuilder: (c, i) => news[i],
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        child: Image.asset('assets/tool_icon/q.png', width: 80, height: 150),
      ),
      // floatingActionButtonAnimator: ,
    );
  }
}
