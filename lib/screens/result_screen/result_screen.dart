import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_audio_booth/bloc/result_bloc/result_bloc.dart';
import 'package:video_player/video_player.dart';

part 'components/result_widget.dart';
part 'components/video_back_widget.dart';
part 'components/video_front_widget.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultBloc()..add(LoadData()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Результат'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: const [
            VideoBackWidget(),
            SizedBox(height: 16),
            VideoFrontWidget(),
            SizedBox(height: 16),
            ResultWidget(),
          ],
        ),
      ),
    );
  }
}
