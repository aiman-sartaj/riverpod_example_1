import 'package:chat_app/providers/message/message_provider.dart';
import 'package:chat_app/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolfizutils/wolfizutils.dart';

import '../../utils/colors.dart';

class ConversationView extends ConsumerWidget {
  ConversationView({super.key});
  final FirebaseServices _firebaseServices = FirebaseServices();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: StreamBuilder<QuerySnapshot>(
            stream: _firebaseServices.messages,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading...");
              }
              return Column(
                children: [
                  40.hb,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.chevron_left),
                      ),
                      MyText(
                          text: "$args",
                          fontSize: 12,
                          fontClr: AppColors.primaryColor)
                    ],
                  ),
                  30.hb,
                  Expanded(
                      child: ListView(
                    reverse: true,
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return data['chat_id']
                                  .toString()
                                  .contains(_firebaseServices.username) &&
                              data['chat_id']
                                  .toString()
                                  .contains(args.toString())
                          ? Container(
                              child: data["sender_id"] ==
                                      _firebaseServices.username
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 8.h, left: 100.w),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(16.r),
                                          ),
                                          child: MyText(
                                              text: "${data["message"]}",
                                              fontSize: 14,
                                              fontClr: Colors.white),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 8.h, right: 100.w),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: AppColors.backgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(16.r),
                                          ),
                                          child: MyText(
                                              text: "${data["message"]}",
                                              fontSize: 14,
                                              fontClr: Colors.black),
                                        ),
                                      ],
                                    ),
                            )
                          : Container();
                    }).toList(),
                  )),
                  20.hb,
                  TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        onPressed: () {
                          ref.read(messagesProvider.notifier).sendMessage(
                              messageController.text, args.toString());
                          messageController.clear();

                          _firebaseServices.updateChat(messageController.text);
                        },
                        icon: const Icon(Icons.send),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  10.hb
                ],
              );
            }),
      ),
    );
  }
}
