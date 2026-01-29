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
          _buildSectionHeader(context, l10n.settingsAppearance),
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
            subtitle: Text(_getThemeModeName(context, themeMode)),
            onTap: () {
              _showThemePicker(context, ref, themeMode);
            },
          ),
          const Divider(),

          // Storage section
          _buildSectionHeader(context, l10n.settingsStorageHeader),
          Consumer(
            builder: (context, ref, _) {
              final storageService = ref.watch(storageServiceProvider);
              final customPath = storageService.getCustomStoragePath();
              
              return ListTile(
                leading: const Icon(Icons.storage_outlined),
                title: Text(l10n.settingsStorage),
                subtitle: Text(customPath ?? l10n.storageInternal),
                onTap: () async {
                  await _showStoragePicker(context, ref);
                },
                trailing: customPath != null 
                    ? IconButton(
                        icon: const Icon(Icons.restore),
                        tooltip: l10n.resetToDefault,
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
            subtitle: Text(l10n.freeUpSpace),
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
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.chooseTheme),
        children: [
          _buildThemeOption(context, ref, l10n.themeSystem, ThemeMode.system, current),
          _buildThemeOption(context, ref, l10n.themeLight, ThemeMode.light, current),
          _buildThemeOption(context, ref, l10n.themeDark, ThemeMode.dark, current),
        ],
      ),
    );
  }
  
  // Updated Helper to use localized strings
  String _getThemeModeName(BuildContext context, ThemeMode mode) {
    final l10n = AppLocalizations.of(context)!;
    return switch (mode) {
      ThemeMode.system => l10n.themeSystem,
      ThemeMode.light => l10n.themeLight,
      ThemeMode.dark => l10n.themeDark,
    };
  }

  // .. _buildThemeOption remains same ..

  Widget _buildThemeOption(BuildContext context, WidgetRef ref, String label, ThemeMode mode, ThemeMode current) {
    return RadioListTile<ThemeMode>(
      title: Text(label),
      value: mode,
      groupValue: current,
      onChanged: (value) {
        if (value != null) {
          ref.read(themeModeProvider.notifier).setThemeMode(value);
          Navigator.pop(context);
        }
      },
    );
  }

  
  Future<void> _showClearCacheDialog(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.clearCacheTitle),
        content: Text(l10n.clearCacheMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              await _clearCache(context);
            },
            child: Text(l10n.clear),
          ),
        ],
      ),
    );
  }
  
  Future<void> _clearCache(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final tempDir = await getTemporaryDirectory();
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
        if (context.mounted) {
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.cacheCleared)),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.cacheClearFailed(e))),
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
    final l10n = AppLocalizations.of(context)!;
    final result = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.storageLocation),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'default'),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(l10n.storageDefault),
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'custom'),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(l10n.storageCustom),
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
              SnackBar(content: Text(l10n.storageWriteError(e))),
            );
          }
        }
      }
    }
  }

  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.chooseLanguage),
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
              Icon(Icons.check, color: Theme.of(context).colorScheme.primary),
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
