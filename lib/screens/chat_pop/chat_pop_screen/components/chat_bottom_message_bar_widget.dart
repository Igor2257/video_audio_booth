part of '../chat_pop_screen.dart';

class ChatBottomMessageBarWidget extends StatelessWidget {
  const ChatBottomMessageBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ChatBloc, ChatState, TextEditingController?>(
      selector: (state) {
       return state.messageTextEditingController;
      },
      builder: (context, state) {
        if(state==null) return const SizedBox();
        return Container(
          color: Colors.grey,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: state,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 1,
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintMaxLines: 1,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10),
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 0.2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          color: Colors.black26,
                          width: 0.2,
                        ),
                      ),
                      labelText: "Введіть ваш текст",
                    labelStyle: const TextStyle(color: Colors.red)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: InkWell(
                  child: const Icon(
                    Icons.send,

                    size: 24,
                  ),
                  onTap: () {
                    BlocProvider.of<ChatBloc>(context).add(SendNewMessage());
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
