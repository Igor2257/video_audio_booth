part of 'conversation_bloc.dart';

@immutable
class ConversationState {
  final List<ConversationEntity> availableConversations;

  const ConversationState({
    this.availableConversations = const [],
  });

  ConversationState copyWith({
    List<ConversationEntity>? availableConversations,
  }) {
    return ConversationState(
      availableConversations:
          availableConversations ?? this.availableConversations,
    );
  }
}
