import 'package:flutter/material.dart';

void loading(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) => const AlertDialog(
            content: Center(
              child: CircularProgressIndicator(),
            ),
          ));
}

void notLoading(BuildContext context) {
  Navigator.pop(context);
}
