import 'package:flutter/material.dart';

@immutable
class Message {
  final String senderId;
  final String messageId;
  final String text;

  const Message({
    required this.senderId,
    required this.messageId,
    required this.text,
  });

  bool isFrom(String uid) => senderId == uid;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        senderId: json["senderId"],
        messageId: json["messageId"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "messageId": messageId,
        "text": text,
      };

  Message copyWith({
    String? senderId,
    String? messageId,
    String? text,
  }) =>
      Message(
        senderId: senderId ?? this.senderId,
        messageId: messageId ?? this.messageId,
        text: text ?? this.text,
      );
}
