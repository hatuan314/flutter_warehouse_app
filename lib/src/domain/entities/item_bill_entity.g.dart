// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_bill_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemBillEntityAdapter extends TypeAdapter<ItemBillEntity> {
  @override
  final int typeId = 4;

  @override
  ItemBillEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemBillEntity(
      name: fields[0] as String,
      qty: fields[1] as int,
      price: fields[2] as int,
      totalPrice: fields[3] as int,
      unit: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ItemBillEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.qty)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.totalPrice)
      ..writeByte(4)
      ..write(obj.unit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemBillEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
