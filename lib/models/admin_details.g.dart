// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdminDetailsAdapter extends TypeAdapter<AdminDetails> {
  @override
  final int typeId = 12;

  @override
  AdminDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdminDetails(
      fields[0] as String?,
      fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AdminDetails obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.adminName)
      ..writeByte(1)
      ..write(obj.adminProfile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
