import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/auth.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);
  final auth = Auth();

  void setUser(User user) {
    state = user;
  }

  void logout() {
    state = null;
    auth.logout();
  }

  bool isAlreadyLoggedIn() {
    return false;
  }

  Future<void> loadCurrentUser() async {
    state = await auth.curentUser();
  }

  Future<User> createUser(
      {required String email, required String password}) async {
    final user = await auth.signUp(email, password);
    setUser(user);
    return user;
  }

  Future<User> login({required String email, required String password}) async {
    final user = await auth.signIn(email, password);
    setUser(user);

    return user;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});
