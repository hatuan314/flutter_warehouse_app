import 'package:equatable/equatable.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/product_entity.dart';

abstract class AddIoiState extends Equatable {}

class WaitingAddIoiState extends AddIoiState {
  final String selectUnit;
  final String selectCategory;
  final String errorName;
  final List<ProductEntity> productList;

  WaitingAddIoiState({
    this.selectUnit,
    this.selectCategory,
    this.errorName,
    this.productList,
  });

  WaitingAddIoiState copyWith({
    String selectUnit,
    String selectCategory,
    String errorName,
    List<ProductEntity> productList,
  }) =>
      WaitingAddIoiState(
        selectUnit: selectUnit ?? this.selectUnit,
        selectCategory: selectCategory ?? this.selectCategory,
        errorName: errorName ?? this.errorName,
        productList: productList ?? this.productList,
      );

  @override
  List<Object> get props => [
        this.selectUnit,
        this.selectCategory,
        this.errorName,
        this.productList,
      ];
}

class AddToBillState extends AddIoiState {
  final ItemBillEntity itemBill;

  AddToBillState(this.itemBill);

  @override
  List<Object> get props => [this.itemBill];
}
