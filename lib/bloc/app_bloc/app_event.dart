part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

class ChangePage extends AppEvent{
  final int newPage;

  ChangePage({required this.newPage});
}
