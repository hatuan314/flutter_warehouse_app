import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:intl/intl.dart';

class CurrencyUtils {
  static cleanPriceText(String price, String symbol) {
    if (!ValidatorUtils.isNullEmpty(price)) {
      String cleanPrice = price.replaceAll('.', '');
      cleanPrice = cleanPrice.replaceAll(symbol, '');
      return cleanPrice;
    }
    return '';
  }

  static convertFormatMoney(int value, String locator) {
    if (!ValidatorUtils.isNullEmpty(value)) {
      final oCcy = NumberFormat.currency(locale: locator,symbol: '₫');
      return oCcy.format(value);
    }
    return '';
  }
}