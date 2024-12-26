import 'dart:convert';

import 'package:uuid/uuid.dart';
import 'package:video_audio_booth/screens/chat_pop/data/chat_data_impl.dart';
import 'package:video_audio_booth/screens/chat_pop/use_case/entity/chat_message_entity.dart';
import 'package:video_audio_booth/use_case/entity/result.dart';

import 'chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  factory ChatRepositoryImpl() => instance;

  ChatRepositoryImpl._();

  static final ChatRepositoryImpl instance = ChatRepositoryImpl._();
  final _chatDataImpl = ChatDataImpl.instance;

  @override
  Future<Result<ChatMessageEntity>> getAnswerFromChatGPTFromQuery(
      String query) async {
    final response = await _chatDataImpl.getAnswerFromChatGPTFromQuery(query);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      var messageContent = responseBody['choices'][0]['message']['content'];

      var decodedMessage = utf8.decode(messageContent.codeUnits);
      print("Chat gpt decodedMessage: {${decodedMessage}}");

      return Result.success(ChatMessageEntity(
          id: const Uuid().v1(),
          text: decodedMessage,
          isTail: true,
          isSender: false,
          isSent: true,
          conversationId: '',
          messageSentDateTime: DateTime.now()));
    }
    return Result.failure("error");
  }
}
