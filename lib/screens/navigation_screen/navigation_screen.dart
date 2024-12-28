import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_audio_booth/bloc/app_bloc/app_bloc.dart';
import 'package:video_audio_booth/domain/provider/screen_provider.dart';
import 'package:video_audio_booth/screens/chat_pop/chat_pop_screen/chat_pop_screen.dart';
import 'package:video_audio_booth/screens/navigation_screen/custom_overlay_entry.dart';

class NavigationScreen extends StatelessWidget {
  NavigationScreen({super.key});

  final GlobalKey _overlayKey = GlobalKey();

  @override
  Widget build(BuildContext mContext) {
    return BlocSelector<AppBloc, AppState, int>(

      selector: (state) {

        return state.currentIndex;
      },
      builder: (context, currentIndex) {
        return BlocListener<AppBloc, AppState>(
          key: _overlayKey,
          listener: (context, state) {
            print(
                "state.messageTextEditingController != null &&state.messageTextEditingController!.text.isNotEmpty ${state.messageTextEditingController != null && state.messageTextEditingController!.text.isNotEmpty}");
            if (state.messageTextEditingController != null &&
                state.messageTextEditingController!.text.isNotEmpty) {
              CustomOverlayEntry.show(
                  context,
                  BlocSelector<AppBloc, AppState, TextEditingController?>(
                    selector: (state) {
                      return state.messageTextEditingController;
                    },
                    builder: (context, messageTextEditingController) {
                      if (messageTextEditingController == null)
                        return SizedBox();
                      return ChatPopScreen(
                          messageTextEditingController:
                              messageTextEditingController);
                    },
                  ),
                  _overlayKey);
            }
          },
          child: Scaffold(
            body: ScreensProvider.getScreenByIndex(currentIndex),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                BlocProvider.of<AppBloc>(context)
                    .add(ChangePage(newPage: index));
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.videocam),
                  label: 'Запис',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.text_snippet),
                  label: 'Результати',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
