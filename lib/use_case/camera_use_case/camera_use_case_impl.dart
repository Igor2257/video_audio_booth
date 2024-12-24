import 'package:camera/camera.dart';
import 'package:video_audio_booth/domain/repository/camera_repository/camera_repository_impl.dart';
import 'package:video_audio_booth/use_case/entity/result.dart';

import 'camera_use_case.dart';

class CameraUseCaseImpl implements CameraUseCase {
  factory CameraUseCaseImpl() => instance;

  CameraUseCaseImpl._();

  static final CameraUseCaseImpl instance = CameraUseCaseImpl._();

  final _cameraRepositoryImpl = CameraRepositoryImpl.instance;

  @override
  Future<Result<CameraController>> getBackCamera() async {
    try {
      final List<CameraDescription> cameras = await availableCameras();
      CameraController frontController = CameraController(
          cameras
              .firstWhere((e) => e.lensDirection == CameraLensDirection.back),
          ResolutionPreset.max);
      await frontController.initialize();
      return Result.success(frontController);
    } catch (e) {
      print("error ${e.toString()}");
      return Result.failure('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<Result<CameraController>> getFrontCamera() async {
    try {
      final List<CameraDescription> cameras = await availableCameras();
      CameraController frontController = CameraController(
          cameras
              .firstWhere((e) => e.lensDirection == CameraLensDirection.front),
          ResolutionPreset.max);
      await frontController.initialize();
      return Result.success(frontController);
    } catch (e) {
      print("error ${e.toString()}");
      return Result.failure('Unexpected error: ${e.toString()}');
    }
  }

  @override
  Future<void> startVideoAudioRecording()async {
   await _cameraRepositoryImpl.startVideoAudioRecording();
  }

  @override
  Future<void> stopVideoAudioRecording()async {
    await _cameraRepositoryImpl.stopVideoAudioRecording();
  }

  @override
  Future<String?> getAudioText() async{
   return await _cameraRepositoryImpl.getAudioText();
  }

  @override
  Future<Result<String>> getAnswerFromChatGPTFromQuery(String query)async {
   return _cameraRepositoryImpl.getAnswerFromChatGPTFromQuery(query);
  }
}
