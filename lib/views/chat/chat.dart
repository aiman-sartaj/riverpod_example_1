import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wolfizutils/wolfizutils.dart';

import '../../providers/message/message_provider.dart';
import '../../routes/app_routes.dart';
import '../../services/firestore.dart';
import '../../utils/colors.dart';

class Chat extends ConsumerWidget {
  Chat({super.key});

  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SizedBox(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyText(
                text: "Chats",
                fontClr: AppColors.primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firebaseServices.allUsers,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading...');
                    }

                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return data["id"] != _firebaseServices.myUserId
                            ? ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                                title: MyText(
                                  text: "${data["name"]}",
                                  fontClr: AppColors.primaryColor,
                                  fontSize: 12,
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.conversation,
                                      arguments: data["id"]);
                                },
                              )
                            : Container();
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
