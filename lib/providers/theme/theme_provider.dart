import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeProviderNotifier extends StateNotifier<ThemeMode> {
  ThemeProviderNotifier() : super(ThemeMode.dark);

  void toggleTheme() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}

final themeProvider = StateNotifierProvider<ThemeProviderNotifier, ThemeMode>((ref) {
  return ThemeProviderNotifier();
});
