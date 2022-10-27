import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/chat/messages_provider.dart';
import '../../providers/chat/to_user_provider.dart';

class ChatView extends ConsumerWidget {
  ChatView({super.key});

  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final toUser = ref.watch(toUserProvider('1'));
          return toUser.when(
            data: (user) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.imgUrl),
                    radius: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(user.name),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Consumer(
                      builder: (context, ref, child) {
                        final messages = ref.watch(messagesProvider);
                        return ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final isFromMe = messages[index].isFrom('2');
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: isFromMe ? Colors.blue : Colors.grey,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                messages[index].text,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: const InputDecoration(
                            hintText: 'Type a message',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          ref.read(messagesProvider.notifier).sendMessage(messageController.text);
                          messageController.clear();
                        },
                        icon: const Icon(Icons.send),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => const Center(child: Text('Error')),
          );
        },
      ),
    );
  }
}
