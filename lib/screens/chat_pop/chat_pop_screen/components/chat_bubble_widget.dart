part of '../chat_pop_screen.dart';

class ChatBubbleWidget extends StatelessWidget {
  const ChatBubbleWidget({super.key, required this.message});

  final ChatMessageEntity message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isSender ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: CustomPaint(
          painter: SpecialChatBubbleThree(
              color:
                  message.isSender ? Colors.blueAccent : Colors.grey.shade300,
              alignment:
                  message.isSender ? Alignment.topRight : Alignment.topLeft,
              tail: false),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * .7,
            ),
            margin: message.isSender
                ? const EdgeInsets.fromLTRB(7, 7, 14, 7)
                : const EdgeInsets.fromLTRB(17, 7, 7, 7),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 4, right: 20),
                  child: Text(
                    message.text,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
