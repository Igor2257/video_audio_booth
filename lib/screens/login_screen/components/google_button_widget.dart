part of '../login_screen.dart';

class GoogleButtonWidget extends StatelessWidget {
  const GoogleButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(StartLoginWithGoogle());
              },
              child: const Text("Google")),
        ),
      ],
    );
  }
}
