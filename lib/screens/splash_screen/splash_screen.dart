import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_audio_booth/bloc/login_bloc/login_bloc.dart';
import 'package:video_audio_booth/bloc/text_classification_bloc/text_classification_bloc.dart';
import 'package:video_audio_booth/bloc/text_classification_bloc/text_classification_bloc.dart';
import 'package:video_audio_booth/utils/navigation/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextClassificationBloc, TextClassificationState>(
      builder: (context, state) {
        print(state.text);
        return BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.user != null) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.navigationScreen,
                    (route) => false,
              );
            } else {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.loginScreen,
                    (route) => false,
              );
            }
          },
          child: const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
