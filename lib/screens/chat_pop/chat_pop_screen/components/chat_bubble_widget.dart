part of '../chat_pop_screen.dart';
class ChatBubbleWidget extends StatelessWidget {
  const ChatBubbleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BubbleSpecialThree(
      text: 'Added iMessage shape bubbles',
      color: Color(0xFF1B97F3),
      tail: false,
      textStyle: TextStyle(
          color: Colors.white,
          fontSize: 16
      ),
    );
  }
}
