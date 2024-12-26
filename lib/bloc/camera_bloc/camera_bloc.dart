import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:meta/meta.dart';
import 'package:video_audio_booth/main.dart';
import 'package:video_audio_booth/use_case/camera_use_case/camera_use_case.dart';
import 'package:video_audio_booth/use_case/camera_use_case/camera_use_case_impl.dart';
import 'package:video_audio_booth/use_case/entity/result.dart';
import 'package:video_audio_booth/use_case/entity/result_from_chat_gpt.dart';
import 'package:video_audio_booth/utils/core/constants.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(const CameraState()) {
    on<LoadData>(_onLoadData);
    on<ClearError>(_onClearError);
    on<StartPauseRecording>(_onStartPauseRecording);
    on<SendQueryToChatGPT>(_onSendQueryToChatGPT);
  }

  final CameraUseCase _cameraUseCase = CameraUseCaseImpl.instance;

  FutureOr<void> _onLoadData(LoadData event, Emitter<CameraState> emit) async {
    try {
      bool success = await channel.invokeMethod("startSession");
      print("success $success");
    } catch (e) {}
  }

  @override
  Future<void> close() {
    state.backController?.dispose();
    state.frontController?.dispose();
    return super.close();
  }

  FutureOr<void> _onClearError(ClearError event, Emitter<CameraState> emit) {
    emit(state.copyWith(error: ''));
  }

  FutureOr<void> _onStartPauseRecording(
      StartPauseRecording event, Emitter<CameraState> emit) async {
    if (state.isRecording) {
      await _cameraUseCase.stopVideoAudioRecording().whenComplete(() {
        add(SendQueryToChatGPT());
      });
    } else {
      await _cameraUseCase.startVideoAudioRecording();
    }
    emit(state.copyWith(isRecording: !state.isRecording));
  }

  FutureOr<void> _onSendQueryToChatGPT(
      SendQueryToChatGPT event, Emitter<CameraState> emit) async {
    final data = await _cameraUseCase.getAudioText();
    print("data $data");
    if (data != null) {
      //final result = await _cameraUseCase.getAnswerFromChatGPTFromQuery(data);
      final result = Result.success("Data");
      if (!getIt.isRegistered<ResultFromChatGpt>()) {
        getIt.registerSingleton<ResultFromChatGpt>(
          ResultFromChatGpt(),
          signalsReady: true,
        );
      }
      final it = getIt<ResultFromChatGpt>();
      if (result.error != null) {
        emit(state.copyWith(error: result.error!));
        it.saveErrorFromChatGPT(result.error!);
        return;
      }
      it.saveDataFromChatGPT(result.data!);
    }
  }
}
