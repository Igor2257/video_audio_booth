import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_overlay_event.dart';
part 'chat_overlay_state.dart';

class ChatOverlayBloc extends Bloc<ChatOverlayEvent, ChatOverlayState> {
  ChatOverlayBloc() : super(ChatOverlayInitial()) {
    on<ChatOverlayEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
