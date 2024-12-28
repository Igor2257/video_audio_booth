part of '../chat_pop_screen.dart';

class ChatPopView extends StatelessWidget {
  const ChatPopView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      constraints:
          BoxConstraints(maxWidth: size.width, maxHeight: size.height * 0.8),
      child: const Column(
        children: [
          ChatAppBarWidget(),
          ChatMessagesListViewWidget(),
          ChatBottomMessageBarWidget(),
        ],
      ),
    );
  }
}
