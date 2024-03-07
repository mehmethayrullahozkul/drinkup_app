// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WaterDataAdapter extends TypeAdapter<WaterData> {
  @override
  final int typeId = 1;

  @override
  WaterData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WaterData(
      date: fields[0] as DateTime,
      target: fields[1] as int,
      progress: fields[2] as double,
      amount: fields[3] as int,
      isComplete: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, WaterData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.target)
      ..writeByte(2)
      ..write(obj.progress)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.isComplete);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaterDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
