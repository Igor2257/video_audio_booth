part of 'login_bloc.dart';

@immutable
class LoginState {
  final TextEditingController? email;
  final TextEditingController? password;

  final String error;

  final User? user;

  const LoginState({
    this.email,
    this.password,
    this.user,
    this.error = '',
  });

  LoginState copyWith({
    TextEditingController? email,
    TextEditingController? password,
    String? error,
    User? user,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}
