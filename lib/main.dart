import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'services/database_service.dart';
import 'services/ad_service.dart';

import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize services
  // Start AdMob initialization in the background (fire-and-forget)
  AdService().initialize();

  // Initialize critical services in parallel
  final results = await Future.wait([
    DatabaseService.initialize(),
    StorageService.init(),
  ]);

  final storageService = results[1] as StorageService;

  runApp(
    ProviderScope(
      overrides: [
        storageServiceProvider.overrideWithValue(storageService),
      ],
      child: const ScanVaultApp(),
    ),
  );
}
