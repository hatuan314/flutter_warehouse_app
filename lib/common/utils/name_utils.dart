import 'dart:developer';

import 'package:flutterwarehouseapp/common/extensions/string_extensions.dart';

class NameUtils {
  static String getFirstName(String fullName) {
    List<String> nameArr = fullName.split(' ');
    String lastName = nameArr.last;
    String firstName = fullName.replaceAll(lastName, '').trim();
    return firstName;
  }

  static String getLastName(String fullName) {
    List<String> nameArr = fullName.split(' ');
    return nameArr.last;
  }

  static String getSortName(String fullName) {
    String firstName = getFirstName(fullName);
    String lastName = getLastName(fullName);
    if (firstName.isNotSafe) {
      return '${lastName[0].toUpperCase()}';
    }
    if (lastName.isNotSafe) {
      return '${firstName[0].toUpperCase()}';
    }
    return '${firstName[0].toUpperCase()}${lastName[0].toUpperCase()}';
  }
}
