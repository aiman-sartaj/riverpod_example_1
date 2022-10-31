import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FirebaseServices {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  CollectionReference conversations =
      FirebaseFirestore.instance.collection('conversations');

  String get username {
    return _auth.currentUser!.uid;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  DateTime currentDate = DateTime.now(); //DateTime

  Future<void> saveToCollection(String email, String name) async {
    return users
        .doc(_auth.currentUser!.uid)
        .set({
          "id": _auth.currentUser!.uid,
          "email": email,
          "name": name,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> createChat(String senderId, String receiverId) async {
    return chats
        .doc("$senderId:$receiverId")
        .set({
          "id": "$senderId:$receiverId",
          "last_message": "",
          "unread_count": 0,
        })
        .then((value) => print("Chat created"))
        .catchError((error) => print("Failed to create chat: $error"));
  }

  Future<void> sendMessage(String receiverId, String message) async {
    var uuid = const Uuid();
    return conversations
        .add({
          "id": _auth.currentUser!.uid + uuid.v4(),
          "chat_id": "${_auth.currentUser!.uid}:$receiverId",
          "message": message,
          "sender_id": username,
          "receiver_id": receiverId,
          "time_stamp": Timestamp.fromDate(currentDate)
        })
        .then((value) => print("Message send"))
        .catchError((error) => print("Failed to send message: $error"));
  }

  Future<void> updateChat(String message) async {
    return chats
        .doc()
        .update({
          "last_message": message,
          "time_stamp": Timestamp.fromDate(currentDate)
        })
        .then((value) => print("Chat updated"))
        .catchError((error) => print("Failed to update chat: $error"));
  }

  Stream<QuerySnapshot<Object?>> get messages => FirebaseFirestore.instance
      .collection('conversations')
      .orderBy("time_stamp", descending: true)
      .snapshots();

  Future<String> getReceiver(String id) async {
    String newString = id.replaceRange(0, 28, "");

    await FirebaseFirestore.instance
        .collection('users')
        .where("id", isEqualTo: newString)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["name"]);
        newString = doc["name"];
      });
    });

    print(newString);

    return newString;
  }

  Stream<QuerySnapshot<Object?>> get allChats => FirebaseFirestore.instance
      .collection('chats')
      .orderBy("time_stamp", descending: true)
      .snapshots();

  Stream<QuerySnapshot<Object?>> get allUsers =>
      FirebaseFirestore.instance.collection('users').snapshots();
}
