part of 'result_bloc.dart';

@immutable
sealed class ResultEvent {}
class LoadData extends ResultEvent{
  LoadData();
}

class PlayVideo extends ResultEvent{
  PlayVideo();
}
