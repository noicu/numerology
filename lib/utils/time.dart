import 'package:intl/intl.dart';

class UtilTime {
  static List<int> dateD(DateTime date, DateTime date2) {
    Duration di = date.difference(date2);
    return [di.inDays, di.inHours, di.inMinutes, di.inSeconds];
  }

  /// howLong([DateTime.parse('2018-10-10 09:30:36')])
  static howLong(DateTime date, {DateTime date2}) {
    List<String> sl = ['天', '小时', '分钟', '刚刚'];
    List<int> dl = dateD(date2 ?? new DateTime.now(), date);
    for (var i = 0; i < dl.length; i++)
      if (dl[i] != 0) return i != 3 ? '${dl[i]}${sl[i]}前' : sl[i];
    return '刚刚';
  }

  /// difDate([DateTime.parse('2018-10-10 09:30:36')])
  static String difDate(DateTime date, DateTime date2) {
    if (date2 == null) return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    List<int> dn = dateD(new DateTime.now(), date);
    List<int> di = dateD(date, date2);
    if (dn[0] > 0 || di[0] > 0) {
      if (di[2] > 2) return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
      return '';
    } else {
      if (di[2] > 2) return DateFormat('HH:mm:ss').format(date);
      return '';
    }
  }
}
