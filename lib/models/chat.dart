import '../utils/date.dart';

class ChatField {
  static String lastMessageTime = 'last_message_time';
}

class Chat {
  final String chatId;
  final String lastMessage;
  final DateTime lastMessageTime;

  Chat({
    required this.chatId,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  Chat copyWith({
    required String chatId,
    required String lastMessage,
    required DateTime lastMessageTime,
  }) =>
      Chat(
          chatId: chatId,
          lastMessage: lastMessage,
          lastMessageTime: lastMessageTime);

  static Chat fromJson(Map<String, dynamic> json) => Chat(
        chatId: json['id'],
        lastMessage: json['last_message'],
        lastMessageTime: DateTimeNow.toDateTime(json['last_message_time'])!,
      );

  Map<String, dynamic> toJson() => {
        'id': chatId,
        'last_message': lastMessage,
        'last_message_time': DateTimeNow.fromDateTimeToJson(lastMessageTime),
      };
}
