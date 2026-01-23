import 'package:flutter/material.dart';
import 'color_schemes.dart';

/// App theme configuration with Material 3 design
class AppTheme {
  AppTheme._();

  /// Light theme
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorSchemes.light,
        brightness: Brightness.light,

        // App bar theme
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 2,
          backgroundColor: ColorSchemes.light.surface,
          foregroundColor: ColorSchemes.light.onSurface,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: ColorSchemes.light.onSurface,
          ),
        ),

        // Card theme
        cardTheme: const CardThemeData(
          elevation: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
        ),

        // Floating action button theme
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 4,
          highlightElevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: ColorSchemes.light.primary,
          foregroundColor: ColorSchemes.light.onPrimary,
        ),

        // Bottom navigation bar theme
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          backgroundColor: ColorSchemes.light.surface,
          selectedItemColor: ColorSchemes.light.primary,
          unselectedItemColor: ColorSchemes.light.onSurfaceVariant,
        ),

        // Navigation bar theme (Material 3)
        navigationBarTheme: NavigationBarThemeData(
          elevation: 0,
          height: 80,
          backgroundColor: ColorSchemes.light.surface,
          indicatorColor: ColorSchemes.light.primaryContainer,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        ),

        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ColorSchemes.light.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: ColorSchemes.light.primary,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),

        // Chip theme
        chipTheme: ChipThemeData(
          elevation: 0,
          pressElevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: ColorSchemes.light.surfaceContainerHighest,
          selectedColor: ColorSchemes.light.primaryContainer,
          labelStyle: TextStyle(
            color: ColorSchemes.light.onSurfaceVariant,
          ),
        ),

        // Dialog theme
        dialogTheme: DialogThemeData(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),

        // Bottom sheet theme
        bottomSheetTheme: BottomSheetThemeData(
          elevation: 8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          backgroundColor: ColorSchemes.light.surface,
        ),

        // Divider theme
        dividerTheme: DividerThemeData(
          color: ColorSchemes.light.outlineVariant,
          thickness: 1,
          space: 1,
        ),
      );

  /// Dark theme
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorSchemes.dark,
        brightness: Brightness.dark,

        // App bar theme
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 2,
          backgroundColor: ColorSchemes.dark.surface,
          foregroundColor: ColorSchemes.dark.onSurface,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: ColorSchemes.dark.onSurface,
          ),
        ),

        // Card theme
        cardTheme: const CardThemeData(
          elevation: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
        ),

        // Floating action button theme
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 4,
          highlightElevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: ColorSchemes.dark.primary,
          foregroundColor: ColorSchemes.dark.onPrimary,
        ),

        // Bottom navigation bar theme
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          backgroundColor: ColorSchemes.dark.surface,
          selectedItemColor: ColorSchemes.dark.primary,
          unselectedItemColor: ColorSchemes.dark.onSurfaceVariant,
        ),

        // Navigation bar theme (Material 3)
        navigationBarTheme: NavigationBarThemeData(
          elevation: 0,
          height: 80,
          backgroundColor: ColorSchemes.dark.surface,
          indicatorColor: ColorSchemes.dark.primaryContainer,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        ),

        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: ColorSchemes.dark.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: ColorSchemes.dark.primary,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),

        // Chip theme
        chipTheme: ChipThemeData(
          elevation: 0,
          pressElevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: ColorSchemes.dark.surfaceContainerHighest,
          selectedColor: ColorSchemes.dark.primaryContainer,
          labelStyle: TextStyle(
            color: ColorSchemes.dark.onSurfaceVariant,
          ),
        ),

        // Dialog theme
        dialogTheme: DialogThemeData(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),

        // Bottom sheet theme
        bottomSheetTheme: BottomSheetThemeData(
          elevation: 8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          backgroundColor: ColorSchemes.dark.surface,
        ),

        // Divider theme
        dividerTheme: DividerThemeData(
          color: ColorSchemes.dark.outlineVariant,
          thickness: 1,
          space: 1,
        ),
      );
}
