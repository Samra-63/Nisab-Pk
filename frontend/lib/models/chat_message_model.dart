class ChatMessage {
  final String text;
  final bool isUser;
  final List<int> citations;
  final String? subject;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    this.citations = const [],
    this.subject,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
