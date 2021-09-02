// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductEntityAdapter extends TypeAdapter<ProductEntity> {
  @override
  final int typeId = 5;

  @override
  ProductEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductEntity(
      document: fields[0] as String,
      name: fields[1] as String,
      category: fields[2] as String,
      distributor: fields[3] as String,
      qty: fields[4] as int,
      importPrice: fields[5] as int,
      exportPrice: fields[6] as int,
      locale: fields[7] as String,
      createAt: fields[8] as int,
      lastUpdate: fields[9] as int,
      isSync: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ProductEntity obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.document)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.distributor)
      ..writeByte(4)
      ..write(obj.qty)
      ..writeByte(5)
      ..write(obj.importPrice)
      ..writeByte(6)
      ..write(obj.exportPrice)
      ..writeByte(7)
      ..write(obj.locale)
      ..writeByte(8)
      ..write(obj.createAt)
      ..writeByte(9)
      ..write(obj.lastUpdate)
      ..writeByte(10)
      ..write(obj.isSync);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
