import 'package:flutter/material.dart';
import 'package:numerology/view/style/theme.dart';
import 'package:numerology/view/widgets/calendar/custom_calendar.dart';

class CustomStyleWeekBarItem extends BaseWeekBar {
  final List<String> weekList = ["周一", "周二", "周三", "周四", "周五", "周六", "周日"];

  @override
  Widget getWeekBarItem(int index) {
    return new Container(
      decoration: new BoxDecoration(
        color: index > 4 ? Themes.red : Themes.mainText,
        borderRadius: BorderRadius.circular(4), // 也可控件一边圆角大小
      ),
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: new Center(
        child: new Text(
          weekList[index],
          style: TextStyle(
            color: Themes.backgroundB,
          ),
        ),
      ),
    );
  }
}