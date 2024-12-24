part of '../result_screen.dart';

class ResultWidget extends StatelessWidget {
  const ResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ResultBloc, ResultState, String>(
      selector: (state) {
        return state.result;
      },
      builder: (context, result) {
        return Text(result);
      },
    );
  }
}
