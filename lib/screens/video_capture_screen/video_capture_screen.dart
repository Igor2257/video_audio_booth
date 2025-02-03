import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_audio_booth/bloc/camera_bloc/camera_bloc.dart';

part 'components/back_camera_widget.dart';
part 'components/front_camera_widget.dart';
part 'components/start_pause_button_widget.dart';

class VideoCaptureScreen extends StatelessWidget {
  const VideoCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraBloc()..add(LoadData()),
      child: BlocListener<CameraBloc, CameraState>(
        listener: (context, state) {
          if (state.error.isNotEmpty) {
            Fluttertoast.showToast(msg: state.error);
            BlocProvider.of<CameraBloc>(context).add(ClearError());
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Запис'),
          ),
          body: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Stack(
              children: [
                ColoredBox(
                  color: Colors.black26,
                  child: AndroidView(
                    viewType: 'camera-view',
                    creationParams: {},
                    creationParamsCodec: const StandardMessageCodec(),
                  ),
                ),
                StartPauseButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
