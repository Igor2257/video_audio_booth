part of '../conversation_pop_screen.dart';

class ConversationPopView extends StatelessWidget {
  const ConversationPopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ConversationListViewWidget(),
      ConversationListViewWidget(),
    ],);
  }
}
