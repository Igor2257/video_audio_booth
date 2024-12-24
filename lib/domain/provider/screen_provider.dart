import 'package:flutter/material.dart';
import 'package:video_audio_booth/screens/result_screen/result_screen.dart';
import 'package:video_audio_booth/screens/video_capture_screen/video_capture_screen.dart';

class ScreensProvider {
  static List<Widget> getScreens() {
    return [
      const VideoCaptureScreen(),
      const ResultScreen(),
    ];
  }

  static Widget getScreenByIndex(int currentIndex) {
    return getScreens()[currentIndex];
  }
}
