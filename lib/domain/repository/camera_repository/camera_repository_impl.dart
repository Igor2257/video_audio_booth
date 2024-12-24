import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:video_audio_booth/data/camera_data/camera_data_impl.dart';
import 'package:video_audio_booth/use_case/entity/result.dart';
import 'package:video_audio_booth/utils/core/constants.dart';

import 'camera_repository.dart';

class CameraRepositoryImpl implements CameraRepository {
  factory CameraRepositoryImpl() => instance;

  CameraRepositoryImpl._();

  static final CameraRepositoryImpl instance = CameraRepositoryImpl._();


  final _cameraDataImpl = CameraDataImpl.instance;

  @override
  Future<void> startVideoAudioRecording() async {
    await channel.invokeMethod("startDualCamera");
  }

  @override
  Future<void> stopVideoAudioRecording() async {
    await channel.invokeMethod("stopDualCamera");
  }

  @override
  Future<String?> getAudioText() async {
    return await channel.invokeMethod("getAudioText");
  }

  @override
  Future<Result<String>> getAnswerFromChatGPTFromQuery(String query) async {
    final response = await _cameraDataImpl.getAnswerFromChatGPTFromQuery(query);
    print("Chat gpt response: {${response.body}}");
    print("Chat gpt response: {${response.statusCode}}");
    print("Chat gpt response: {${response.contentLength}}");
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      var messageContent = responseBody['choices'][0]['message']['content'];

      var decodedMessage = utf8.decode(messageContent.codeUnits);
      print("Chat gpt decodedMessage: {${decodedMessage}}");

      return Result.success(decodedMessage);
    }
    return Result.failure("error");
  }
}
