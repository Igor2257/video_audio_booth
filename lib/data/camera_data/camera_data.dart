import 'package:http/http.dart';
import 'package:video_audio_booth/use_case/entity/result.dart';

abstract class CameraData{
  Future<Response> getAnswerFromChatGPTFromQuery(String query);
}