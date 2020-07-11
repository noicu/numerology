import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:numerology/view/style/theme.dart';
import 'package:numerology/view/widgets/avatar.dart';
import 'package:numerology/view/widgets/chassis.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class ViewPage extends StatefulWidget {
  final NotusDocument document;
  final ZefyrImageDelegate imageDelegate;

  const ViewPage({Key key, @required this.document, this.imageDelegate});
  @override
  ViewPageState createState() => ViewPageState();
}

class ViewPageState extends State<ViewPage> {
  ScrollController _controller = ScrollController();
  bool scrollTop = false;
  double scrollOffset = 0;
  @override
  void initState() {
    _controller.addListener(() {
      if (!scrollTop && _controller.offset >= 100) {
        setState(() => scrollTop = true);
        print(_controller.offset);
      }
      if (scrollTop && _controller.offset < 100) {
        setState(() => scrollTop = false);
        print(_controller.offset);
      }
      // scrollTop = _controller.offset <= scrollOffset;
      scrollOffset = _controller.offset;
      // print(_controller.offset);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.backgroundB,
      appBar: AppBar(
        title: Text("Editor page"),
        actions: [
          FlatButton(
            child: Text("查看数据"),
            onPressed: () {
              print(json.encode(widget.document));
            },
          )
        ],
      ),
      floatingActionButton: scrollTop
          ? Container(
              margin: EdgeInsets.only(bottom: 50),
              child: FloatingActionButton(
                onPressed: () => _controller.animateTo(
                  0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutSine,
                ),
                child: Icon(Icons.arrow_drop_up),
              ),
            )
          : null,
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              controller: _controller,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Avatar(''),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '作者',
                                  // style: TextStyle(color: Themes.mainText),
                                ),
                                Text(
                                  '关注',
                                  // style: TextStyle(color: Themes.mainText),
                                ),
                              ],
                            ),
                            Text(
                              '2020-07-07',
                              // style: TextStyle(color: Themes.mainText),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 0),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: ZefyrView(
                    document: widget.document,
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(2),
                        margin: EdgeInsets.only(right: 10),
                        decoration: new BoxDecoration(
                          color: Themes.mainText,
                          borderRadius: BorderRadius.circular(4), // 也可控件一边圆角大小
                        ),
                        child: Text(
                          '周易',
                          style: TextStyle(
                            fontSize: 12,
                            color: Themes.backgroundB,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          IconButton(
                            icon: new Icon(Icons.timeline),
                            tooltip: '分享',
                            onPressed: () {
                              // ...
                            },
                          ),
                          Text('分享'),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            icon: new Icon(Icons.star),
                            tooltip: '收藏',
                            onPressed: () {
                              // ...
                            },
                          ),
                          Text('收藏'),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            icon: new Icon(Icons.thumb_up),
                            tooltip: '点赞',
                            onPressed: () {
                              // ...
                            },
                          ),
                          Text('赞'),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            icon: new Icon(Icons.thumb_down),
                            tooltip: '踩',
                            onPressed: () {
                              // ...
                            },
                          ),
                          Text('踩'),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(height: 0),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '在阳间烧什么样式的冥币，到了阴间才能真正流通？',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Card(
                        elevation: 1,
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          'https://oimagea3.ydstatic.com/image?id=-547459960413366617&product=adpublish&w=520&h=347',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '广告·道友请留步APP·立即下载',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Icon(Icons.clear),
                        ],
                      ),
                    ],
                  ),
                ),
                Chassis(
                  leading: Text(
                    '评论',
                    style: TextStyle(color: Themes.mainText),
                  ),
                  child: Container(
                    constraints: BoxConstraints(minHeight: 300),
                    child: Column(
                      children: <Widget>[
                        Row(
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'asd',
                                        style:
                                            TextStyle(color: Themes.mainText),
                                      ),
                                      Text(
                                        '点赞',
                                        style:
                                            TextStyle(color: Themes.mainText),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'asd000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeee',
                                    style: TextStyle(color: Themes.mainText),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: Themes.backgroundH,
            child: SafeArea(
              child: GestureDetector(
                child: Container(
                  width: double.infinity,
                  child: Text('asd'),
                ),
                onPanDown: (detail) {
                  // down1 = detail.globalPosition; //对外抛出点击位置
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
