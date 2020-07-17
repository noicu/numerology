import 'package:flutter/material.dart';
import 'package:numerology/view/style/theme.dart';
import 'package:numerology/view/widgets/avatar.dart';
import 'package:numerology/view/widgets/search_app_bar.dart';

class ForumPage extends StatefulWidget {
  ForumPage({Key key}) : super(key: key);

  @override
  _MallPageState createState() => _MallPageState();
}

class _MallPageState extends State<ForumPage> {
  final data = <Color>[
    Colors.orange[50],
    Colors.orange[100],
    Colors.orange[200],
    Colors.orange[300],
    Colors.orange[400],
    Colors.orange[500],
    Colors.orange[600],
  ];
  PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: 0.8,
      initialPage: (data.length / 2).round(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  buildTextStyle() {
    return TextStyle(color: Themes.secondary, fontSize: 12);
  }

  buildIconColor() {
    return Themes.secondary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBarWidget(
        backgroundColor: Themes.backgroundH,
        color: Themes.mainText,
      ),
      backgroundColor: Themes.backgroundB,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Card(
            color: Themes.backgroundH,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            IconData(0xe60e, fontFamily: 'iconfont'),
                            color: buildIconColor(),
                          ),
                          Text(
                            "大厅",
                            style: buildTextStyle(),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            IconData(0xe60e, fontFamily: 'iconfont'),
                            color: buildIconColor(),
                          ),
                          Text(
                            "大厅",
                            style: buildTextStyle(),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            IconData(0xe60e, fontFamily: 'iconfont'),
                            color: buildIconColor(),
                          ),
                          Text(
                            "大厅",
                            style: buildTextStyle(),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            IconData(0xe60e, fontFamily: 'iconfont'),
                            color: buildIconColor(),
                          ),
                          Text(
                            "大厅",
                            style: buildTextStyle(),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Themes.backgroundH,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Avatar(
                    '',
                    size: 30,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'asd',
                            style: TextStyle(color: Themes.mainText),
                          ),
                          Text(
                            '关注',
                            style: TextStyle(color: Themes.mainText),
                          ),
                        ],
                      ),
                      Text(
                        '2017-01-01',
                        style: TextStyle(color: Themes.mainText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
          // Container(
          //   height: 200,
          //   child: PageView(
          //     controller: _controller,
          //     onPageChanged: (position) {},
          //     children: data
          //         .map(
          //           (color) => Container(
          //             color: color,
          //           ),
          //         )
          //         .toList(),
          //   ),
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed("editor"),
        child: Icon(Icons.add, size: 40),
      ),
    );
  }
}
