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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editor page"), actions: [
        FlatButton(
          child: Text("查看数据"),
          onPressed: () {
            print(json.encode(widget.document));
          },
        )
      ]),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: ZefyrView(
              document: widget.document,
            ),
          ),
          Chassis(
            leading: Text(
              '评论',
              style: TextStyle(color: Themes.mainText),
            ),
            child: Container(
              child: Row(
                children: <Widget>[
                  Avatar(''),
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
                              '点赞',
                              style: TextStyle(color: Themes.mainText),
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
            ),
          ),
        ],
      ),
    );
  }
}
