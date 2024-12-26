part of 'text_classification_bloc.dart';

@immutable
sealed class TextClassificationEvent {}

class LoadData extends TextClassificationEvent {
  LoadData();
}

class ClassifyText extends TextClassificationEvent {
  final String text;

  ClassifyText({required this.text});
}
