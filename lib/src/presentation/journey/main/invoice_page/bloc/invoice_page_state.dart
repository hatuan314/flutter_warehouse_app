import 'package:equatable/equatable.dart';
import 'package:flutterwarehouseapp/src/domain/entities/bill_entity.dart';

abstract class InvoicePageState extends Equatable {}

class InitialInvoicePageState extends InvoicePageState {
  final List<BillEntity> exportBillList;
  final List<BillEntity> importBillList;

  InitialInvoicePageState({this.exportBillList, this.importBillList});

  InitialInvoicePageState copyWith({
    List<BillEntity> exportBillList,
    List<BillEntity> importBillList,
  }) =>
      InitialInvoicePageState(
          exportBillList: exportBillList ?? this.exportBillList, importBillList: importBillList ?? this.importBillList);

  @override
  List<Object> get props => [this.exportBillList, this.importBillList];
}

class LoadingInvoicePageState extends InvoicePageState {
  @override
  List<Object> get props => [];

}
