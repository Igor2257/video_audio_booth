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
        if (frontController == null) {
          return const SizedBox();
        }
        return Container(color: Colors.red,
          width: size.width / 3,
          height: size.height / 4,
          child: CameraPreview(frontController),
        );
      },
    );
  }
}
