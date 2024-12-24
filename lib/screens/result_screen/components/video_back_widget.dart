part of '../result_screen.dart';

class VideoBackWidget extends StatelessWidget {
  const VideoBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ResultBloc, ResultState, VideoPlayerController?>(
      selector: (state) => state.backController,
      builder: (context, backController) {
        if (backController == null) {
          return const SizedBox();
        }
        return Stack(
          children: [
            AspectRatio(
              aspectRatio: backController.value.aspectRatio,
              child: VideoPlayer(backController),
            ),
            IconButton(
                onPressed: () {
                  BlocProvider.of<ResultBloc>(context).add(PlayVideo());
                },
                icon: Icon(
                  Icons.play_arrow,
                  color: Colors.red,
                  size: 40,
                ))
          ],
        );
      },
    );
  }
}
