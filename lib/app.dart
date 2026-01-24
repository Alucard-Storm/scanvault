import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'providers/locale_provider.dart';
import 'providers/theme_provider.dart';
import 'theme/app_theme.dart';
import 'widgets/scaffold_with_navbar.dart';
import 'screens/home/home_screen.dart';
import 'screens/camera/camera_screen.dart';
import 'screens/editor/editor_screen.dart';
import 'screens/document_viewer/document_viewer_screen.dart';
import 'screens/ocr/ocr_screen.dart';
import 'screens/folders/folders_screen.dart';
import 'screens/folders/folder_detail_screen.dart';
import 'screens/settings/settings_screen.dart';
import 'screens/translation/translation_screen.dart';

/// Main application widget
class ScanVaultApp extends ConsumerWidget {
  const ScanVaultApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    print('ScanVaultApp: Rebuilding with locale ${locale.languageCode}');

    return MaterialApp.router(
      title: 'ScanVault',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: locale,
      routerConfig: _router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// App router configuration
final _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    // Shell Route for persistent bottom navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavbar(navigationShell: navigationShell);
      },
      branches: [
        // Home Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        // Folders Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/folders',
              name: 'folders',
              builder: (context, state) => const FoldersScreen(),
              routes: [
                GoRoute(
                  path: ':folderId',
                  name: 'folder-detail',
                  builder: (context, state) {
                    final folderId = state.pathParameters['folderId']!;
                    return FolderDetailScreen(folderId: folderId);
                  },
                ),
              ],
            ),
          ],
        ),
        // Settings Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              name: 'settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),

    // Camera - Scan new document (Full screen, no navbar)
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/camera',
      name: 'camera',
      builder: (context, state) => const CameraScreen(),
    ),

    // Editor - Edit scanned image
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/editor/:pageId',
      name: 'editor',
      builder: (context, state) {
        final pageId = state.pathParameters['pageId']!;
        final imagePath = state.extra as String?;
        return EditorScreen(pageId: pageId, imagePath: imagePath);
      },
    ),

    // Document viewer
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/document/:documentId',
      name: 'document',
      builder: (context, state) {
        final documentId = state.pathParameters['documentId']!;
        return DocumentViewerScreen(documentId: documentId);
      },
    ),

    // OCR results
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/ocr/:documentId',
      name: 'ocr',
      builder: (context, state) {
        final documentId = state.pathParameters['documentId']!;
        final args = state.extra as Map<String, dynamic>? ?? {};
        final imageUrl = args['imageUrl'] as String?;
        final initialText = args['initialText'] as String?;
        final pageId = args['pageId'] as String?;
        
        return OcrScreen(
          documentId: documentId,
          imageUrl: imageUrl, 
          initialText: initialText,
          pageId: pageId,
        );
      },
    ),

    // Translation
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/translation',
      name: 'translation',
      builder: (context, state) {
        final text = state.extra as String?;
        return TranslationScreen(initialText: text);
      },
    ),
  ],
);
