part of '../add_new_conversation_pop_screen.dart';

class AddNewConversationPopView extends StatelessWidget {
  const AddNewConversationPopView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AddNewConversationNameTextField(),
        AddNewConversationCreateButtonWidget(),
      ],
    );
  }
}
