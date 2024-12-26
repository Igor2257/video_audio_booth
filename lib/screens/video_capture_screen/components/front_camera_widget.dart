part of '../video_capture_screen.dart';

class FrontCameraWidget extends StatelessWidget {
  const FrontCameraWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocSelector<CameraBloc, CameraState, CameraController?>(
      selector: (state) {
        return state.frontController;
      },
      builder: (context, frontController) {
        const String viewType = '<front_camera_view>';
        // Pass parameters to the platform side.
        final Map<String, dynamic> creationParams = <String, dynamic>{};
        return AndroidView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      },
    );
  }
}
