import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_audio_booth/use_case/entity/result.dart';

abstract class LoginData {
  Future<Result<User?>> createUserWithEmailAndPassword(
      String email, String password);

  Future<Result<User?>> signInWithEmailAndPassword(
      String email, String password);

  Future<Result<User?>> signInWithGoogle();

  Future<Result<User?>> signInWithApple();
}
