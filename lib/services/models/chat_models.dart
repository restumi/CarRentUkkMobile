class ChatMessage {
  final int id;
  final int senderId;
  final int receiverId;
  // bool isRead;
  final String message;
  final String createdAt;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.createdAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      message: json['message'],
      createdAt: json['created_at'],
    );
  }
}