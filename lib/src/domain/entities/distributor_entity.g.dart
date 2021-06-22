// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distributor_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DistributorEntityAdapter extends TypeAdapter<DistributorEntity> {
  @override
  final int typeId = 0;

  @override
  DistributorEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DistributorEntity(
      name: fields[0] as String,
      phones: (fields[1] as List)?.cast<String>(),
      emails: (fields[2] as List)?.cast<String>(),
      color: fields[3] as int,
      createAt: fields[4] as DateTime,
      lastUpdate: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DistributorEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phones)
      ..writeByte(2)
      ..write(obj.emails)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.createAt)
      ..writeByte(5)
      ..write(obj.lastUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DistributorEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
