import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/common/constants/enum_constants.dart';
import 'package:flutterwarehouseapp/src/domain/entities/category_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/item_bill_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/product_entity.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';

abstract class AddIoiEvent {}

class InitialAddIoiEvent extends AddIoiEvent {
  final String distributor;
  final ItemBillEntity itemBill;

  InitialAddIoiEvent({this.distributor, this.itemBill});
}

class SelectUnitEvent extends AddIoiEvent {
  final UnitEntity unit;

  SelectUnitEvent(this.unit);
}

class AddItemEvent extends AddIoiEvent {
  final String name;
  final String qty;
  final String price;
  final BillEnum billType;

  AddItemEvent({
    @required this.name,
    @required this.qty,
    @required this.price,
    @required this.billType,
  });
}

class SelectCategoryEvent extends AddIoiEvent {
  final CategoryEntity category;

  SelectCategoryEvent({@required this.category});
}

class SelectProductEvent extends AddIoiEvent {
  final ProductEntity product;

  SelectProductEvent(this.product);
}
