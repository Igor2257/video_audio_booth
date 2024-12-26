class ConversationEntity {
  final String id;
  final String name;
  String lastMessage;
  DateTime lastMessageDateTime;
  bool isMustBeOnTop;

  ConversationEntity(
      {required this.id,
      required this.name,
      required this.lastMessage,
      required this.lastMessageDateTime,
      required this.isMustBeOnTop});
}
