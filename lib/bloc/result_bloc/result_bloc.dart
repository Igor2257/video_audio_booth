import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:video_audio_booth/main.dart';
import 'package:video_audio_booth/use_case/entity/result_from_chat_gpt.dart';
import 'package:video_audio_booth/use_case/result_use_case/result_use_case_impl.dart';
import 'package:video_player/video_player.dart';

part 'result_event.dart';
part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  ResultBloc() : super(const ResultState()) {
    on<LoadData>(_onLoadData);
    on<PlayVideo>(_onPlayVideo);
  }

  final _resultUseCaseImpl = ResultUseCaseImpl.instance;

  FutureOr<void> _onLoadData(LoadData event, Emitter<ResultState> emit) async {
    print("Load data");
    if (!getIt.isRegistered<ResultFromChatGpt>()) {
      return;
    }
    final it = getIt<ResultFromChatGpt>();
    final frontPath = await _resultUseCaseImpl.getFrontVideoPath();
    final backPath = await _resultUseCaseImpl.getBackVideoPath();

    if (frontPath.data != null) {
      final frontController = VideoPlayerController.file(File(frontPath.data!));
      await frontController.initialize();
      print("Is video initialized: ${frontController.value.isInitialized}");
      print("Video duration: ${frontController.value.duration}");
      print("Has error: ${frontController.value.hasError}");
      await frontController.setLooping(true);
      await frontController.play();
      emit(state.copyWith(frontController: frontController));
    } else {
      print("Front video path is null or invalid: ${frontPath.error}");
    }

    if (backPath.data != null) {
      final backController = VideoPlayerController.file(File(backPath.data!));
      await backController.initialize();
      print("Is video initialized: ${backController.value.isInitialized}");
      print("Video duration: ${backController.value.duration}");
      print("Has error: ${backController.value.hasError}");
      await backController.setLooping(true);
      await backController.play();
      emit(state.copyWith(backController: backController));
    } else {
      print("Back video path is null or invalid: ${backPath.error}");
    }

    emit(state.copyWith(result: it.result ?? it.error ?? 'Empty'));
  }

  @override
  Future<void> close() {
    state.frontController?.dispose();
    state.backController?.dispose();
    return super.close();
  }

  FutureOr<void> _onPlayVideo(
      PlayVideo event, Emitter<ResultState> emit) async {
    await state.backController?.setLooping(true);
    await state.backController?.play();

    await state.frontController?.setLooping(true);
    await state.frontController?.play();
  }
}
