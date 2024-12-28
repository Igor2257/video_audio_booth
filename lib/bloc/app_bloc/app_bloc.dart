import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_audio_booth/domain/services/file_operations_service.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<LoadData>(_onLoadData);
    on<ChangePage>(_onChangePage);
    on<NewRecognizedText>(_onNewRecognizedText);
  }

  FutureOr<void> _onChangePage(ChangePage event, Emitter<AppState> emit) {
    emit(state.copyWith(currentIndex: event.newPage));
  }

  FutureOr<void> _onLoadData(LoadData event, Emitter<AppState> emit) {
    emit(state.copyWith(messageTextEditingController: TextEditingController()));
    try {
      FileOperations().textStream.listen((text) {
        add(NewRecognizedText(text: text));

        print("Распознанный текст: $text"); // Печатаем текст, полученный из нативной части
        print("state.messageTextEditingController!.text: ${state.messageTextEditingController!.text}"); // Печатаем текст, полученный из нативной части
      }, onError: (error) {
        print("Ошибка: $error"); // Обработка ошибок
      });
    } catch (e) {
      print("Ошибка при прослушивании: $e");
    }
  }

  FutureOr<void> _onNewRecognizedText(NewRecognizedText event, Emitter<AppState> emit) {
    state.messageTextEditingController!.text = "${state.messageTextEditingController!.text} ${event.text}";
    emit(state.copyWith(recognizedText:event.text));
  }
}
