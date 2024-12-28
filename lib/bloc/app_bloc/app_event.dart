part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}
class LoadData extends AppEvent{
  LoadData();
}

class ChangePage extends AppEvent{
  final int newPage;

  ChangePage({required this.newPage});
}
class NewRecognizedText extends AppEvent{
  final String text;

  NewRecognizedText({required this.text});
}