import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_audio_booth/domain/hive/hive_type_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'conversation_dto.freezed.dart';
part 'conversation_dto.g.dart';

@freezed
@HiveType(typeId: HiveTypeId.conversation)
class ConversationDto with _$ConversationDto {
  factory ConversationDto({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String lastMessage,
    @HiveField(3) required DateTime lastMessageDateTime,
    @HiveField(4) required bool isMustBeOnTop,
  }) = _ConversationDto;

  factory ConversationDto.fromJson(Map<String, dynamic> json) =>
      _$ConversationDtoFromJson(json);


}
