import 'package:flutterwarehouseapp/common/constants/string_constants.dart';

class ValidatorUtils {
  static String _validatePhone = r'0\d{8,}';
  static RegExp _expPhoneNumber = RegExp(_validatePhone);

  static String validatePhoneNumber(String value) {
    if (value == null ||
        value.isEmpty ||
        !_expPhoneNumber.hasMatch(value) ||
        value.length > 10) {
      return StringConstants.errorInvalidPhoneNumber;
    }
    return null;
  }
}
