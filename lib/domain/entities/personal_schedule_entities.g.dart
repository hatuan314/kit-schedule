// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_schedule_entities.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonalScheduleEntitiesAdapter
    extends TypeAdapter<PersonalScheduleEntities> {
  @override
  final int typeId = 1;

  @override
  PersonalScheduleEntities read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonalScheduleEntities(
      date: fields[0] as String?,
      name: fields[1] as String?,
      timer: fields[2] as String?,
      note: fields[3] as String?,
      createAt: fields[4] as String?,
      updateAt: fields[5] as String?,
      isSynchronized: fields[6] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PersonalScheduleEntities obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.timer)
      ..writeByte(3)
      ..write(obj.note)
      ..writeByte(4)
      ..write(obj.createAt)
      ..writeByte(5)
      ..write(obj.updateAt)
      ..writeByte(6)
      ..write(obj.isSynchronized);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalScheduleEntitiesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
