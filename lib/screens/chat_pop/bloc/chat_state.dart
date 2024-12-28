part of 'chat_bloc.dart';

@immutable
class ChatState {
  final List<ChatMessageEntity> messagesInConversationEntities;
  final ConversationEntity? conversationEntity;
  final TextEditingController? messageTextEditingController;

  const ChatState({
    this.messagesInConversationEntities = const [],
    this.conversationEntity,
    this.messageTextEditingController,
  });

  ChatState copyWith({
    List<ChatMessageEntity>? messagesInConversationEntities,
    ConversationEntity? conversationEntity,
    TextEditingController? messageTextEditingController,
  }) {
    return ChatState(
      messagesInConversationEntities:
          messagesInConversationEntities ?? this.messagesInConversationEntities,
      conversationEntity: conversationEntity ?? this.conversationEntity,
      messageTextEditingController: messageTextEditingController ?? this.messageTextEditingController,
    );
  }
}
