part of '../video_capture_screen.dart';

class StartPauseButtonWidget extends StatelessWidget {
  const StartPauseButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CameraBloc, CameraState, bool>(
      selector: (state) {
        return state.isRecording;
      },
      builder: (context, isRecording) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {
              BlocProvider.of<CameraBloc>(context).add(StartPauseRecording());
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: Colors.grey,
              ),
              padding: const EdgeInsets.all(16),
              child: Icon(isRecording ? Icons.pause : Icons.play_arrow_rounded,size: 40,),
            ),
          ),
        );
      },
    );
  }
}
