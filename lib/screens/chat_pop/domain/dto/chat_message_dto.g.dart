// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatMessageDtoAdapter extends TypeAdapter<ChatMessageDto> {
  @override
  final int typeId = 0;

  @override
  ChatMessageDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatMessageDto(
      id: fields[0] as String,
      text: fields[1] as String,
      isSender: fields[3] as bool,
      isSent: fields[4] as bool,
      conversationId: fields[5] as String,
      messageSentDateTime: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ChatMessageDto obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.isSender)
      ..writeByte(4)
      ..write(obj.isSent)
      ..writeByte(5)
      ..write(obj.conversationId)
      ..writeByte(6)
      ..write(obj.messageSentDateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatMessageDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatMessageDtoImpl _$$ChatMessageDtoImplFromJson(Map<String, dynamic> json) =>
    _$ChatMessageDtoImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      isSender: json['isSender'] as bool? ?? false,
      isSent: json['isSent'] as bool? ?? false,
      conversationId: json['conversationId'] as String,
      messageSentDateTime:
          DateTime.parse(json['messageSentDateTime'] as String),
    );

Map<String, dynamic> _$$ChatMessageDtoImplToJson(
        _$ChatMessageDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'isSender': instance.isSender,
      'isSent': instance.isSent,
      'conversationId': instance.conversationId,
      'messageSentDateTime': instance.messageSentDateTime.toIso8601String(),
    };
