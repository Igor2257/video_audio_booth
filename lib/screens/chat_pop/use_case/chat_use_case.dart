import 'package:video_audio_booth/screens/chat_pop/use_case/entity/chat_message_entity.dart';
import 'package:video_audio_booth/use_case/entity/result.dart';

abstract class ChatUseCase{
  Future<Result<ChatMessageEntity>> getAnswerFromChatGPTFromQuery(String query);
  ChatMessageEntity convertMessageToChatMessageEntity(String message,String conversationId);
}