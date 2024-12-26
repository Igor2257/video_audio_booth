part of 'add_new_conversation_bloc.dart';

@immutable
sealed class AddNewConversationEvent {}

class LoadData extends AddNewConversationEvent{
  LoadData();
}
class CreateNewConversation extends AddNewConversationEvent{
  CreateNewConversation();
}
