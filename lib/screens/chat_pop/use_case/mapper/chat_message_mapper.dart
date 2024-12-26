import 'package:video_audio_booth/screens/chat_pop/domain/dto/chat_message_dto.dart';
import 'package:video_audio_booth/screens/chat_pop/use_case/entity/chat_message_entity.dart';

class ChatMessageMapper {
  static ChatMessageEntity toEntity(ChatMessageDto chatMessageDto) {
    return ChatMessageEntity(
      id: chatMessageDto.id,
      text: chatMessageDto.text,
      isTail: chatMessageDto.isTail,
      isSender: chatMessageDto.isSender,
      isSent: chatMessageDto.isSent,
      conversationId: chatMessageDto.conversationId,
      messageSentDateTime: chatMessageDto.messageSentDateTime,
    );
  }

  static ChatMessageDto toDto(ChatMessageEntity chatMessageEntity) {
    return ChatMessageDto(
      id: chatMessageEntity.id,
      text: chatMessageEntity.text,
      isTail: chatMessageEntity.isTail,
      isSender: chatMessageEntity.isSender,
      isSent: chatMessageEntity.isSent,
      conversationId: chatMessageEntity.conversationId,
      messageSentDateTime: chatMessageEntity.messageSentDateTime,
    );
  }
}
