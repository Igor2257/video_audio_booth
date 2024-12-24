part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoadData extends LoginEvent{
  LoadData();
}

class StartLogin extends LoginEvent{
  StartLogin();
}

class StartLoginWithGoogle extends LoginEvent{
  StartLoginWithGoogle();
}

class StartLoginWithApple extends LoginEvent{
  StartLoginWithApple();
}

class LoadDataToLogin extends LoginEvent{
  LoadDataToLogin();
}

class Register extends LoginEvent{
  Register();
}

class ChangeUser extends LoginEvent{
  final User user;

  ChangeUser({required this.user});
}
