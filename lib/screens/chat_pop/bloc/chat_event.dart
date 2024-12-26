part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class LoadData extends ChatEvent{
  final ConversationEntity conversationEntity;

  LoadData({required this.conversationEntity});
}

class SendNewMessage extends ChatEvent{
  final String message;

  SendNewMessage({required this.message});
}





