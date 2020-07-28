import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numerology/routes.dart';
import 'package:numerology/view/home/home_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    return MaterialApp(
      title: 'Numerology',
      theme: ThemeData(
        // fontFamily: 'wr',
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: HomePage(),
      ),
      routes: routes,
    );
  }
}
