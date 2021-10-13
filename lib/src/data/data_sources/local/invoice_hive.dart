import 'package:flutterwarehouseapp/common/configs/local_db_setup.dart';
import 'package:flutterwarehouseapp/common/locator/service_locator.dart';
import 'package:flutterwarehouseapp/common/utils/validator_utils.dart';
import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/bloc.dart';
import 'package:flutterwarehouseapp/src/presentation/blocs/snackbar_bloc/snackbar_type.dart';
import 'package:hive/hive.dart';

class InvoiceHive {
  final LocalDbSetup database;

  InvoiceHive(this.database);

  Future<int> setInvoice(BillEntity bill) async {
    try {
      int key = await database.billBox.add(bill);
      return key;
    } on HiveError catch (e) {
      locator<SnackbarBloc>().add(ShowSnackbar(
          title: e.toString(), type: SnackBarType.error));
      return null;
    }
  }

  Future<bool> setBillList(
      List<BillEntity> billList) async {
    try {
      List<int> keys =
      List<int>.from(await database.billBox.addAll(billList));
      return !ValidatorUtils.isNullEmptyList(keys);
    } on HiveError catch (e) {
      locator<SnackbarBloc>().add(ShowSnackbar(
          title: e.toString(), type: SnackBarType.error));
      return false;
    }
  }

  Future<List<BillEntity>> getAllBills() async {
    List<BillEntity> bills = [];
    if (database.billBox.isNotEmpty) {
      bills.addAll(database.billBox.values.toList());
    }
    return bills;
  }

  Future<void> removeDistributor(int index) async {
    await database.billBox.deleteAt(index);
  }

  Future<void> updateDistributor(
      {int index, BillEntity bill}) async {
    await database.billBox.putAt(index, bill);
  }

  List<BillEntity> getExpectBill() {
    List<BillEntity> bills = [];
    if (database.billBox.isNotEmpty) {
      bills = database.billBox.values.where((bill) {
        if (bill.type == 'EXPORT') {
          return true;
        }
        return false;
      }).toList();
    }
    return bills;
  }

  List<BillEntity> getImportBill() {
    List<BillEntity> bills = [];
    if (database.billBox.isNotEmpty) {
      bills = database.billBox.values.where((bill) {
        if (bill.type == 'IMPORT') {
          return true;
        }
        return false;
      }).toList();
    }
    return bills;
  }
}