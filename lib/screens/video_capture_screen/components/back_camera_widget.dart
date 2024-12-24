part of '../video_capture_screen.dart';

class BackCameraWidget extends StatelessWidget {
  const BackCameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CameraBloc, CameraState, CameraController?>(
      selector: (state) {
        return state.backController;
      },
      builder: (context, backController) {
        if (backController == null) {
          return const SizedBox();
        }
        return CameraPreview(backController);
      },
    );
  }
}
