import 'package:flutter/material.dart';
import 'package:numerology/view/almanac/almanac_page.dart';
import 'package:numerology/view/forum/editor_page.dart';
import 'package:numerology/view/login/login_page.dart';

final Map<String, WidgetBuilder> routes = {
  "editor": (context) => EditorPage(),
  "almanac": (context) => AlmanacPage(),
  "login": (context) => LoginPage(),
//  "mqDemo": (BuildContext context) => new MqDemo(),
};
