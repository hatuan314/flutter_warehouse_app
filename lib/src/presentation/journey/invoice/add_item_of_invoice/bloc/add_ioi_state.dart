import 'package:equatable/equatable.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
abstract class AddIoiState extends Equatable {}

class WaitingAddIoiState extends AddIoiState {
  final String selectUnit;

  WaitingAddIoiState({this.selectUnit});

  WaitingAddIoiState copyWith({String selectUnit}) => WaitingAddIoiState(selectUnit: selectUnit ?? this.selectUnit);

  @override
  List<Object> get props => [this.selectUnit];
}

class AddToBillState extends AddIoiState {
  final ItemBillEntity itemBill;

  AddToBillState(this.itemBill);

  @override
  List<Object> get props => [this.itemBill];
}
