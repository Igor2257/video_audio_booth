import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'camera_data.dart';

class CameraDataImpl implements CameraData {
  factory CameraDataImpl() => instance;

  CameraDataImpl._();

  static final CameraDataImpl instance = CameraDataImpl._();

  @override
  Future<http.Response> getAnswerFromChatGPTFromQuery(String query) async {
    print("dotenv.env['MY_CHAT_GPT_KEY'] ${dotenv.env["MY_CHAT_GPT_KEY"]}");

    var response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        "Authorization": "Bearer ${dotenv.env["MY_CHAT_GPT_KEY"]}",
        "Content-Type": "application/json"
      },
      body: jsonEncode(
        {
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content": query,
            }
          ]
        },
      ),
    );
    return response;
  }
}
