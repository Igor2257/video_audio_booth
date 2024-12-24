part of '../login_screen.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, TextEditingController?>(
      selector: (state) {
        return state.password;
      },
      builder: (context, password) {
        if (password == null) {
          return const SizedBox();
        }
        return TextField(
          controller: password,
          decoration: const InputDecoration(labelText: "Password"),
        );
      },
    );
  }
}
