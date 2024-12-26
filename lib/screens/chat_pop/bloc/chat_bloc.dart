import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:video_audio_booth/screens/chat_pop/use_case/entity/chat_message_entity.dart';
import 'package:video_audio_booth/screens/chat_pop/use_case/entity/conversation_entity.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState()) {
    on<LoadData>(_onLoadData);
    on<SendNewMessage>(_onSendNewMessage);
    on<ChatEvent>(_on);
  }

  FutureOr<void> _onLoadData(LoadData event, Emitter<ChatState> emit) async {
    emit(state.copyWith(conversationEntity: event.conversationEntity));
  }

  FutureOr<void> _onSendNewMessage(
      SendNewMessage event, Emitter<ChatState> emit) async {
    
  }
}
