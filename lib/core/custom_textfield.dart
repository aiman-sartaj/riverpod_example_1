import 'package:flutter/material.dart';

class MyCustomTextField extends StatelessWidget {
  const MyCustomTextField(
      {super.key,
      this.hintText,
      this.controller,
      this.isObsecure,
      this.keyboardType});

  final String? hintText;
  final TextEditingController? controller;
  final bool? isObsecure;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObsecure ?? false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
      ),
    );
  }
}
