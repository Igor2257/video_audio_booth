import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:video_audio_booth/bloc/app_bloc/app_bloc.dart';
import 'package:video_audio_booth/bloc/login_bloc/login_bloc.dart';
import 'package:video_audio_booth/bloc/text_classification_bloc/text_classification_bloc.dart'
    as tcb;
import 'package:video_audio_booth/firebase_options.dart';
import 'package:video_audio_booth/utils/navigation/app_routes.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(),
        ),
        BlocProvider(
          create: (context) => tcb.TextClassificationBloc()
            ..add(tcb.LoadData()),
        ),
        BlocProvider(
          create: (context) => LoginBloc()..add(LoadData()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: AppRoutes.getAppRoutes,
        initialRoute: AppRoutes.splashScreen,
      ),
    );
  }
}
