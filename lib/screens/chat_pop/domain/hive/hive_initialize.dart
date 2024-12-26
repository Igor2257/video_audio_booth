
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_audio_booth/screens/chat_pop/domain/dto/chat_message_dto.dart';
import 'package:video_audio_booth/screens/chat_pop/domain/dto/conversation_dto.dart';

late final Box<ChatMessageDto> chatMessages;
late final Box<ConversationDto> conversations;


class HiveInitialize {
  var _initialized = false;

  bool get isInitialized => _initialized;

  Future<bool> initialize() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(ChatMessageDtoAdapter())
      ..registerAdapter(ConversationDtoAdapter());

    try {
      chatMessages = await Hive.openBox<ChatMessageDto>('chat_messages_box');
      conversations = await Hive.openBox<ConversationDto>('conversations_box');

      _initialized = true;
    } catch (e, trace) {
      _initialized = false;
    }
    return _initialized;
  }
}
