part of 'add_new_conversation_bloc.dart';

@immutable
class AddNewConversationState {
  final TextEditingController? name;
final bool isSaved;
  const AddNewConversationState({this.name,this.isSaved=false,});

  AddNewConversationState copyWith({
    TextEditingController? name,
    bool? isSaved,
  }) {
    return AddNewConversationState(
      name: name ?? this.name,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
