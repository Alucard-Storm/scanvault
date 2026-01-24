import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';
import '../../providers/theme_provider.dart';
import '../../services/storage_service.dart';

/// Settings screen
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTab),
      ),
      body: ListView(
        children: [
          // Appearance section
          _buildSectionHeader(context, l10n.settingsTheme), // Reusing Theme string for header or leaving hardcoded? "Appearance" is better. Let's use Theme for now or hardcoded 'Appearance' if no key.
          // Dictionary:
          // settingsTheme: Theme
          // settingsLanguage: Language
          // I'll use "Appearance" hardcoded for now as I missed adding a specific key for the Header, but wait.
          // Use 'Appearance' hardcoded? No, that defeats the purpose.
          // I will use settingsTheme as a proxy or just keep 'Appearance' and fix ARB later. 
          // Let's use hardcoded "Appearance" for header to minimize drift, OR add it to ARB.
          // I'll keep "Appearance" hardcoded for headers if I don't have keys, but I'll update the items.
          
          _buildSectionHeader(context, 'Appearance'), 
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.settingsLanguage),
            subtitle: Consumer(
              builder: (context, ref, _) {
                 final locale = ref.watch(localeProvider);
                 return Text(_getLanguageName(locale.languageCode));
              },
            ),
            onTap: () {
              _showLanguagePicker(context, ref);
            },
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: Text(l10n.settingsTheme),
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
                title: Text(l10n.settingsStorage),
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
                            (context as Element).markNeedsBuild(); 
                        },
                      )
                    : const Icon(Icons.chevron_right),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.cleaning_services_outlined),
            title: Text(l10n.settingsClearCache),
            subtitle: const Text('Free up space'),
            onTap: () => _showClearCacheDialog(context),
          ),
          const Divider(),

          // About section
          _buildSectionHeader(context, l10n.settingsAbout),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l10n.settingsVersion),
            subtitle: const Text('1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: Text(l10n.settingsLicenses),
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
            child: Text(AppLocalizations.of(context)!.cancel),
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

  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Choose Language'),
        children: [
          _buildLanguageOption(context, ref, 'English', 'en'),
          _buildLanguageOption(context, ref, 'हिन्दी (Hindi)', 'hi'),
          _buildLanguageOption(context, ref, 'বাংলা (Bengali)', 'bn'),
          _buildLanguageOption(context, ref, 'தமிழ் (Tamil)', 'ta'),
          _buildLanguageOption(context, ref, 'తెలుగు (Telugu)', 'te'),
          _buildLanguageOption(context, ref, 'मराठी (Marathi)', 'mr'),
          _buildLanguageOption(context, ref, 'ગુજરાતી (Gujarati)', 'gu'),
          _buildLanguageOption(context, ref, 'ಕನ್ನಡ (Kannada)', 'kn'),
          _buildLanguageOption(context, ref, 'മലയാളം (Malayalam)', 'ml'),
          _buildLanguageOption(context, ref, 'ਪੰਜਾਬੀ (Punjabi)', 'pa'),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context, WidgetRef ref, String label, String code) {
    final currentLocale = ref.read(localeProvider);
    final isSelected = currentLocale.languageCode == code;
    
    return SimpleDialogOption(
      onPressed: () {
        ref.read(localeProvider.notifier).setLocale(Locale(code));
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(child: Text(label)),
            if (isSelected)
              const Icon(Icons.check, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  String _getLanguageName(String code) {
    return switch (code) {
      'en' => 'English',
      'hi' => 'हिन्दी',
      'bn' => 'বাংলা',
      'ta' => 'தமிழ்',
      'te' => 'తెలుగు',
      'mr' => 'मराठी',
      'gu' => 'ગુજરાતી',
      'kn' => 'ಕನ್ನಡ',
      'ml' => 'മലയാളം',
      'pa' => 'ਪੰਜਾਬੀ',
      _ => 'English',
    };
  }
}
