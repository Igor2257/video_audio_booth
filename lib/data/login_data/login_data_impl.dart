import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:video_audio_booth/use_case/entity/result.dart';

import 'login_data.dart';

class LoginDataImpl implements LoginData {
  factory LoginDataImpl() => instance;

  LoginDataImpl._();

  static final LoginDataImpl instance = LoginDataImpl._();

  @override
  Future<Result<User?>> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        return Result.success(credential.user);
      }
      return Result.failure("Fail");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Result.failure('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return Result.failure('The account already exists for that email.');
      }
      return Result.failure(e.message);
    }
  }

  @override
  Future<Result<User?>> signInWithApple() async {
    try {
      final appleProvider = AppleAuthProvider();
      final signInResult =
          await FirebaseAuth.instance.signInWithProvider(appleProvider);
      if (signInResult.user != null) {
        return Result.success(signInResult.user);
      }
      return Result.failure("Fail");
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<User?>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        return Result.success(credential.user);
      }
      return Result.failure("Fail");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Result.failure("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        return Result.failure('Wrong password provided for that user.');
      }
      print("error ${e.message}");
      return Result.failure(e.message);
    }
  }

  @override
  Future<Result<User?>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final signInResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (signInResult.user != null) {
        return Result.success(signInResult.user);
      }
      return Result.failure("Fail");
    } catch (e) {
      print("error ${e.toString()}");
      return Result.failure(e.toString());
    }
  }
}
