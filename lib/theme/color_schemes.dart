import 'package:flutter/material.dart';

/// Color schemes for Material 3 theming
class ColorSchemes {
  ColorSchemes._();

  // Primary seed color - Teal
  static const Color _primarySeed = Color(0xFF00897B);

  /// Light color scheme
  static final ColorScheme light = ColorScheme.fromSeed(
    seedColor: _primarySeed,
    brightness: Brightness.light,
  ).copyWith(
    // Override specific colors for better control
    primary: const Color(0xFF00695C),
    onPrimary: Colors.white,
    primaryContainer: const Color(0xFFB2DFDB),
    onPrimaryContainer: const Color(0xFF00251A),
    secondary: const Color(0xFF5C6BC0),
    onSecondary: Colors.white,
    secondaryContainer: const Color(0xFFE8EAF6),
    onSecondaryContainer: const Color(0xFF1A237E),
    tertiary: const Color(0xFFFF7043),
    onTertiary: Colors.white,
    tertiaryContainer: const Color(0xFFFFCCBC),
    onTertiaryContainer: const Color(0xFF4E342E),
    error: const Color(0xFFD32F2F),
    onError: Colors.white,
    errorContainer: const Color(0xFFFFCDD2),
    onErrorContainer: const Color(0xFF7F0000),
    surface: const Color(0xFFFAFDFC),
    onSurface: const Color(0xFF1A1C1B),
    surfaceContainerLowest: Colors.white,
    surfaceContainerLow: const Color(0xFFF4F7F6),
    surfaceContainer: const Color(0xFFEEF1F0),
    surfaceContainerHigh: const Color(0xFFE8EBEA),
    surfaceContainerHighest: const Color(0xFFE3E6E4),
    onSurfaceVariant: const Color(0xFF444846),
    outline: const Color(0xFF747876),
    outlineVariant: const Color(0xFFC4C8C6),
  );

  /// Dark color scheme
  static final ColorScheme dark = ColorScheme.fromSeed(
    seedColor: _primarySeed,
    brightness: Brightness.dark,
  ).copyWith(
    // Override specific colors for better control
    primary: const Color(0xFF4DB6AC),
    onPrimary: const Color(0xFF00332C),
    primaryContainer: const Color(0xFF004D44),
    onPrimaryContainer: const Color(0xFFB2DFDB),
    secondary: const Color(0xFF9FA8DA),
    onSecondary: const Color(0xFF1A237E),
    secondaryContainer: const Color(0xFF3949AB),
    onSecondaryContainer: const Color(0xFFE8EAF6),
    tertiary: const Color(0xFFFFAB91),
    onTertiary: const Color(0xFF4E342E),
    tertiaryContainer: const Color(0xFFBF360C),
    onTertiaryContainer: const Color(0xFFFFCCBC),
    error: const Color(0xFFEF5350),
    onError: const Color(0xFF7F0000),
    errorContainer: const Color(0xFFC62828),
    onErrorContainer: const Color(0xFFFFCDD2),
    surface: const Color(0xFF121413),
    onSurface: const Color(0xFFE3E6E4),
    surfaceContainerLowest: const Color(0xFF0D0F0E),
    surfaceContainerLow: const Color(0xFF1A1C1B),
    surfaceContainer: const Color(0xFF1E201F),
    surfaceContainerHigh: const Color(0xFF282A29),
    surfaceContainerHighest: const Color(0xFF333534),
    onSurfaceVariant: const Color(0xFFC4C8C6),
    outline: const Color(0xFF8E9290),
    outlineVariant: const Color(0xFF444846),
  );

  // Additional app-specific colors
  static const Color scanOverlayLight = Color(0x8000897B);
  static const Color scanOverlayDark = Color(0x804DB6AC);
  static const Color edgeHighlight = Color(0xFF00E676);
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningOrange = Color(0xFFFF9800);
}
