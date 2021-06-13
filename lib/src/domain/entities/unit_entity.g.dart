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
    return UnitEntity();
  }

  @override
  void write(BinaryWriter writer, UnitEntity obj) {
    writer..writeByte(0);
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
