part of 'conversation_bloc.dart';

@immutable
sealed class ConversationEvent {}

class LoadData extends ConversationEvent {
  LoadData();
}
