import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/constants/strings.dart';
import '../../providers/theme_provider.dart';
import '../../services/storage_service.dart';

/// Settings screen
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
      ),
      body: ListView(
        children: [
          // Appearance section
          _buildSectionHeader(context, 'Appearance'),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: const Text('Theme'),
            subtitle: Text(_getThemeModeName(themeMode)),
            onTap: () {
              _showThemePicker(context, ref, themeMode);
            },
          ),
          const Divider(),

          // Storage section
          _buildSectionHeader(context, 'Storage'),
          Consumer(
            builder: (context, ref, _) {
              final storageService = ref.watch(storageServiceProvider);
              final customPath = storageService.getCustomStoragePath();
              
              return ListTile(
                leading: const Icon(Icons.storage_outlined),
                title: const Text('Storage location'),
                subtitle: Text(customPath ?? 'Internal storage (Default)'),
                onTap: () async {
                  await _showStoragePicker(context, ref);
                },
                trailing: customPath != null 
                    ? IconButton(
                        icon: const Icon(Icons.restore),
                        tooltip: 'Reset to default',
                        onPressed: () async {
                           await storageService.resetToDefault();
                            // Force rebuild is tricky as provider holds instance, but shared prefs updated
                            // We might need a stateful provider or just setState if we were stateful
                            // But here we are just reading path directly from service which reads from prefs (if implemented that way)
                            // Ah, getCustomStoragePath reads from prefs object which is updated.
                            // But to trigger UI rebuild we need to notify listeners or set state.
                            // Since StorageService is not a notifier, we should probably wrap the path in a StateProvider 
                            // or just use setState if we convert to StatefulWidget. 
                            // For simplicity, let's use a specialized method to refresh or Force Rebuild.
                            // Actually, let's convert SettingsScreen to StatefulWidget for easier UI update or use a Stream/StateProvider.
                            // However, simplest is:
                            (context as Element).markNeedsBuild(); 
                        },
                      )
                    : const Icon(Icons.chevron_right),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.cleaning_services_outlined),
            title: const Text('Clear cache'),
            subtitle: const Text('Free up space'),
            onTap: () => _showClearCacheDialog(context),
          ),
          const Divider(),

          // About section
          _buildSectionHeader(context, 'About'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Version'),
            subtitle: const Text('1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text('Licenses'),
            onTap: () {
              showLicensePage(context: context);
            },
          ),
        ],
      ),
    );
  }

  void _showThemePicker(BuildContext context, WidgetRef ref, ThemeMode current) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Choose Theme'),
        children: [
          _buildThemeOption(context, ref, 'System Default', ThemeMode.system, current),
          _buildThemeOption(context, ref, 'Light', ThemeMode.light, current),
          _buildThemeOption(context, ref, 'Dark', ThemeMode.dark, current),
        ],
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, WidgetRef ref, String label, ThemeMode mode, ThemeMode current) {
    return ListTile(
      title: Text(label),
      leading: Radio<ThemeMode>(
        value: mode,
        groupValue: current,
        onChanged: (value) {
          if (value != null) {
            ref.read(themeModeProvider.notifier).setThemeMode(value);
            Navigator.pop(context);
          }
        },
      ),
      onTap: () {
        ref.read(themeModeProvider.notifier).setThemeMode(mode);
        Navigator.pop(context);
      },
    );
  }

  String _getThemeModeName(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.system => 'System Default',
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark',
    };
  }
  
  Future<void> _showClearCacheDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('This will delete temporary files. Your saved documents will NOT be deleted. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              await _clearCache(context);
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
  
  Future<void> _clearCache(BuildContext context) async {
    try {
      final tempDir = await getTemporaryDirectory();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
        if (context.mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cache cleared successfully')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to clear cache: $e')),
          );
      }
    }
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
  Future<void> _showStoragePicker(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Storage Location'),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'default'),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Default (Internal)'),
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'custom'),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Select Custom Folder...'),
            ),
          ),
        ],
      ),
    );

    if (result == 'default') {
      await ref.read(storageServiceProvider).resetToDefault();
       if (context.mounted) (context as Element).markNeedsBuild();
    } else if (result == 'custom') {
      final String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory != null) {
        // Verify we can write to it
        try {
          final testFile = File('$selectedDirectory/.test');
          await testFile.writeAsString('test');
          await testFile.delete();
          
          await ref.read(storageServiceProvider).setCustomStoragePath(selectedDirectory);
           if (context.mounted) (context as Element).markNeedsBuild();
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Cannot write to this folder: $e')),
            );
          }
        }
      }
    }
  }
}
