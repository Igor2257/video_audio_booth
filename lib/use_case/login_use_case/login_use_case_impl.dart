import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_audio_booth/domain/repository/login_repository/login_repository_impl.dart';
import 'package:video_audio_booth/use_case/entity/result.dart';

import 'login_use_case.dart';

class LoginUseCaseImpl implements LoginUseCase {
  factory LoginUseCaseImpl() => instance;

  LoginUseCaseImpl._();

  static final LoginUseCaseImpl instance = LoginUseCaseImpl._();

  final _loginRepositoryImpl = LoginRepositoryImpl.instance;

  @override
  Future<Result<User?>> createUserWithEmailAndPassword(
      String email, String password) async {
    return await _loginRepositoryImpl.createUserWithEmailAndPassword(
        email, password);
  }

  @override
  Future<Result<User?>> signInWithApple() async {
    return await _loginRepositoryImpl.signInWithApple();
  }

  @override
  Future<Result<User?>> signInWithEmailAndPassword(
      String email, String password) async {
    return await _loginRepositoryImpl.signInWithEmailAndPassword(
        email, password);
  }

  @override
  Future<Result<User?>> signInWithGoogle() async {
    return await _loginRepositoryImpl.signInWithGoogle();
  }
}
