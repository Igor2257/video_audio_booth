import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:video_audio_booth/screens/chat_pop/use_case/chat_use_case_impl.dart';
import 'package:video_audio_booth/screens/chat_pop/use_case/entity/chat_message_entity.dart';
import 'package:video_audio_booth/screens/chat_pop/use_case/entity/conversation_entity.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState()) {
    on<LoadData>(_onLoadData);
    on<SendNewMessage>(_onSendNewMessage);
    on<ReceiveNewMessageFromMessage>(_onReceiveNewMessageFromMessage);
  }

  final _chatUseCaseImpl = ChatUseCaseImpl.instance;

  FutureOr<void> _onLoadData(LoadData event, Emitter<ChatState> emit) async {
    emit(state.copyWith(
        messageTextEditingController: event.messageTextEditingController,
        conversationEntity: ConversationEntity(
            id: Uuid().v1(),
            name: "name",
            lastMessage: "lastMessage",
            lastMessageDateTime: DateTime.now(),
            isMustBeOnTop: false)));
  }

  FutureOr<void> _onSendNewMessage(
      SendNewMessage event, Emitter<ChatState> emit)  {
    final message = state.messageTextEditingController!.text;
    final chatMessage = _chatUseCaseImpl.convertMessageToChatMessageEntity(
        message, state.conversationEntity!.id);
    final messagesInConversationEntities =
        List<ChatMessageEntity>.from(state.messagesInConversationEntities);
    messagesInConversationEntities.add(chatMessage);
    emit(state.copyWith(
        messagesInConversationEntities: messagesInConversationEntities));
    add(ReceiveNewMessageFromMessage(message: message));
  }

  FutureOr<void> _onReceiveNewMessageFromMessage(ReceiveNewMessageFromMessage event, Emitter<ChatState> emit)async {
    final message=event.message;
    final messageFromChatResult =
    await _chatUseCaseImpl.getAnswerFromChatGPTFromQuery(message);
    print("messageFromChatResult ${messageFromChatResult.data}");
    print("messageFromChatResult ${messageFromChatResult.error}");
    final messagesInConversationEntities =
    List<ChatMessageEntity>.from(state.messagesInConversationEntities);
    if (messageFromChatResult.data != null) {
      final messageFromChat = messageFromChatResult.data!;
      messageFromChat.conversationId = message;
      messagesInConversationEntities.add(messageFromChat);
    }
    print("messagesInConversationEntities ${messagesInConversationEntities.map((e)=>e.id).toList()}");
    print("messagesInConversationEntities ${messagesInConversationEntities.map((e)=>e.isSender).toList()}");
    print("messagesInConversationEntities ${messagesInConversationEntities.map((e)=>e.isSent).toList()}");
    print("messagesInConversationEntities ${messagesInConversationEntities.map((e)=>e.text).toList()}");
    emit(state.copyWith(
        messagesInConversationEntities: messagesInConversationEntities));
  }
}
