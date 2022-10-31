import 'package:flutter/material.dart';

@immutable
class Message {
  final String senderId;
  final String messageId;
  final String text;
  final String receiverId;

  const Message({
    required this.senderId,
    required this.receiverId,
    required this.messageId,
    required this.text,
  });

  bool isFrom(String uid) => senderId == uid;

  Message copyWith({
    String? senderId,
    String? receiverId,
    String? messageId,
    String? text,
  }) =>
      Message(
        senderId: senderId ?? this.senderId,
        receiverId: receiverId ?? this.receiverId,
        messageId: messageId ?? this.messageId,
        text: text ?? this.text,
      );
}
