part of '../login_screen.dart';

class AppleButtonWidget extends StatelessWidget {
  const AppleButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(onPressed: (){
            BlocProvider.of<LoginBloc>(context).add(StartLoginWithApple());
          }, child: const Text("Apple")),
        ),
      ],
    );
  }
}
