import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_audio_booth/data/login_data/login_data_impl.dart';
import 'package:video_audio_booth/use_case/entity/result.dart';

import 'login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  factory LoginRepositoryImpl() => instance;

  LoginRepositoryImpl._();

  static final LoginRepositoryImpl instance = LoginRepositoryImpl._();
  final _loginDataImpl = LoginDataImpl.instance;

  @override
  Future<Result<User?>> createUserWithEmailAndPassword(
      String email, String password) async {
    return await _loginDataImpl.createUserWithEmailAndPassword(email, password);
  }

  @override
  Future<Result<User?>> signInWithApple() async {
    return await _loginDataImpl.signInWithApple();
  }

  @override
  Future<Result<User?>> signInWithEmailAndPassword(
      String email, String password) async {
    return await _loginDataImpl.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<Result<User?>> signInWithGoogle() async {
    return await _loginDataImpl.signInWithGoogle();
  }
}
