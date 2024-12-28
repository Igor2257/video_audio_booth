part of 'app_bloc.dart';

@immutable
class AppState {
  final int currentIndex;
  final TextEditingController? messageTextEditingController;
final String recognizedText;
  const AppState({
    this.currentIndex = 0,
    this.messageTextEditingController ,
    this.recognizedText='' ,
  });

  AppState copyWith({
    int? currentIndex,
    TextEditingController? messageTextEditingController,
    String? recognizedText,
  }) {
    return AppState(
      currentIndex: currentIndex ?? this.currentIndex,
      messageTextEditingController: messageTextEditingController ?? this.messageTextEditingController,
      recognizedText: recognizedText ?? this.recognizedText,
    );
  }
}
