import 'package:camera/camera.dart';
import 'package:video_audio_booth/use_case/entity/result.dart';

abstract class CameraUseCase{
  Future<Result<CameraController>> getFrontCamera();
  Future<Result<CameraController>> getBackCamera();
  Future<void> startVideoAudioRecording();
  Future<void> stopVideoAudioRecording();
  Future<String?> getAudioText();
  Future<Result<String>> getAnswerFromChatGPTFromQuery(String query);
}