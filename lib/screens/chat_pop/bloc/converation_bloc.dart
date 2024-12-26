import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'converation_event.dart';
part 'converation_state.dart';

class ConverationBloc extends Bloc<ConverationEvent, ConverationState> {
  ConverationBloc() : super(ConverationInitial()) {
    on<ConverationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
