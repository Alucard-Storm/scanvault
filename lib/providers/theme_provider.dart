import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for app theme mode
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system);

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
}

/// Provider for "Use system colors" preference
final systemColorProvider = StateNotifierProvider<SystemColorNotifier, bool>((ref) {
  return SystemColorNotifier();
});

class SystemColorNotifier extends StateNotifier<bool> {
  SystemColorNotifier() : super(false);

  void setUseSystemColor(bool useSystemColor) {
    state = useSystemColor;
  }
}
