import 'package:intl/intl.dart';

class DateUtils {
  static String formatYyyyMMdd(DateTime date) {
    return DateFormat('yyyy-MM-dd hh:mm').format(date);
  }
}