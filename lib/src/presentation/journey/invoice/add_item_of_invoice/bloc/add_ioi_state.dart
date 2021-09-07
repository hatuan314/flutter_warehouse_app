import 'package:equatable/equatable.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';

abstract class AddIoiState extends Equatable {}

class WaitingAddIoiState extends AddIoiState {
  final String selectUnit;
  final String selectCategory;

  WaitingAddIoiState({
    this.selectUnit,
    this.selectCategory,
  });

  WaitingAddIoiState copyWith({String selectUnit, String selectCategory}) => WaitingAddIoiState(
        selectUnit: selectUnit ?? this.selectUnit,
        selectCategory: selectCategory ?? this.selectCategory,
      );

  @override
  List<Object> get props => [this.selectUnit, this.selectCategory];
}

class AddToBillState extends AddIoiState {
  final ItemBillEntity itemBill;

  AddToBillState(this.itemBill);

  @override
  List<Object> get props => [this.itemBill];
}
