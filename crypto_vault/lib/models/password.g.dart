// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PasswordAdapter extends TypeAdapter<Password> {
  @override
  final int typeId = 1;

  @override
  Password read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Password(
      title: fields[1] as String,
      email: fields[0] as String,
      encryptedPw: fields[3] as String,
      iv: fields[6] as String,
    )
      ..username = fields[2] as String
      ..isFavourite = fields[4] as bool
      ..websiteURL = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, Password obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.encryptedPw)
      ..writeByte(4)
      ..write(obj.isFavourite)
      ..writeByte(5)
      ..write(obj.websiteURL)
      ..writeByte(6)
      ..write(obj.iv);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasswordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
