part of '../result_screen.dart';

class VideoFrontWidget extends StatelessWidget {
  const VideoFrontWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ResultBloc, ResultState, VideoPlayerController?>(
      selector: (state) => state.frontController,
      builder: (context, frontController) {
        if (frontController == null) {
          return const SizedBox();
        }

        return Stack(
          children: [
            AspectRatio(
              aspectRatio: frontController.value.aspectRatio,
              child: VideoPlayer(frontController),
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
