class ChatMessageEntity {
  final String id;
  final String text;
  final bool isTail;
  final bool isSender;
  final bool isSent;
  final String conversationId;
  final DateTime messageSentDateTime;

  ChatMessageEntity({
    required this.id,
    required this.text,
    required this.isTail,
    required this.isSender,
    required this.isSent,
    required this.conversationId,
    required this.messageSentDateTime,
  });
}
