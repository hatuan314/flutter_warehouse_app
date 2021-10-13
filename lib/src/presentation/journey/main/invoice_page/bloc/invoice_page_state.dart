import 'package:equatable/equatable.dart';
import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';

class InvoicePageState extends Equatable {
  final List<BillEntity> exportBillList;
  final List<BillEntity> importBillList;

  InvoicePageState({this.exportBillList, this.importBillList});

  InvoicePageState copyWith({
    List<BillEntity> exportBillList,
    List<BillEntity> importBillList,
  }) =>
      InvoicePageState(
          exportBillList: exportBillList ?? this.exportBillList, importBillList: importBillList ?? this.importBillList);

  @override
  List<Object> get props => [this.exportBillList, this.importBillList];
}
