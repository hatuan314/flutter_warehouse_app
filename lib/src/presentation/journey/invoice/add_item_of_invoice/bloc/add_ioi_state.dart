import 'package:equatable/equatable.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';

abstract class AddIoiState extends Equatable {}

class WaitingAddIoiState extends AddIoiState {
  final String selectUnit;
  final String selectCategory;
  final String errorName;

  WaitingAddIoiState({
    this.selectUnit,
    this.selectCategory,
    this.errorName,
  });

  WaitingAddIoiState copyWith({String selectUnit, String selectCategory, String errorName}) => WaitingAddIoiState(
        selectUnit: selectUnit ?? this.selectUnit,
        selectCategory: selectCategory ?? this.selectCategory,
        errorName: errorName ?? this.errorName,
      );

  @override
  List<Object> get props => [
        this.selectUnit,
        this.selectCategory,
        this.errorName,
      ];
}

class AddToBillState extends AddIoiState {
  final ItemBillEntity itemBill;

  AddToBillState(this.itemBill);

  @override
  List<Object> get props => [this.itemBill];
}
