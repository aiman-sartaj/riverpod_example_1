import 'package:example_one/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../core/my_custom_text_field.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MyCustomTextField(
              hintText: 'Email',
            ),
            const SizedBox(height: 20),
            const MyCustomTextField(
              hintText: 'Password',
              isObsecure: true,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              child: const Text('Sign In'),
              onPressed: () {
                Navigator.of(context).popAndPushNamed(AppRoutes.home);
              },
            ),
            ElevatedButton(
              child: const Text('CHAT'),
              onPressed: () {
                Navigator.of(context).popAndPushNamed(AppRoutes.chat);
              },
            ),
          ],
        ),
      ),
    );
  }
}
