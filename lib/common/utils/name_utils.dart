import 'dart:developer';

import 'package:flutterwarehouseapp/common/extensions/string_extensions.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';

class NameUtils {
  static String getFirstName(String fullName) {
    if (!ValidatorUtils.isNullEmpty(fullName)) {
      List<String> nameArr = fullName.split(' ');
      String lastName = nameArr.last;
      String firstName = fullName.replaceAll(lastName, '').trim();
      return firstName;
    }
    return '';
  }

  static String getLastName(String fullName) {
    if (!ValidatorUtils.isNullEmpty(fullName)) {
      List<String> nameArr = fullName.split(' ');
      return nameArr.last;
    }
    return '';
  }

  static String getSortName(String fullName) {
    String firstName = getFirstName(fullName);
    String lastName = getLastName(fullName);
    if (firstName.isNotSafe && lastName.isNotSafe) {
      return '';
    }
    if (firstName.isNotSafe) {
      return '${lastName[0].toUpperCase()}';
    }
    if (lastName.isNotSafe) {
      return '${firstName[0].toUpperCase()}';
    }
    return '${firstName[0].toUpperCase()}${lastName[0].toUpperCase()}';
  }
}
