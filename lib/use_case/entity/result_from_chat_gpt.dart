import 'package:flutter/material.dart';

class ResultFromChatGpt extends ChangeNotifier {
  String? error;
  String? result;

  void saveDataFromChatGPT(String data) {
    result = data;
    notifyListeners();
  }

  void saveErrorFromChatGPT(String data) {
    error = data;
    notifyListeners();
  }
}
