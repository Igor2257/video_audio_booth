import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:video_audio_booth/screens/chat_pop/use_case/entity/conversation_entity.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc(super.initialState) {
    on<LoadData>(_onLoadData);
  }

  FutureOr<void> _onLoadData(
      LoadData event, Emitter<ConversationState> emit) async {

  }
}
