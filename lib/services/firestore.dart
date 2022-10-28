import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> saveToCollection(String email, String name) async {
    return users
        .add({
          "email": email,
          "name": name,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
