import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_audio_booth/screens/add_new_conversation_pop/bloc/add_new_conversation_bloc.dart';

part 'components/add_new_conversation_create_button_widget.dart';
part 'components/add_new_conversation_name_text_field.dart';
part 'components/add_new_conversation_pop_view.dart';

class AddNewChatPopScreen extends StatelessWidget {
  const AddNewChatPopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNewConversationBloc()..add(LoadData()),
      child: BlocListener<AddNewConversationBloc, AddNewConversationState>(
        listener: (context, state) {
          if (state.isSaved) {
            ///TODO: Make Redirect to new conversation
          }
        },
        child: const AddNewConversationPopView(),
      ),
    );
  }
}
