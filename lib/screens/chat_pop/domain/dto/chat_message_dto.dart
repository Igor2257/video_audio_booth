import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_audio_booth/screens/chat_pop/domain/dto/hive_type_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'chat_message_dto.freezed.dart';
part 'chat_message_dto.g.dart';

@freezed
@HiveType(typeId: HiveTypeId.chatMessage)
class ChatMessageDto with _$ChatMessageDto {
  factory ChatMessageDto({
    @HiveField(0) required String id,
    @HiveField(1) required String text,
    @HiveField(3) @Default(false) bool isSender,
    @HiveField(4) @Default(false) bool isSent,
    @HiveField(5) required String conversationId,
    @HiveField(6) required DateTime messageSentDateTime,
  }) = _ChatMessageDto;

  factory ChatMessageDto.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageDtoFromJson(json);


}
