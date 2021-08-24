import 'package:flutterwarehouseapp/common/constants/string_constants.dart';
import 'package:flutterwarehouseapp/common/enums/bill_enum.dart';

class BillUtils {
  static convertToString(BillEnum type) {
    switch(type) {
      case BillEnum.Import:
        return StringConstants.importTxt;
      case BillEnum.Export:
        return StringConstants.exportTxt;
    }
  }
}