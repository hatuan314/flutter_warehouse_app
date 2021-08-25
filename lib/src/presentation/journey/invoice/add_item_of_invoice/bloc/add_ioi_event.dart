import 'package:flutterwarehouseapp/src/domain/entities/unit_entity.dart';

abstract class AddIoiEvent {}

class InitialAddIoiEvent extends AddIoiEvent {}

class SelectUnitEvent extends AddIoiEvent {
  final UnitEntity unit;

  SelectUnitEvent(this.unit);
}

class AddItemEvent extends AddIoiEvent {
  final String name;
  final String unit;
  final int qty;
  final int amount;

  AddItemEvent(this.name, this.unit, this.qty, this.amount);
}
