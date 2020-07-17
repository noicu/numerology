import 'package:flutter/material.dart';
import 'package:numerology/view/almanac/custom_style_day_widget.dart';
import 'package:numerology/view/almanac/custom_style_week_barItem.dart';
import 'package:numerology/view/style/theme.dart';
import 'package:numerology/view/widgets/calendar/custom_calendar.dart';
import 'package:numerology/view/widgets/chassis.dart';
import 'package:secret/secret.dart';

class AlmanacPage extends StatefulWidget {
  AlmanacPage({Key key}) : super(key: key);

  @override
  _AlmanacPageState createState() => _AlmanacPageState();
}

class _AlmanacPageState extends State<AlmanacPage> {
  ValueNotifier<String> text;
  ValueNotifier<DateModel> selectText;

  CalendarController controller;
  Lunar lunar = Lunar(DateTime.now());

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    controller = new CalendarController(
      // minYear: now.year,
      // minYearMonth: now.month - 2,
      // maxYear: now.year,
      // maxYearMonth: now.month + 1,
      selectDateModel: DateModel.fromDateTime(now),
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
      print(dateModel.year);
      lunar = new Lunar.fromYmd(
          dateModel.lunar[0], dateModel.lunar[1], dateModel.lunar[2]);
      print(lunar);
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              controller.nextPage();
            },
          ),
        ],
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
                  '$lunar',
                  style: TextStyle(color: Themes.mainText),
                ),
                suffix: Text(
                  '择吉',
                  style: TextStyle(color: Themes.mainText),
                ),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        lunar.dayYi.join(','),
                        style: TextStyle(color: Themes.mainText),
                      ),
                      Text(
                        lunar.dayJi.join(','),
                        style: TextStyle(color: Themes.mainText),
                      ),
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
