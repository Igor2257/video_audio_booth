part of '../add_new_conversation_pop_screen.dart';

class AddNewConversationCreateButtonWidget extends StatelessWidget {
  const AddNewConversationCreateButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          BlocProvider.of<AddNewConversationBloc>(context)
              .add(CreateNewConversation());
        },
        child: const Text("Створити"));
  }
}
