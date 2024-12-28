import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_audio_booth/screens/chat_pop/bloc/chat_bloc.dart';
import 'package:video_audio_booth/screens/chat_pop/use_case/entity/chat_message_entity.dart';
import 'package:video_audio_booth/screens/chat_pop/use_case/entity/conversation_entity.dart';

part 'components/chat_app_bar_widget.dart';
part 'components/chat_bottom_message_bar_widget.dart';
part 'components/chat_bubble_widget.dart';
part 'components/chat_messages_list_view_widget.dart';
part 'components/chat_pop_view.dart';

class ChatPopScreen extends StatelessWidget {
  const ChatPopScreen({super.key, required this.messageTextEditingController});
  final TextEditingController messageTextEditingController;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatBloc()..add(LoadData(messageTextEditingController: messageTextEditingController)),
      child: ChatPopView(),
    );
  }
}
