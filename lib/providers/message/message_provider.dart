import 'dart:async';

import 'package:chat_app/services/firestore.dart';
import 'package:chat_app/utils/date.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../models/message.dart';

class MessagesProvider extends StateNotifier<List<Message>> {
  MessagesProvider() : super([]);

  final FirebaseServices _firebaseServices = FirebaseServices();

  void _sendMessage(Message message) {
    state = [...state, message];
    _firebaseServices.sendMessage(message);
  }

  void sendMessage(String text, String receiverId) {
    if (text.isNotEmpty) {
      var uuid = const Uuid();

      final newMessage = Message(
        messageId: _firebaseServices.myUserId + uuid.v4(),
        senderId: _firebaseServices.myUserId,
        receiverId: receiverId,
        text: text,
        createdAt: DateTime.now(),
      );
      _sendMessage(newMessage);
    }
  }

  // getMessages () {
  //   _firebaseServices.
  // }
}

final messagesProvider = StateNotifierProvider<MessagesProvider, List<Message>>(
    (ref) => MessagesProvider());

final futureProvider = FutureProvider<MessagesProvider>((ref) async {
  return MessagesProvider();
});

final allChatsProvider = StreamProvider.autoDispose<Iterable<Message>>(
  (ref) {
    final controller = StreamController<Iterable<Message>>();
    final FirebaseServices firebaseServices = FirebaseServices();

    final sub = FirebaseFirestore.instance
        .collection("conversations")
        .snapshots()
        .listen(
      (snapshots) {
        final messages = snapshots.docs.map(
          (doc) => Message(
              messageId: doc.id,
              senderId: firebaseServices.myUserId,
              receiverId: "",
              text: doc.id,
              createdAt: DateTime.now()),
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
