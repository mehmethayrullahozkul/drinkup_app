// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_unit_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WaterUnitAdapter extends TypeAdapter<WaterUnit> {
  @override
  final int typeId = 2;

  @override
  WaterUnit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WaterUnit(
      date: fields[0] as DateTime,
      amount: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WaterUnit obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaterUnitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
