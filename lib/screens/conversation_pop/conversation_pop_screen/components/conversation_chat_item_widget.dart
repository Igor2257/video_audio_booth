part of '../conversation_pop_screen.dart';

class ConversationChatItemWidget extends StatelessWidget {
  const ConversationChatItemWidget({super.key, required this.item});

  final ConversationEntity item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(),
        ),
      ),
      child: Column(
        children: [
          Text(
            item.name,
            style: const TextStyle(fontSize: 18),
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                item.name,
                style: const TextStyle(fontSize: 14),
              )),
              const SizedBox(width: 16),
              Text(
                getFormattedTime(item.lastMessageDateTime),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          )
        ],
      ),
    );
  }
}
