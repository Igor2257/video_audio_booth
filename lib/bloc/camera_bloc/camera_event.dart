part of 'camera_bloc.dart';

@immutable
sealed class CameraEvent {}

class LoadData extends CameraEvent{
  LoadData();
}
class ClearError extends CameraEvent{
  ClearError();
}

class StartPauseRecording extends CameraEvent{
  StartPauseRecording();
}

class SendQueryToChatGPT extends CameraEvent{
  SendQueryToChatGPT();
}

