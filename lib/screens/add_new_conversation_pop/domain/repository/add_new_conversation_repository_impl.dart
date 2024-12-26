import 'package:uuid/uuid.dart';
import 'package:video_audio_booth/screens/chat_pop/domain/hive/chat_messages_hive.dart';
import 'package:video_audio_booth/screens/chat_pop/domain/hive/conversation_hive.dart';
import 'package:video_audio_booth/screens/chat_pop/use_case/entity/chat_message_entity.dart';
import 'package:video_audio_booth/screens/chat_pop/use_case/entity/conversation_entity.dart';
import 'package:video_audio_booth/screens/chat_pop/use_case/mapper/chat_message_mapper.dart';
import 'package:video_audio_booth/screens/chat_pop/use_case/mapper/conversation_mapper.dart';

import 'add_new_conversation_repository.dart';

class AddNewConversationRepositoryImpl implements AddNewConversationRepository {
  factory AddNewConversationRepositoryImpl() => instance;

  AddNewConversationRepositoryImpl._();

  static final AddNewConversationRepositoryImpl instance =
      AddNewConversationRepositoryImpl._();
  final _conversationHive = ConversationHive.instance;
  final _chatMessagesHive = ChatMessagesHive.instance;

  @override
  Future<bool> saveNewConversation(String name) async {
    final String uuid = const Uuid().v1();
    final conversationEntity = ConversationEntity(
      id: uuid,
      name: name,
      lastMessage: "Нова бесіда створена",
      lastMessageDateTime: DateTime.now(),
      isMustBeOnTop: false,
    );
    final message = ChatMessageEntity(
      id: const Uuid().v4(),
      text: "Нова бесіда створена",
      isSender: false,
      isSent: true,
      conversationId: uuid,
      messageSentDateTime: DateTime.now(),
    );
    bool isDone = await _conversationHive
        .create(ConversationMapper.toDto(conversationEntity));
    if (!isDone) {
      return false;
    }
    isDone = await _chatMessagesHive.create(ChatMessageMapper.toDto(message));

    return isDone;
  }
}
