import 'package:chat_app/utils/date.dart';
import 'package:flutter/material.dart';

@immutable
class Message {
  final String senderId;
  final String messageId;
  final String text;
  final String receiverId;
  final DateTime createdAt;

  const Message(
      {required this.senderId,
      required this.receiverId,
      required this.messageId,
      required this.text,
      required this.createdAt});

  static Message fromJson(Map<String, dynamic> json) => Message(
        messageId: json['id'],
        senderId: json['sender_id'],
        receiverId: json['receiver_id'],
        text: json['message'],
        createdAt: DateTimeNow.toDateTime(json['createdAt'])!,
      );

  Map<String, dynamic> toJson() => {
        'id': messageId,
        'sender_id': senderId,
        'receiver_id': receiverId,
        'message': text,
        'createdAt': DateTimeNow.fromDateTimeToJson(createdAt),
      };
}
