import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numerology/view/style/theme.dart';
import 'package:numerology/view/widgets/calendar/custom_calendar.dart';
import 'package:numerology/view/widgets/search_app_bar.dart';

class MeinPage extends StatefulWidget {
  MeinPage({Key key}) : super(key: key);

  @override
  _MeinPageState createState() => _MeinPageState();
}

class _MeinPageState extends State<MeinPage> {
  ValueNotifier<String> text;
  ValueNotifier<String> selectText;

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
      showMode: CalendarConstants.MODE_SHOW_MONTH_AND_WEEK,
    );

    controller.addMonthChangeListener(
      (year, month) {
        text.value = "$year年$month月";
      },
    );

    controller.addOnCalendarSelectListener((dateModel) {
      //刷新选择的时间
      selectText.value =
          "单选模式\n选中的时间:\n${controller.getSingleSelectCalendar()}";
    });

    text = new ValueNotifier("${DateTime.now().year}年${DateTime.now().month}月");

    selectText = new ValueNotifier(
        "单选模式\n选中的时间:\n${controller.getSingleSelectCalendar()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBarWidget(
        backgroundColor: Themes.backgroundH,
        color: Themes.mainText,
      ),
      backgroundColor: Themes.backgroundB,
      body: ListView(
        children: <Widget>[
          Row(
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
              return Text(selectText.value);
            },
          ),
        ],
      ),
    );
  }
}

class CustomStyleWeekBarItem extends BaseWeekBar {
  final List<String> weekList = ["一", "二", "三", "四", "五", "六", "日"];

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
    if (!dateModel.isCurrentMonth) {
      return;
    }
    bool isWeekend = dateModel.isWeekend;
    bool isInRange = dateModel.isInRange;

    // print(isInRange);

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

  @override
  void drawSelected(DateModel dateModel, Canvas canvas, Size size) {
    if (!dateModel.isCurrentMonth) {
      return;
    }
    const PI = 3.1415926;
    //绘制背景

    canvas.rotate(0);

    /// 根据椭圆半径a和b，求一个角度theta对应弧上点的位置(x,y)
    /// y=b*sin(theta)
    /// x=a*cos(theta)

    print(size.width);
    print(size.height);

    print((size.height / 2) * sin(2 * PI / 8));
    print((size.width / 2) * cos(2 * PI / 8));

    canvas.drawArc(
      Rect.fromPoints(Offset(5, 5), Offset(size.width - 5, size.height - 5)),
      1,
      PI,
      true,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.fill,
    );

    canvas.drawArc(
      Rect.fromPoints(Offset(5, 5), Offset(size.width - 5, size.height - 5)),
      PI + 1,
      PI,
      true,
      Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill,
    );

    canvas.drawCircle(
      Offset(size.width / 4 + 2.5, size.height / 2),
      size.width / 4 - 2.5,
      Paint()
        ..color = Colors.red
        ..strokeWidth = 2,
    );
    canvas.drawCircle(
      Offset(size.width - size.width / 4 - 2.5 - PI * 0.5,
          size.height / 2 + PI * 1),
      size.width / 4 - 2.5,
      Paint()
        ..color = Colors.black
        ..strokeWidth = 2,
    );

    canvas.restore();
    canvas.save();
    //顶部的文字
    TextPainter dayTextPainter = new TextPainter()
      ..text = TextSpan(
          text: dateModel.day.toString(),
          style: new TextStyle(color: Colors.white, fontSize: 16))
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center;

    dayTextPainter.layout(minWidth: size.width, maxWidth: size.width);
    dayTextPainter.paint(canvas, Offset(0, 10));

    //下面的文字
    TextPainter lunarTextPainter = new TextPainter()
      ..text = new TextSpan(
          text: dateModel.lunarString,
          style: new TextStyle(color: Colors.white, fontSize: 12))
      ..textDirection = TextDirection.ltr
      ..textAlign = TextAlign.center;

    lunarTextPainter.layout(minWidth: size.width, maxWidth: size.width);
    lunarTextPainter.paint(canvas, Offset(0, size.height / 2));
  }
}
