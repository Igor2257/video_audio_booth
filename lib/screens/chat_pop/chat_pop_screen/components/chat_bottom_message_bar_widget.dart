part of '../chat_pop_screen.dart';

class ChatBottomMessageBarWidget extends StatelessWidget {
  const ChatBottomMessageBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MessageBar(
      onSend: (message) {
        BlocProvider.of<ChatBloc>(context)
            .add(SendNewMessage(message: message));
      },
      messageBarHintText: "Введіть ваш текст",
    );
  }
}
