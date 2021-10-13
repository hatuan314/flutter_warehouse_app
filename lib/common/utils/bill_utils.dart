import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
import 'package:flutterwarehouseapp/common/constants/string_constants.dart';

class BillUtils {
  static convertToString(BillEnum type) {
    switch(type) {
      case BillEnum.Import:
        return StringConstants.importTxt;
      case BillEnum.Export:
        return StringConstants.exportTxt;
    }
  }

  static convertToKey(BillEnum type) {
    switch(type) {
      case BillEnum.Import:
        return 'IMPORT';
      case BillEnum.Export:
        return 'EXPORT';
    }
  }
}