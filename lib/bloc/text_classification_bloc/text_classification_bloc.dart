import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:video_audio_booth/utils/core/constants.dart';

part 'text_classification_event.dart';
part 'text_classification_state.dart';

class TextClassificationBloc
    extends Bloc<TextClassificationEvent, TextClassificationState> {
  TextClassificationBloc() : super(const TextClassificationState()) {
    on<LoadData>(_onLoadData);
    on<ClassifyText>(_onClassifyText);
  }

  FutureOr<void> _onLoadData(
      LoadData event, Emitter<TextClassificationState> emit) async {
    print("load data");
    add(ClassifyText(text: "що працює як ця технологія"));
    add(ClassifyText(text: "Знайди як працює ця технологія"));
    add(ClassifyText(text: "Мені дуже подобається ця технологія"));
    add(ClassifyText(text: "Треба щоб було чудово"));
    add(ClassifyText(text: "Сделай это сейчас"));
    add(ClassifyText(text: "Запишите это"));
    add(ClassifyText(text: "Сделай это сейчас"));
    add(ClassifyText(text: "Сделай это за меня"));
  }

  FutureOr<void> _onClassifyText(
      ClassifyText event, Emitter<TextClassificationState> emit) async {
    print("Result ${event.text}");
    emit(state.copyWith(text: event.text));
   final result= await channel.invokeMethod("startClassify", [event.text]);

    print("result text is: $result");
  }

}
