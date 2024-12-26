part of '../conversation_pop_screen.dart';

class ConversationAddNewConversationButton extends StatelessWidget {
  const ConversationAddNewConversationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){
      ///TODO: Redirect to add new conversation screen
    }, child: const Icon(Icons.add));
  }
}
