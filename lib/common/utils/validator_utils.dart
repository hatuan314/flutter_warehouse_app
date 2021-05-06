import 'package:flutterwarehouseapp/common/constants/string_constants.dart';

class ValidatorUtils {
  static String _validatePhone = r'0\d{8,}';
  static String _validateEmail =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp _expPhoneNumber = RegExp(_validatePhone);
  static RegExp _expEmail = RegExp(_validateEmail);

  static String validatePhoneNumber(String value) {
    if (value == null ||
        value.isEmpty ||
        !_expPhoneNumber.hasMatch(value) ||
        value.length > 10) {
      return StringConstants.errorInvalidPhoneNumber;
    }
    return null;
  }

  static String validateEmail(String value) {
    if (value == null ||
        value.isEmpty ||
        !_expEmail.hasMatch(value)) {
      return StringConstants.errorInvalidEmail;
    }
    return null;
  }


}
