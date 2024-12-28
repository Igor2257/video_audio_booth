part of '../chat_pop_screen.dart';

class ChatAppBarWidget extends StatelessWidget {
  const ChatAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChatBloc, ChatState, ConversationEntity?>(
      selector: (state) {
        return state.conversationEntity;
      },
      builder: (context, conversationEntity) {
        print("conversationEntity $conversationEntity");
        if(conversationEntity==null)return SizedBox();
        return Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(),
            ),
          ),
          child: Row(
            children: [
              const BackButton(),
              const SizedBox(width: 16),
              Text(
                conversationEntity.name,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        );
      },
    );
  }
}
