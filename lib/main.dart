import 'package:flutter/material.dart';
import 'package:numerology/view/almanac/almanac_page.dart';
import 'package:numerology/view/forum/editor_page.dart';
import 'package:numerology/view/forum/view_page.dart';
import 'package:numerology/view/home/home_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // fontFamily: 'wr',
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: {
        "/editor": (context) => EditorPage(),
        "/almanac": (context) => AlmanacPage(),
      },
    );
  }
}
