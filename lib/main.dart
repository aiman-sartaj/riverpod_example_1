import 'package:example_one/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/theme/theme_provider.dart';

void main(List<String> args) {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, reference, child) {
        final themeMode = reference.watch(themeProvider);
        return MaterialApp(
          routes: AppRoutes.routes,
          initialRoute: AppRoutes.signIn,
          themeMode: themeMode,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
        );
      },
    );
  }
}
