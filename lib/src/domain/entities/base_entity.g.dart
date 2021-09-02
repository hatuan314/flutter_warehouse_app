// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BaseEntityAdapter extends TypeAdapter<BaseEntity> {
  @override
  final int typeId = 5;

  @override
  BaseEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BaseEntity(
      document: fields[0] as String,
      isSync: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BaseEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.document)
      ..writeByte(1)
      ..write(obj.isSync);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
