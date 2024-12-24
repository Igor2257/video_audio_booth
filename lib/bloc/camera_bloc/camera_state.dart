part of 'camera_bloc.dart';

@immutable
class CameraState {
  final CameraController? frontController;
  final CameraController? backController;

  final String error;

  final bool isRecording;

  const CameraState({
    this.frontController,
    this.backController,
    this.error = '',
    this.isRecording = false,
  });

  CameraState copyWith({
    CameraController? frontController,
    CameraController? backController,
    String? error,
    bool? isRecording,
  }) {
    return CameraState(
      frontController: frontController ?? this.frontController,
      backController: backController ?? this.backController,
      error: error ?? this.error,
      isRecording: isRecording ?? this.isRecording,
    );
  }
}
