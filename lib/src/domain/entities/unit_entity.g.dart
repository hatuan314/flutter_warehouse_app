// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UnitEntityAdapter extends TypeAdapter<UnitEntity> {
  @override
  final int typeId = 0;

  @override
  UnitEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UnitEntity(
      name: fields[1] as String,
      createAt: fields[2] as DateTime,
      lastUpdate: fields[3] as DateTime,
      id: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UnitEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createAt)
      ..writeByte(3)
      ..write(obj.lastUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnitEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
