import 'package:example_one/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../core/my_custom_text_field.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

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
              child: const Text('Sign Up'),
              onPressed: () {
                // Navigator.of(context).popAndPushNamed(AppRoutes.home);
              },
            ),
            ElevatedButton(
              child: const Text('Already have an account? Sign In'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
