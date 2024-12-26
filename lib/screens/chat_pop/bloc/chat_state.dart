part of 'chat_bloc.dart';

@immutable
class ChatState {
  final List<ChatMessageEntity> messagesInConversationEntities;
  final ConversationEntity? conversationEntity;

  const ChatState({
    this.messagesInConversationEntities = const [],
    this.conversationEntity,
  });

  ChatState copyWith({
    List<ChatMessageEntity>? messagesInConversationEntities,
    ConversationEntity? conversationEntity,
  }) {
    return ChatState(
      messagesInConversationEntities:
          messagesInConversationEntities ?? this.messagesInConversationEntities,
      conversationEntity: conversationEntity ?? this.conversationEntity,
    );
  }
}
