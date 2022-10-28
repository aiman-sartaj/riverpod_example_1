import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> signUp(String email, String password) async {
    try {
      final userCred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (userCred.user == null) {
        throw Exception("Could not create user");
      }
      return userCred.user!;
    } on FirebaseAuthException catch (e) {
      print("exception::: $e");
      rethrow;
    } catch (e) {
      print("error $e");
      rethrow;
    }
  }

  Future<User> signIn(String email, String password) async {
    try {
      final userCred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCred.user == null) {
        throw Exception("Could not sign in");
      }
      return userCred.user!;
    } on FirebaseAuthException catch (e) {
      print("exception::: $e");
      rethrow;
    } catch (e) {
      print("error $e");
      rethrow;
    }
  }

  Future<User?> curentUser() async {
    await Future.delayed(const Duration(seconds: 2));
    return _auth.currentUser;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
