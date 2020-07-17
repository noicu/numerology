import 'package:flutter/material.dart';
import 'package:numerology/view/style/theme.dart';

class FtfPage extends StatefulWidget {
  FtfPage({Key key}) : super(key: key);

  @override
  _FtfPageState createState() => _FtfPageState();
}

class _FtfPageState extends State<FtfPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.backgroundB,
      appBar: AppBar(
        backgroundColor: Themes.backgroundH,
      ),
    );
  }
}
