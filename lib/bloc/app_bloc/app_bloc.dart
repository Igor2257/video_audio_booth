import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState()) {
    on<ChangePage>(_onChangePage);
  }



  FutureOr<void> _onChangePage(ChangePage event, Emitter<AppState> emit) {
    emit(state.copyWith(currentIndex: event.newPage));
  }
}
