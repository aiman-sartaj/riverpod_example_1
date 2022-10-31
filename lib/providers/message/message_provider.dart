import 'dart:async';

import 'package:chat_app/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/message.dart';

class MessagesProvider extends StateNotifier<List<Message>> {
  MessagesProvider() : super([]);

  final FirebaseServices _firebaseServices = FirebaseServices();

  void _sendMessage(Message message) {
    state = [...state, message];
    _firebaseServices.sendMessage(message.receiverId, message.text);
  }

  void sendMessage(String text, String receiverId) {
    if (text.isNotEmpty) {
      _sendMessage(
        Message(
            messageId: DateTime.now().millisecondsSinceEpoch.toString(),
            text: text,
            senderId: _firebaseServices.username,
            receiverId: receiverId),
      );
    }
  }
}

final messagesProvider = StateNotifierProvider<MessagesProvider, List<Message>>(
    (ref) => MessagesProvider());

final futureProvider = FutureProvider<MessagesProvider>((ref) async {
  return MessagesProvider();
});

final allChatsProvider = StreamProvider.autoDispose<Iterable<Message>>(
  (ref) {
    final controller = StreamController<Iterable<Message>>();
    final FirebaseServices _firebaseServices = FirebaseServices();

    final sub = FirebaseFirestore.instance
        .collection("conversations")
        .snapshots()
        .listen(
      (snapshots) {
        final messages = snapshots.docs.map(
          (doc) => Message(
              messageId: doc.id,
              senderId: _firebaseServices.username,
              receiverId: "",
              text: doc.id),
        );
        controller.sink.add(messages);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
