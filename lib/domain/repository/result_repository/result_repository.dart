import 'package:video_audio_booth/use_case/entity/result.dart';

abstract class ResultRepository{
  Future<Result<String>> getBackVideoPath();
  Future<Result<String>> getFrontVideoPath();
}