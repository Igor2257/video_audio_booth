import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:video_audio_booth/screens/add_new_conversation_pop/use_case/add_new_conversation_use_case_impl.dart';

part 'add_new_conversation_event.dart';
part 'add_new_conversation_state.dart';

class AddNewConversationBloc
    extends Bloc<AddNewConversationEvent, AddNewConversationState> {
  AddNewConversationBloc() : super(const AddNewConversationState()) {
    on<LoadData>(_onLoadData);
    on<CreateNewConversation>(_onCreateNewConversation);
  }

  final _addNewConversationUseCaseImpl = AddNewConversationUseCaseImpl.instance;

  FutureOr<void> _onLoadData(
      LoadData event, Emitter<AddNewConversationState> emit) {
    emit(state.copyWith(name: TextEditingController()));
  }

  FutureOr<void> _onCreateNewConversation(CreateNewConversation event,
      Emitter<AddNewConversationState> emit) async {
    if (state.name == null || state.name!.text.isEmpty) return;
    final isSaved = await _addNewConversationUseCaseImpl
        .saveNewConversation(state.name!.text);
    emit(state.copyWith(isSaved: isSaved));
  }
}
