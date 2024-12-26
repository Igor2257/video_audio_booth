import 'package:video_audio_booth/screens/add_new_conversation_pop/domain/repository/add_new_conversation_repository_impl.dart';

import 'add_new_conversation_use_case.dart';

class AddNewConversationUseCaseImpl implements AddNewConversationUseCase {
  factory AddNewConversationUseCaseImpl() => instance;

  AddNewConversationUseCaseImpl._();

  static final AddNewConversationUseCaseImpl instance =
      AddNewConversationUseCaseImpl._();
  final _addNewConversationRepositoryImpl =
      AddNewConversationRepositoryImpl.instance;

  @override
  Future<bool> saveNewConversation(String name) async {
    return await _addNewConversationRepositoryImpl.saveNewConversation(name);
  }
}
