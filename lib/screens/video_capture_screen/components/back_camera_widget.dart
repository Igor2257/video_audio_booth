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
        const String viewType = '<camera_view>';
        // Pass parameters to the platform side.
        final Map<String, dynamic> creationParams = <String, dynamic>{};
        return AndroidView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
        //return CameraPreview(backController);
      },
    );
  }
}
