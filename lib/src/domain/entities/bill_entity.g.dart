// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillEntityAdapter extends TypeAdapter<BillEntity> {
  @override
  final int typeId = 3;

  @override
  BillEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BillEntity(
      distributor: fields[0] as String,
      type: fields[1] as String,
      items: (fields[2] as List)?.cast<dynamic>(),
      totalAmount: fields[3] as int,
      locale: fields[4] as String,
      hiveJson: fields[7] as String,
      createAt: fields[5] as int,
      lastUpdate: fields[6] as int,
      customer: fields[8] as String,
      billDate: fields[9] as int,
      images: (fields[10] as List)?.cast<String>(),
      description: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BillEntity obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.distributor)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.items)
      ..writeByte(3)
      ..write(obj.totalAmount)
      ..writeByte(4)
      ..write(obj.locale)
      ..writeByte(5)
      ..write(obj.createAt)
      ..writeByte(6)
      ..write(obj.lastUpdate)
      ..writeByte(7)
      ..write(obj.hiveJson)
      ..writeByte(8)
      ..write(obj.customer)
      ..writeByte(9)
      ..write(obj.billDate)
      ..writeByte(10)
      ..write(obj.images)
      ..writeByte(11)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
