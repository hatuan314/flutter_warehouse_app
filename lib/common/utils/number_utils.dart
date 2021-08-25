import 'package:intl/intl.dart';

class NumberUtils {
  static String convertNumber(int number, String locator) {
    return NumberFormat("###,###", locator).format(number);
  }
}