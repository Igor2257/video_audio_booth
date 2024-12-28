part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class LoadData extends ChatEvent{
  final TextEditingController messageTextEditingController;

  LoadData({required this.messageTextEditingController});
}

class SendNewMessage extends ChatEvent{

  SendNewMessage();
}

class ReceiveNewMessageFromMessage extends ChatEvent{
  final String message;

  ReceiveNewMessageFromMessage({required this.message});
}





