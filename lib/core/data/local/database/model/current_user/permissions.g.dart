// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permissions.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PermissionsAdapter extends TypeAdapter<Permissions> {
  @override
  final int typeId = 1;

  @override
  Permissions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Permissions(
      s65: fields[0] as String?,
      s66: fields[1] as String?,
      s68: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Permissions obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.s65)
      ..writeByte(1)
      ..write(obj.s66)
      ..writeByte(2)
      ..write(obj.s68);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PermissionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
