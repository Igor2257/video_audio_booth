import 'package:flutter/services.dart';
import 'package:video_audio_booth/utils/core/constants.dart';

class FileOperations {
  static const EventChannel _eventChannel = EventChannel("com.spacecompany.video_audio_booth");

  // Слушаем события от нативной части
  Stream<String> get textStream {
    final text = _eventChannel.receiveBroadcastStream().map((event) => event as String);
    return text;
  }
}
