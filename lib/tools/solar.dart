import 'package:numerology/tools/lunar.dart';
import 'package:numerology/utils/solar_util.dart';

/// 阳历日期
class Solar {
  /** 2000年儒略日数(2000-1-1 12:00:00 UTC) */
  static final double J2000 = 2451545;
  /** 年 */
  int year;
  /** 月 */
  int month;
  /** 日 */
  int day;
  /** 时 */
  int hour;
  /** 分 */
  int minute;
  /** 秒 */
  int second;
  /** 日历 */
  DateTime calendar;

  // /**
  //  * 默认使用当前日期初始化
  //  */
  // Solar(){
  //   this(new Date());
  // }

  /**
   * 通过年月日初始化
   *
   * @param year 年
   * @param month 月，1到12
   * @param day 日，1到31
   */
  Solar.fromYmd(int year, int month, int day) {
    fromYmdHmsSolar(year, month, day, 0, 0, 0);
  }

  /**
   * 通过年月日初始化
   *
   * @param year 年
   * @param month 月，1到12
   * @param day 日，1到31
   * @param hour 小时，0到23
   * @param minute 分钟，0到59
   * @param second 秒钟，0到59
   */
  Solar.fromYmdHms(
      int year, int month, int day, int hour, int minute, int second) {
    calendar = DateTime(year, month - 1, day, hour, minute, second);
    this.year = year;
    this.month = month;
    this.day = day;
    this.hour = hour;
    this.minute = minute;
    this.second = second;
  }

  /// 通过日期初始化
  ///
  /// @param date 日期
  Solar([DateTime date]) {
    calendar = date ?? DateTime.now();
    year = calendar.year;
    month = calendar.month + 1;
    day = calendar.day;
    hour = calendar.hour;
    minute = calendar.minute;
    second = calendar.second;
  }

  /**
   * 通过儒略日初始化
   * @param julianDay 儒略日
   */
  Solar.julianDay(double julianDay) {
    julianDay += 0.5;

    // 日数的整数部份
    double a = int2(julianDay);
    // 日数的小数部分
    double f = julianDay - a;
    double jd;

    if (a > 2299161) {
      jd = int2((a - 1867216.25) / 36524.25);
      a += 1 + jd - int2(jd / 4);
    }
    // 向前移4年零2个月
    a += 1524;
    double y = int2((a - 122.1) / 365.25);
    // 去除整年日数后余下日数
    jd = a - int2(365.25 * y);
    double m = int2(jd / 30.6001);
    // 去除整月日数后余下日数
    double d = int2(jd - int2(m * 30.6001));
    y -= 4716;
    m--;
    if (m > 12) {
      m -= 12;
    }
    if (m <= 2) {
      y++;
    }

    // 日的小数转为时分秒
    f *= 24;
    double h = int2(f);

    f -= h;
    f *= 60;
    double mi = int2(f);

    f -= mi;
    f *= 60;
    double s = int2(f);

    calendar = DateTime(
        y as int, (m - 1) as int, d as int, h as int, mi as int, s as int);
    year = calendar.year;
    month = calendar.month + 1;
    day = calendar.day;
    hour = calendar.hour;
    minute = calendar.minute;
    second = calendar.second;
  }

  /**
   * 通过指定日期获取阳历
   *
   * @param date 日期
   * @return 阳历
   */
  static Solar fromDate(DateTime date) {
    return new Solar(date);
  }

  // /**
  //  * 通过指定日历获取阳历
  //  *
  //  * @param calendar 日历
  //  * @return 阳历
  //  */
  // static Solar fromCalendar(Calendar calendar){
  //   return new Solar(calendar);
  // }

  /**
   * 通过指定儒略日获取阳历
   *
   * @param julianDay 儒略日
   * @return 阳历
   */
  static Solar fromJulianDay(double julianDay) {
    return new Solar.julianDay(julianDay);
  }

  /**
   * 通过指定年月日获取阳历
   *
   * @param year 年
   * @param month 月，1到12
   * @param day 日，1到31
   * @return 阳历
   */
  static Solar fromYmdSolar(int year, int month, int day) {
    return new Solar.fromYmd(year, month, day);
  }

  /**
   * 通过指定年月日时分获取阳历
   *
   * @param year 年
   * @param month 月，1到12
   * @param day 日，1到31
   * @param hour 小时，0到23
   * @param minute 分钟，0到59
   * @param second 秒钟，0到59
   * @return 阳历
   */
  static Solar fromYmdHmsSolar(
      int year, int month, int day, int hour, int minute, int second) {
    return new Solar.fromYmdHms(year, month, day, hour, minute, second);
  }

  /**
   * 是否闰年
   *
   * @return true/false 闰年/非闰年
   */
  bool isLeapYear() {
    return SolarUtil.isLeapYear(year);
  }

  /**
   * 获取星期，0代表周日，1代表周一
   *
   * @return 0123456
   */
  int getWeek() {
    return calendar.weekday - 1;
  }

  /**
   * 获取星期的中文
   *
   * @return 日一二三四五六
   */
  String getWeekInChinese() {
    return SolarUtil.WEEK[getWeek()];
  }

  /**
   * 获取节日，有可能一天会有多个节日
   *
   * @return 劳动节等
   */
  List<String> getFestivals() {
    List<String> l = new List<String>();
    //获取几月几日对应的节日
    String f = SolarUtil.FESTIVAL['$month-$day'];
    if (null != f) {
      l.add(f);
    }
    //计算几月第几个星期几对应的节日
    //第几周
    int weekInMonth = ((day - getWeek()) / 7).ceil();
    //星期几，0代表星期天
    int week = getWeek();
    //星期天很奇葩，会多算一周，需要减掉
    if (0 == week) {
      weekInMonth--;
    }
    f = SolarUtil.WEEK_FESTIVAL['$month-$weekInMonth-$week'];
    if (null != f) {
      l.add(f);
    }
    return l;
  }

  /**
   * 获取非正式的节日，有可能一天会有多个节日
   *
   * @return 非正式的节日列表，如中元节
   */
  List<String> getOtherFestivals() {
    List<String> l = new List<String>();
    List<String> fs = SolarUtil.OTHER_FESTIVAL['$month-$day'];
    if (null != fs) {
      l.addAll(fs);
    }
    return l;
  }

  /**
   * 获取星座
   *
   * @return 星座
   * @deprecated 使用getXingZuo
   */
  String getXingzuo() {
    return getXingZuo();
  }

  /**
   * 获取星座
   *
   * @return 星座
   */
  String getXingZuo() {
    int index = 11, m = month, d = day;
    int y = m * 100 + d;
    if (y >= 321 && y <= 419) {
      index = 0;
    } else if (y >= 420 && y <= 520) {
      index = 1;
    } else if (y >= 521 && y <= 620) {
      index = 2;
    } else if (y >= 621 && y <= 722) {
      index = 3;
    } else if (y >= 723 && y <= 822) {
      index = 4;
    } else if (y >= 823 && y <= 922) {
      index = 5;
    } else if (y >= 923 && y <= 1022) {
      index = 6;
    } else if (y >= 1023 && y <= 1121) {
      index = 7;
    } else if (y >= 1122 && y <= 1221) {
      index = 8;
    } else if (y >= 1222 || y <= 119) {
      index = 9;
    } else if (y <= 218) {
      index = 10;
    }
    return SolarUtil.XINGZUO[index];
  }

  /**
   * 获取年份
   *
   * @return 如2015
   */
  int getYear() {
    return year;
  }

  /**
   * 获取月份
   *
   * @return 1到12
   */
  int getMonth() {
    return month;
  }

  /**
   * 获取日期
   *
   * @return 1到31之间的数字
   */
  int getDay() {
    return day;
  }

  /**
   * 获取小时
   *
   * @return 0到23之间的数字
   */
  int getHour() {
    return hour;
  }

  /**
   * 获取分钟
   *
   * @return 0到59之间的数字
   */
  int getMinute() {
    return minute;
  }

  /**
   * 获取秒钟
   *
   * @return 0到59之间的数字
   */
  int getSecond() {
    return second;
  }

  /**
   * 获取农历
   * @return 农历
   */
  Lunar getLunar() {
    return new Lunar(calendar);
  }

  double int2(double v) {
    var n = v.floor();
    return (n < 0 ? n + 1 : n).toDouble();
  }

  /**
   * 获取儒略日
   * @return 儒略日
   */
  double getJulianDay() {
    double y = year as double;
    double m = month as double;
    double n = 0;

    if (m <= 2) {
      m += 12;
      y--;
    }

    // 判断是否为UTC日1582*372+10*31+15
    if (this.year * 372 + this.month * 31 + this.day >= 588829) {
      n = int2(y / 100);
      // 加百年闰
      n = 2 - n + int2(n / 4);
    }

    // 加上年引起的偏移日数
    n += int2(365.2500001 * (y + 4716));
    // 加上月引起的偏移日数及日偏移数
    n += int2(30.6 * (m + 1)) + this.day;
    n += ((this.second * 0x1D / 60 + this.minute) / 60 + this.hour) / 24 -
        1524.5;
    return n;
  }

  /**
   * 获取日历
   *
   * @return 日历
   */
  DateTime getCalendar() {
    return calendar;
  }

  @override
  String toString() {
    return toYmd();
  }

  String toYmd() {
    return '$year-${(month < 10 ? "0" : "")}$month-${(day < 10 ? "0" : "")}$day';
  }

  String toYmdHms() {
    return '${toYmd()} ${(hour < 10 ? "0" : "")}$hour:${(minute < 10 ? "0" : "")}$minute:${(second < 10 ? "0" : "")}$second';
  }

  String toFullString() {
    String s = toYmdHms();
    if (isLeapYear()) {
      s += ' 闰年';
    }
    s += ' 星期' + getWeekInChinese();
    var festivals = getFestivals();
    for (var i = 0, j = festivals.length; i < j; i++) {
      s += ' (' + festivals[i] + ')';
    }
    s += ' ' + getXingZuo() + '座';
    return s;
  }

  /**
   * 获取往后推几天的阳历日期，如果要往前推，则天数用负数
   * @param days 天数
   * @return 阳历日期
   */
  Solar next(int days) {
    DateTime c = DateTime(year, month - 1, day, hour, minute, second);
    c.add(Duration(days: days));
    return new Solar(c);
  }
}
