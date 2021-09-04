// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_schedule_entities.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SchoolScheduleAdapter extends TypeAdapter<SchoolSchedule> {
  @override
  final int typeId = 0;

  @override
  SchoolSchedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SchoolSchedule(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?
    );
  }

  @override
  void write(BinaryWriter writer, SchoolSchedule obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.lesson)
      ..writeByte(2)
      ..write(obj.subject)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchoolScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
