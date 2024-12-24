part of 'app_bloc.dart';

@immutable
class AppState {
  final int currentIndex;

  const AppState({
    this.currentIndex = 0,
  });

  AppState copyWith({
    int? currentIndex,
  }) {
    return AppState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
