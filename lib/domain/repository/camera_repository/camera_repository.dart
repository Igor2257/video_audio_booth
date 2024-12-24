import 'package:video_audio_booth/use_case/entity/result.dart';

abstract class CameraRepository{
  Future<void> startVideoAudioRecording();
  Future<void> stopVideoAudioRecording();
  Future<String?> getAudioText();
  Future<Result<String>> getAnswerFromChatGPTFromQuery(String query);
}