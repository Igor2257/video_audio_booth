import 'package:video_audio_booth/screens/chat_pop/domain/repository/chat_repository_impl.dart';
import 'package:video_audio_booth/screens/chat_pop/use_case/entity/chat_message_entity.dart';
import 'package:video_audio_booth/use_case/entity/result.dart';

import 'chat_use_case.dart';

class ChatUseCaseImpl implements ChatUseCase {
  factory ChatUseCaseImpl() => instance;

  ChatUseCaseImpl._();

  static final ChatUseCaseImpl instance = ChatUseCaseImpl._();
  final _chatRepositoryImpl = ChatRepositoryImpl.instance;

  @override
  Future<Result<ChatMessageEntity>> getAnswerFromChatGPTFromQuery(
      String query) async {
    return await _chatRepositoryImpl.getAnswerFromChatGPTFromQuery(query);
  }
}
