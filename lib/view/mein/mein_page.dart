import 'package:flutter/material.dart';
import 'package:numerology/view/style/theme.dart';
import 'package:numerology/view/widgets/search_app_bar.dart';

class MeinPage extends StatefulWidget {
  MeinPage({Key key}) : super(key: key);

  @override
  _MeinPageState createState() => _MeinPageState();
}

class _MeinPageState extends State<MeinPage> {
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
    );
  }
}
