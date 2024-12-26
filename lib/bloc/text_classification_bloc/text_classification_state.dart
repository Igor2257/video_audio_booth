part of 'text_classification_bloc.dart';

@immutable
class TextClassificationState {
  final String text;
  final String result;
  final List<String> output;

  const TextClassificationState({
    this.text = '',
    this.result = '',
    this.output = const [],
  });

  TextClassificationState copyWith({
    String? text,
    String? result,
    List<String>? output,
}){
    return TextClassificationState(
      text: text??this.text,
      result: result??this.result,
      output: output??this.output,
    );
  }
}
