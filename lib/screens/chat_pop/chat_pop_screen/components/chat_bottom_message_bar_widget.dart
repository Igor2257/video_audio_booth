part of '../chat_pop_screen.dart';
class ChatBottomMessageBarWidget extends StatelessWidget {
  const ChatBottomMessageBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MessageBar(
      onSend: (_) => print(_),
      messageBarHintText: "Введіть ваш текст",
    );
  }
}
