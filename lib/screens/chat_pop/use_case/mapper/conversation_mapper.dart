import 'package:video_audio_booth/screens/chat_pop/domain/dto/conversation_dto.dart';
import 'package:video_audio_booth/screens/chat_pop/use_case/entity/conversation_entity.dart';

class ConversationMapper {
  static ConversationEntity toEntity(ConversationDto conversationDto) {
    return ConversationEntity(
      id: conversationDto.id,
      name: conversationDto.name,
      lastMessage: conversationDto.lastMessage,
      lastMessageDateTime: conversationDto.lastMessageDateTime,
      isMustBeOnTop: conversationDto.isMustBeOnTop,
    );
  }

  static ConversationDto toDto(ConversationEntity conversationEntity) {
    return ConversationDto(
      id: conversationEntity.id,
      name: conversationEntity.name,
      lastMessage: conversationEntity.lastMessage,
      lastMessageDateTime: conversationEntity.lastMessageDateTime,
      isMustBeOnTop: conversationEntity.isMustBeOnTop,
    );
  }
}
