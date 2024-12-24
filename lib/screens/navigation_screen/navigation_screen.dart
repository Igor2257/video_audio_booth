import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_audio_booth/bloc/app_bloc/app_bloc.dart';
import 'package:video_audio_booth/domain/provider/screen_provider.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, int>(
      selector: (state) {
        return state.currentIndex;
      },
      builder: (context, currentIndex) {
        return Scaffold(
          body: ScreensProvider.getScreenByIndex(currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              BlocProvider.of<AppBloc>(context).add(ChangePage(newPage: index));
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
        );
      },
    );
  }
}
