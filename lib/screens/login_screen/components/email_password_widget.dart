part of '../login_screen.dart';

class EmailPasswordWidget extends StatelessWidget {
  const EmailPasswordWidget({super.key, required this.registerOrSingIn});

  final RegisterOrSingIn registerOrSingIn;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const EmailTextField(),
        const SizedBox(height: 16),
        const PasswordTextField(),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    switch (registerOrSingIn) {
                      case RegisterOrSingIn.register:
                        BlocProvider.of<LoginBloc>(context).add(Register());
                        break;
                      case RegisterOrSingIn.signIn:
                        BlocProvider.of<LoginBloc>(context).add(StartLogin());
                        break;
                    }
                  },
                  child: Text(registerOrSingIn == RegisterOrSingIn.register
                      ? "Register"
                      : "Login")),
            ),
          ],
        ),
      ],
    );
  }
}
