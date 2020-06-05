import 'package:intl/intl.dart';

class DateConvert {
  static int dateTimeConvertToMilliseconds(DateTime date) =>
      date.millisecondsSinceEpoch;

  static String dateTimeConvertToDateFormat(DateTime date) {
    print('dateTimeConvertToDateFormat - ${DateFormat('dd/MM/yyyy').format(date)}');
    print('dateTimeConvertToDateFormat - $date');
    return DateFormat('dd/MM/yyyy').format(date);
  }


  static String millisecondsConvertToDateFormat(int milliseconds) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    return dateTimeConvertToDateFormat(dateTime);
  }
}
