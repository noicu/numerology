import 'dart:math';

import 'package:flutter/material.dart';
import 'package:secret/secret.dart';
// import 'package:numerology/utils/solar_util.dart';
// import 'package:numerology/utils/lunar_util.dart';
import 'package:numerology/view/style/theme.dart';
import 'package:numerology/view/widgets/calendar/custom_calendar.dart';
// import 'package:numerology/view/widgets/calendar/utils/lunar_util.dart';
import 'package:numerology/view/widgets/chassis.dart';
import 'package:numerology/view/widgets/search_app_bar.dart';
// import 'package:numerology/utils/lunar_util.dart';

class MeinPage extends StatefulWidget {
  MeinPage({Key key}) : super(key: key);

  @override
  _MeinPageState createState() => _MeinPageState();
}

class _MeinPageState extends State<MeinPage> {
  ValueNotifier<String> text;
  ValueNotifier<DateModel> selectText;

  CalendarController controller;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    controller = new CalendarController(
      // minYear: now.year,
      // minYearMonth: now.month - 2,
      // maxYear: now.year,
      // maxYearMonth: now.month + 1,
      selectDateModel: DateModel.fromDateTime(DateTime.now()),
      showMode: CalendarConstants.MODE_SHOW_MONTH_AND_WEEK,
    );

    controller.addMonthChangeListener(
      (year, month) {
        text.value = "$year年$month月";
      },
    );

    controller.addOnCalendarSelectListener((dateModel) {
      //刷新选择的时间
      selectText.value = dateModel;
    });

    text = new ValueNotifier("${DateTime.now().year}年${DateTime.now().month}月");

    selectText = new ValueNotifier(DateModel.fromDateTime(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Text('sd'),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.navigate_before),
              onPressed: () {
                controller.previousPage();
              },
            ),
            ValueListenableBuilder(
              valueListenable: text,
              builder: (context, value, child) {
                return Text(text.value);
              },
            ),
            IconButton(
              icon: Icon(Icons.navigate_next),
              onPressed: () {
                controller.nextPage();
              },
            ),
          ],
        ),
        backgroundColor: Themes.backgroundH,
      ),
      backgroundColor: Themes.backgroundB,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          CalendarViewWidget(
            calendarController: controller,
            weekBarItemWidgetBuilder: () {
              return CustomStyleWeekBarItem();
            },
            dayWidgetBuilder: (dateModel) {
              return CustomStyleDayWidget(dateModel);
            },
          ),
          ValueListenableBuilder(
            valueListenable: selectText,
            builder: (context, value, child) {
              print(value);
              return Chassis(
                leading: Text(
                  '${selectText.value}',
                  style: TextStyle(color: Themes.mainText),
                ),
                suffix: Text(
                  '择吉',
                  style: TextStyle(color: Themes.mainText),
                ),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      // Text(
                      //   '${LunarUtil.numToChineseMonth(selectText.value.lunar[1], selectText.value.lunar[3])}${LunarUtil.numToChinese(selectText.value.lunar[1], selectText.value.lunar[2], selectText.value.lunar[3])}',
                      //   style: TextStyle(color: Themes.mainText),
                      // ),
                      // Text(
                      //   '${LunarUtil.numToChineseMonth(selectText.value.lunar[1], selectText.value.lunar[3])}${LunarUtil.numToChinese(selectText.value.lunar[1], selectText.value.lunar[2], selectText.value.lunar[3])}',
                      //   style: TextStyle(color: Themes.mainText),
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

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

class CustomStyleDayWidget extends BaseCustomDayWidget {
  CustomStyleDayWidget(DateModel dateModel) : super(dateModel);

  @override
  void drawNormal(DateModel dateModel, Canvas canvas, Size size) {
    if (!dateModel.isCurrentMonth) return;
    bool isWeekend = dateModel.isWeekend;
    bool isInRange = dateModel.isInRange;

    //顶部的文字
    TextPainter dayTextPainter = new TextPainter()
      ..text = TextSpan(
        text: dateModel.day.toString(),
        style: new TextStyle(
          color: !isInRange
              ? Colors.grey
              : isWeekend ? Themes.red : Themes.mainText,
          fontSize: 16,
        ),
      )
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center;

    dayTextPainter.layout(minWidth: size.width, maxWidth: size.width);
    dayTextPainter.paint(canvas, Offset(0, 10));

    //下面的文字
    TextPainter lunarTextPainter = new TextPainter()
      ..text = new TextSpan(
        text: dateModel.lunarString,
        style: new TextStyle(
            color: !isInRange
                ? Colors.grey
                : isWeekend ? Themes.red : Themes.secondary,
            fontSize: 12),
      )
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center;

    lunarTextPainter.layout(minWidth: size.width, maxWidth: size.width);
    lunarTextPainter.paint(canvas, Offset(0, size.height / 2));
  }

  pr(String name, dynamic obj) {
    print('$name------$obj');
  }

  @override
  void drawSelected(DateModel dateModel, Canvas canvas, Size size) {
    if (!dateModel.isCurrentMonth) {
      return;
    }
    // print(SolarUtil.getWeeksOfMonth(2020,7,1));
    // print(LunarUtils.YI_JI[0]);
    // print(LunarUtils.hex(9));
    Lunar d = Lunar(DateTime.now());
    // pr('sad', d);
    pr('公历', '${d.getSolar()}');
    pr('农历',
        '${d.getYearInChinese()}-${d.getMonthInChinese()}-${d.getDayInChinese()}');
    pr('吉神宜趋', d.getDayJiShen());
    pr('凶煞宜忌', d.getDayXiongSha());

    pr('宜', d.getDayYi());
    // pr('忌', d.getDayJi());
    // pr('节日', d.getFestivals());
    // pr('非正式节日', d.getOtherFestivals());
    // pr('干支纪年', d.getYearInGanZhi());
    // pr('阴历年的天干', d.getYearGan());
    // pr('阴历年的地支', d.getYearZhi());
    // pr('干支纪月', d.getMonthInGanZhi());
    // pr('阴历月的天干', d.getMonthGan());
    // pr('阴历月的天干', d.getMonthZhi());
    // pr('阴历月的天干', d.getDayGan());
    // pr('阴历月的天干', d.getDayZhi());
    // pr('阴历月的天干', d.getYearInGanZhiByLiChun());
    // pr('阴历月的天干', d.getYearGanByLiChun());
    // pr('阴历月的天干', d.getYearZhiByLiChun());
    // pr('阴历月的天干', d.getYearInGanZhiExact());
    // pr('阴历月的天干', d.getYearGanExact());
    // pr('阴历月的天干', d.getYearZhiExact());
    // pr('阴历月的天干', d.getMonthInGanZhiExact());
    // pr('阴历月的天干', d.getMonthGanExact());
    // pr('阴历月的天干', d.getDayInGanZhiExact());
    // pr('阴历月的天干', d.getDayGanExact());
    // pr('阴历月的天干', d.getDayZhiExact());
    // pr('阴历月的天干', d.getMonthGanExact());
    //绘制背景
    var width = size.width;
    var height = size.height;
    var bw = size.width - 5; // 背景宽度
    var bh = size.height - 5; // 背景高度
    double elevation = 10;
    const PI = 3.1415926;
    const ANGLE = PI / 180 * (65); //调整旋转度数
    var center = Offset(width / 2, height / 2);

    var c1 = Offset(
      center.dx - (bw / 4 * cos(ANGLE)),
      center.dy - (bh / 4 * sin(ANGLE)),
    );
    var c2 = Offset(
      center.dx - (bw / 4 * cos(ANGLE + PI)),
      center.dy - (bh / 4 * sin(ANGLE + PI)),
    );

    var c1c = Paint()
      ..color = Color(0xFF473D44)
      ..style = PaintingStyle.fill;
    var c2c = Paint()
      ..color = Color(0xFFC5B8C2)
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..addArc(
        Rect.fromCenter(
          center: center,
          width: bw,
          height: bh,
        ).translate(0, 0 - elevation),
        0,
        2 * PI,
      );
    canvas.drawShadow(path, Color(0xFFB8818F), elevation, true);

    // 阴大半圆
    canvas.drawArc(
      Rect.fromCenter(
        center: center,
        width: bw,
        height: bh,
      ),
      ANGLE, // 起始角度
      PI, // 扇面
      true, // 居中
      c1c,
    );
    // 阳大半圆
    canvas.drawArc(
      Rect.fromCenter(
        center: center,
        width: bw,
        height: bh,
      ),
      PI + ANGLE, // 起始角度
      PI, // 扇面
      true, // 居中
      c2c,
    );

    // 阳小半圆
    canvas.drawArc(
      Rect.fromCenter(
        center: c1,
        width: bw / 2,
        height: bh / 2,
      ),
      0, // 起始角度
      2 * PI, // 扇���
      true, // 居中
      c2c,
    );

    // 阴小半圆
    canvas.drawArc(
      Rect.fromCenter(
        center: c2,
        width: bw / 2,
        height: bh / 2,
      ),
      0, // 起始角度
      2 * PI, // 扇面
      true, // 居中
      c1c,
    );

    //顶部的文字
    TextPainter dayTextPainter = new TextPainter()
      ..text = TextSpan(
          text: dateModel.day.toString(),
          style: new TextStyle(color: Colors.black, fontSize: 20))
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center;

    dayTextPainter.layout(minWidth: width, maxWidth: width);
    dayTextPainter.paint(canvas, Offset(0, height / 4 - 20 / 2));

    //下面的文字
    TextPainter lunarTextPainter = new TextPainter()
      ..text = new TextSpan(
          text: dateModel.lunarString,
          style: new TextStyle(color: Colors.white, fontSize: 12))
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center;

    lunarTextPainter.layout(minWidth: width, maxWidth: width);
    lunarTextPainter.paint(
        canvas, Offset(0, (height - height / 4) - height / 6));
  }
}

/// ----------------------------------------------
// for (var i = 0; i < 20; i++) {
//   canvas.drawArc(
//     Rect.fromCenter(
//       center: Offset(
//         width / 2 - (width / 4 * cos(PI / 10 * i)),
//         height / 2 - (height / 4 * sin(PI / 10 * i)),
//       ),
//       width: 5,
//       height: 5,
//     ),
//     0, // 起始角度 0度
//     2 * PI, // 扇面 180度
//     true, // 居中
//     Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.fill,
//   );

//   canvas.drawArc(
//     Rect.fromCenter(
//       center: Offset(
//         width / 2 - (width / 4 * cos(PI / 10 * i)),
//         width / 2 - (height / 4 * sin(PI / 10 * i)),
//       ),
//       width: 5,
//       height: 5,
//     ),
//     0, // 起始角度 0度
//     2 * PI, // 扇�� 180度
//     true, // 居中
//     Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.fill,
//   );
// }

// 中心点
// canvas.drawArc(
//   Rect.fromCenter(
//     center: center,
//     width: 5,
//     height: 5,
//   ),
//   0, // 起始角度 0度
//   2 * PI, // 扇面 180度
//   true, // 居中
//   Paint()
//     ..color = Colors.black
//     ..style = PaintingStyle.fill,
// );

// canvas.drawArc(
//   Rect.fromCenter(
//     center: c1,
//     width: 5,
//     height: 5,
//   ),
//   0, // 起始角度 0度
//   2 * PI, // 扇面 180度
//   true, // 居中
//   Paint()
//     ..color = Colors.black
//     ..style = PaintingStyle.fill,
// );

// canvas.drawArc(
//   Rect.fromCenter(
//     center: c2,
//     width: 5,
//     height: 5,
//   ),
//   0, // 起始角度 0度
//   2 * PI, // 扇面 180度
//   true, // 居中
//   Paint()
//     ..color = Colors.black
//     ..style = PaintingStyle.fill,
// );
