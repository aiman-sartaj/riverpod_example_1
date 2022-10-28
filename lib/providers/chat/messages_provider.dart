import 'dart:math';

import 'package:example_one/extensions/immuteable_list_methods.dart';
import 'package:example_one/models/message/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesProvider extends StateNotifier<List<Message>> {
  MessagesProvider() : super([]);

  void _addMessage(Message message) {
    state = state.withNew(message);
  }

  void _removeMessage(Message message) {
    // state = state.where((m) => m.messageId != message.messageId).toList();
    state = state.withRemoved(message, test: (m) => m.messageId == message.messageId);
  }

  void _updateMessage(Message message) {
    state = state.updateWith(message, test: (m) => m.messageId == message.messageId);
  }

  void sendMessage(String text) {
    final random = Random();
    var value = random.nextInt(3);
    if (value == 0) {
      value = 1;
    }

    if (text.isNotEmpty) {
      _addMessage(
        Message(
          messageId: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          senderId: '$value',
        ),
      );
    }
  }
}

final messagesProvider = StateNotifierProvider<MessagesProvider, List<Message>>((ref) => MessagesProvider());
