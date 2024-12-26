
import 'package:video_audio_booth/domain/hive/hive_initialize.dart';
import 'package:video_audio_booth/domain/hive/hive_interface.dart';
import 'package:video_audio_booth/screens/chat_pop/domain/dto/chat_message_dto.dart';

class ChatMessagesHive implements HiveInterface<ChatMessageDto> {
  factory ChatMessagesHive() => instance;

  ChatMessagesHive._();

  static final ChatMessagesHive instance = ChatMessagesHive._();

  List<ChatMessageDto> get allMessagesDtos =>
      List.unmodifiable(chatMessagesBox.values);

  ChatMessageDto? getChatMessageById(String id) {
    return chatMessagesBox.get(id);
  }

  @override
  Future<bool> clear()async {
    try {
      await chatMessagesBox.clear();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> create(ChatMessageDto item) async{
    try {
      await chatMessagesBox.put(item.id, item);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> delete(List<int> ids)async {
    try {
      await chatMessagesBox.deleteAll(ids);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> update(ChatMessageDto item) async{
    try {
      await chatMessagesBox.put(item.id, item);
      return true;
    } catch (e) {
      return false;
    }
  }

}