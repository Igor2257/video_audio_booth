part of '../chat_pop_screen.dart';

class ChatMessagesListViewWidget extends StatelessWidget {
  const ChatMessagesListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChatBloc, ChatState, List<ChatMessageEntity>>(
      selector: (state) {
        return state.messagesInConversationEntities;
      },
      builder: (context, messagesInConversationEntities) {
        return Expanded(
          child: ListView.builder(
              itemCount: messagesInConversationEntities.length,
              itemBuilder: (context, position) {
                return ChatBubbleWidget(
                    message: messagesInConversationEntities[position]);
              }),
        );
      },
    );
  }
}
