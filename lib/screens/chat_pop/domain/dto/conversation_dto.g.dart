// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConversationDtoAdapter extends TypeAdapter<ConversationDto> {
  @override
  final int typeId = 1;

  @override
  ConversationDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConversationDto(
      id: fields[0] as String,
      name: fields[1] as String,
      lastMessage: fields[2] as String,
      lastMessageDateTime: fields[3] as DateTime,
      isMustBeOnTop: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ConversationDto obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.lastMessage)
      ..writeByte(3)
      ..write(obj.lastMessageDateTime)
      ..writeByte(4)
      ..write(obj.isMustBeOnTop);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversationDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConversationDtoImpl _$$ConversationDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ConversationDtoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      lastMessage: json['lastMessage'] as String,
      lastMessageDateTime:
          DateTime.parse(json['lastMessageDateTime'] as String),
      isMustBeOnTop: json['isMustBeOnTop'] as bool,
    );

Map<String, dynamic> _$$ConversationDtoImplToJson(
        _$ConversationDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lastMessage': instance.lastMessage,
      'lastMessageDateTime': instance.lastMessageDateTime.toIso8601String(),
      'isMustBeOnTop': instance.isMustBeOnTop,
    };
