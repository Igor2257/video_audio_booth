import 'package:flutter/material.dart';
import 'package:video_audio_booth/screens/login_screen/login_screen.dart';
import 'package:video_audio_booth/screens/navigation_screen/navigation_screen.dart';
import 'package:video_audio_booth/screens/splash_screen/splash_screen.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';
  static const String navigationScreen = '/navigation_screen';
  static const String registerScreen = '/register_screen';
  static const String splashScreen = '/splash_screen';

  static Map<String, Widget Function(BuildContext)> getAppRoutes = {
    AppRoutes.loginScreen: (context) => const LoginScreen(),
    AppRoutes.navigationScreen: (context) => NavigationScreen(),
    AppRoutes.registerScreen: (context) => const RegisterScreen(),
    AppRoutes.splashScreen: (context) => const SplashScreen(),
  };
}
