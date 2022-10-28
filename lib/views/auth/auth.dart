import 'package:chat_app/providers/user/user.dart';
import 'package:chat_app/views/home/home.dart';
import 'package:chat_app/views/sign_up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../splash/splash.dart';

class AuthenticationView extends ConsumerStatefulWidget {
  const AuthenticationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AuthenticationViewState();
  }
}

class _AuthenticationViewState extends ConsumerState<AuthenticationView> {
  @override
  void initState() {
    super.initState();
    load();
  }

  var isLoading = true;

  Future<void> load() async {
    await ref.read(userProvider.notifier).loadCurrentUser();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Consumer(
            builder: (context, reference, child) {
              final user = reference.watch(userProvider);
              if (user == null) {
                return SignUp();
              } else {
                return const HomeView();
              }
            },
          )
        : const SplashScreen();
  }
}
