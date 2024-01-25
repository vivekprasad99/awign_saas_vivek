// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_location.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkLocationAdapter extends TypeAdapter<WorkLocation> {
  @override
  final int typeId = 3;

  @override
  WorkLocation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkLocation(
      id: fields[0] as int?,
      address: fields[1] as String?,
      branchCode: fields[2] as String?,
      latitude: fields[3] as double?,
      longitude: fields[4] as double?,
      punchRadius: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, WorkLocation obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.branchCode)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude)
      ..writeByte(5)
      ..write(obj.punchRadius);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkLocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
