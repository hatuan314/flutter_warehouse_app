import 'package:flutter/material.dart';
import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';

abstract class AddIoiEvent {}

class InitialAddIoiEvent extends AddIoiEvent {}

class SelectUnitEvent extends AddIoiEvent {
  final UnitEntity unit;

  SelectUnitEvent(this.unit);
}

class AddItemEvent extends AddIoiEvent {
  final String name;
  final String qty;
  final String price;

  AddItemEvent({@required this.name,@required this.qty,@required this.price});
}
