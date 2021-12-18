// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_entities.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScoreEntitiesAdapter extends TypeAdapter<ScoreEntities> {
  @override
  final int typeId = 3;

  @override
  ScoreEntities read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScoreEntities(
      id: fields[0] as int?,
      credits: fields[5] as int?,
      subject: fields[1] as String?,
      scoreIn4: fields[2] as double?,
      scoreIn10: fields[3] as double?,
      letter: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ScoreEntities obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.scoreIn4)
      ..writeByte(3)
      ..write(obj.scoreIn10)
      ..writeByte(4)
      ..write(obj.letter)
      ..writeByte(5)
      ..write(obj.credits);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScoreEntitiesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
