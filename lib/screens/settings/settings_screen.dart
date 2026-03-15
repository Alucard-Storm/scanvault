import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';
import '../../providers/theme_provider.dart';
import '../../services/storage_service.dart';
import '../../services/ad_service.dart';

/// Settings screen
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  Future<void> _loadAd() async {
    await AdService().ready;
    if (!mounted) return;

    _nativeAd = AdService().loadNativeAd(
      onAdLoaded: (ad) {
        setState(() {
          _nativeAdIsLoaded = true;
        });
      },
      onAdFailedToLoad: (ad, error) {
        ad.dispose();
        debugPrint('Ad load failed (code=${error.code} message=${error.message})');
      },
    )..load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTab),
      ),
      body: ListView(
        children: [

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
          SwitchListTile(
            secondary: const Icon(Icons.palette_outlined),
            title: Text(l10n.useSystemColor),
            value: ref.watch(systemColorProvider),
            onChanged: (value) {
              ref.read(systemColorProvider.notifier).setUseSystemColor(value);
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
                            // Force rebuild is handled by provider watch usually, but if not we might need setState
                            setState(() {}); 
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
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Developer'),
            subtitle: const Text('Alucard Stormbringer'),
            onTap: () {
              _showDeveloperDialog(context);
            },
          ),
          
          const Divider(),
          
          // Native Ad
          if (_nativeAdIsLoaded && _nativeAd != null)
            Container(
              height: 100, // Small template height
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: AdWidget(ad: _nativeAd!),
            )
          else
            Container(
              height: 100,
              width: double.infinity,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 8),
                    Text('Loading Ad...'),
                  ],
                ),
              ),
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
  
  String _getThemeModeName(BuildContext context, ThemeMode mode) {
    final l10n = AppLocalizations.of(context)!;
    return switch (mode) {
      ThemeMode.system => l10n.themeSystem,
      ThemeMode.light => l10n.themeLight,
      ThemeMode.dark => l10n.themeDark,
    };
  }

  Widget _buildThemeOption(BuildContext context, WidgetRef ref, String label, ThemeMode mode, ThemeMode current) {
    return RadioGroup<ThemeMode>(
      groupValue: current,
      onChanged: (value) {
        if (value != null) {
          ref.read(themeModeProvider.notifier).setThemeMode(value);
          Navigator.pop(context);
        }
      },
      child: RadioListTile<ThemeMode>(
        title: Text(label),
        value: mode,
      ),
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
       if (context.mounted) {
         setState(() {});
       }
    } else if (result == 'custom') {
      final String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory != null) {
        try {
          final testFile = File('$selectedDirectory/.test');
          await testFile.writeAsString('test');
          await testFile.delete();
          
          await ref.read(storageServiceProvider).setCustomStoragePath(selectedDirectory);
           if (context.mounted) {
             setState(() {});
           }
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

  void _showDeveloperDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.person),
            SizedBox(width: 12),
            Text('Developer'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Akshay Sagar',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Assistant Professor, Computer Science & Information Technology, SIRT',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.link),
              title: const Text('GitHub Profile'),
              subtitle: const Text('github.com/Alucard-Storm'),
              onTap: () async {
                final uri = Uri.parse('https://github.com/Alucard-Storm');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.code),
              title: const Text('Source Code'),
              subtitle: const Text('github.com/Alucard-Storm/scanvault'),
              onTap: () async {
                final uri = Uri.parse('https://github.com/Alucard-Storm/scanvault');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
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
