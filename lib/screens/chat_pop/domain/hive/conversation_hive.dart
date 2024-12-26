import 'package:video_audio_booth/domain/hive/hive_initialize.dart';
import 'package:video_audio_booth/domain/hive/hive_interface.dart';
import 'package:video_audio_booth/screens/chat_pop/domain/dto/conversation_dto.dart';

class ConversationHive implements HiveInterface<ConversationDto> {
  factory ConversationHive() => instance;

  ConversationHive._();

  static final ConversationHive instance = ConversationHive._();

  List<ConversationDto> get conversationsDtos =>
      List.unmodifiable(conversationsBox.values);

  ConversationDto? getConversationById(String id) {
    return conversationsBox.get(id);
  }

  @override
  Future<bool> create(ConversationDto item) async {
    try {
      await conversationsBox.put(item.id, item);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> clear() async {
    try {
      await conversationsBox.clear();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> delete(List<int> ids) async {
    try {
      await conversationsBox.deleteAll(ids);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> update(ConversationDto item) async {
    try {
      await conversationsBox.put(item.id, item);
      return true;
    } catch (e) {
      return false;
    }
  }
}
