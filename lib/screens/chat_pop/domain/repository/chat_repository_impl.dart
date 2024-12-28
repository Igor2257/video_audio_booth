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
    if (query == "Заглушка") {
      return Result.success(ChatMessageEntity(
          id: const Uuid().v1(),
          text:
              "Солнечная система - это система, включающая в себя Солнце и все объекты, которые находятся под его гравитационным влиянием. К ней относятся планеты, их спутники, астероиды, кометы, межпланетный газ и пыль. В настоящее время известно, что в нашей Солнечной системе находится 8 планет: Меркурий, Венера, Земля, Марс, Юпитер, Сатурн, Уран и Нептун.",
          isSender: false,
          isSent: true,
          conversationId: '',
          messageSentDateTime: DateTime.now()));
    }

    final response = await _chatDataImpl.getAnswerFromChatGPTFromQuery(query);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      var messageContent = responseBody['choices'][0]['message']['content'];

      var decodedMessage = utf8.decode(messageContent.codeUnits);
      print("Chat gpt decodedMessage: {${decodedMessage}}");

      return Result.success(ChatMessageEntity(
          id: const Uuid().v1(),
          text: decodedMessage,
          isSender: false,
          isSent: true,
          conversationId: '',
          messageSentDateTime: DateTime.now()));
    }
    return Result.failure("error");
  }
}
