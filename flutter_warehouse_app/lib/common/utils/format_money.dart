import 'package:intl/intl.dart';

String formatMoney(double money) {
  if (money != null) {
    final formatCurrency = new NumberFormat("#,###", "vi").format(money);
    return formatCurrency.toString();
  } else {
    return "0.0";
  }
}