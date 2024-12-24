part of 'result_bloc.dart';

@immutable
class ResultState {
  final String result;
  final VideoPlayerController? frontController;
  final VideoPlayerController? backController;

  const ResultState({
    this.result = '',
    this.frontController,
    this.backController,
  });

  ResultState copyWith({
    String? result,
    VideoPlayerController? frontController,
    VideoPlayerController? backController,
  }) {
    return ResultState(
      result: result ?? this.result,
      frontController: frontController ?? this.frontController,
      backController: backController ?? this.backController,
    );
  }
}
