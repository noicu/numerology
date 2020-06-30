import 'package:flutter/material.dart';
import 'package:numerology/view/style/theme.dart';
import 'package:numerology/view/widgets/search_app_bar.dart';

class MallPage extends StatefulWidget {
  MallPage({Key key}) : super(key: key);

  @override
  _MallPageState createState() => _MallPageState();
}

class _MallPageState extends State<MallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBarWidget(
        backgroundColor: Themes.backgroundH,
        color: Themes.mainText,
      ),
      backgroundColor: Themes.backgroundB,
      body: ListView(
        children: <Widget>[],
      ),
      floatingActionButton: Container(
        child: Image.asset('assets/tool_icon/g.png', width: 60, height: 60),
      ),
    );
  }
}