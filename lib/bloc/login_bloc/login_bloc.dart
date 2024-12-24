import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_audio_booth/domain/services/auth_service.dart';
import 'package:video_audio_booth/use_case/login_use_case/login_use_case_impl.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoadData>(_onLoadData);
    on<StartLogin>(_onStartLogin);
    on<StartLoginWithGoogle>(_onStartLoginWithGoogle);
    on<StartLoginWithApple>(_onStartLoginWithApple);
    on<LoadDataToLogin>(_onLoadDataToLogin);
    on<Register>(_onRegister);
    on<ChangeUser>(_onChangeUser);
  }

  final _authService = AuthService();
  final _loginUseCaseImpl = LoginUseCaseImpl.instance;

  FutureOr<void> _onLoadData(LoadData event, Emitter<LoginState> emit) {
    _authService.authStateChanges.listen((User? user) {
      if (user == null) {
        add(LoadDataToLogin());
      } else {
        add(ChangeUser(user: user));
      }
    });
  }

  FutureOr<void> _onStartLogin(
      StartLogin event, Emitter<LoginState> emit) async {
    if (state.email == null || state.email!.text.isEmpty) {
      emit(state.copyWith(error: "Почта пустая"));
      return;
    }
    if (state.password == null || state.password!.text.isEmpty) {
      emit(state.copyWith(error: "Пароль пуст"));
      return;
    }
    final result = await _loginUseCaseImpl.signInWithEmailAndPassword(
        state.email!.text, state.password!.text);
    if (result.error != null) {
      emit(state.copyWith(error: result.error!));
      return;
    }
    emit(state.copyWith(user: result.data));
  }

  FutureOr<void> _onStartLoginWithGoogle(
      StartLoginWithGoogle event, Emitter<LoginState> emit) async {
    final result = await _loginUseCaseImpl.signInWithGoogle();
    print("result.data ${result.data}");
    if (result.error != null) {
      emit(state.copyWith(error: result.error!));
      return;
    }
    emit(state.copyWith(user: result.data));
  }

  FutureOr<void> _onStartLoginWithApple(
      StartLoginWithApple event, Emitter<LoginState> emit) async {
    final result = await _loginUseCaseImpl.signInWithApple();
    if (result.error != null) {
      emit(state.copyWith(error: result.error!));
      return;
    }
    emit(state.copyWith(user: result.data));
  }

  FutureOr<void> _onLoadDataToLogin(
      LoadDataToLogin event, Emitter<LoginState> emit) {
    final email = TextEditingController();
    final password = TextEditingController();

    emit(state.copyWith(
      email: email,
      password: password,
    ));
  }

  FutureOr<void> _onRegister(Register event, Emitter<LoginState> emit) async {
    if (state.email == null || state.email!.text.isEmpty) {
      emit(state.copyWith(error: "Почта пустая"));
      return;
    }
    if (state.password == null || state.password!.text.isEmpty) {
      emit(state.copyWith(error: "Пароль пуст"));
      return;
    }
    final result = await _loginUseCaseImpl.createUserWithEmailAndPassword(
        state.email!.text, state.password!.text);
    if (result.error != null) {
      emit(state.copyWith(error: result.error!));
      return;
    }
    emit(state.copyWith(user: result.data));
  }

  FutureOr<void> _onChangeUser(ChangeUser event, Emitter<LoginState> emit) {
    print("event.user ${event.user}");
    emit(state.copyWith(user: event.user));
  }
}
