part of '../chat_pop_screen.dart';

class ChatPopView extends StatelessWidget {
  const ChatPopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ChatBottomMessageBarWidget(),
    ],);
  }
}