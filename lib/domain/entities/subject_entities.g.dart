// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_entities.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectEntitiesAdapter extends TypeAdapter<SubjectEntities> {
  @override
  final int typeId = 2;

  @override
  SubjectEntities read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectEntities(
      subjectId: fields[0] as int?,
      subjectName: fields[1] as String?,
      credits: fields[2] as int?,
      isAdded: fields[3] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectEntities obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.subjectId)
      ..writeByte(1)
      ..write(obj.subjectName)
      ..writeByte(2)
      ..write(obj.credits)
      ..writeByte(3)
      ..write(obj.isAdded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectEntitiesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
