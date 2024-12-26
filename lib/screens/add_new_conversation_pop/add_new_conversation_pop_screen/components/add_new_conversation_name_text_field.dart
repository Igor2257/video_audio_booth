part of '../add_new_conversation_pop_screen.dart';

class AddNewConversationNameTextField extends StatelessWidget {
  const AddNewConversationNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AddNewConversationBloc, AddNewConversationState,
        TextEditingController?>(
      selector: (state) {
        return state.name;
      },
      builder: (context, name) {
        if (name == null) {
          return const SizedBox();
        }
        return const TextField(
          decoration: InputDecoration(labelText: "Введіть назву чату"),
        );
      },
    );
  }
}
