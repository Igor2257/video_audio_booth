import 'package:http/http.dart';

abstract class ChatData{
  Future<Response> getAnswerFromChatGPTFromQuery(String query);
}