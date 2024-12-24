part of '../login_screen.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginBloc, LoginState, TextEditingController?>(
      selector: (state) {
        return state.email;
      },
      builder: (context, email) {
        if (email == null) {
          return const SizedBox();
        }
        return TextField(
          controller: email,
          decoration: const InputDecoration(labelText: "Email"),
        );
      },
    );
  }
}
