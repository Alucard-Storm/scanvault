import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/folder.dart';
import '../../providers/document_provider.dart';
import '../../services/database_service.dart';
import '../../services/auth_service.dart';
import '../../services/encryption_service.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/folder_icons.dart';

/// Folders management screen
class FoldersScreen extends ConsumerStatefulWidget {
  const FoldersScreen({super.key});

  @override
  ConsumerState<FoldersScreen> createState() => _FoldersScreenState();
}

class _FoldersScreenState extends ConsumerState<FoldersScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foldersAsync = ref.watch(foldersProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.foldersTab),
      ),
      body: foldersAsync.when(
        data: (folders) {
          if (folders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.folder_outlined,
                    size: 80,
                    color: theme.colorScheme.primary.withAlpha(77),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.noFolders,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.0,
            ),
            itemCount: folders.length,
            itemBuilder: (context, index) {
              final folder = folders[index];
              return _FolderGridItem(folder: folder);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'create_folder_fab',
        onPressed: () => _showCreateFolderDialog(context),
        child: const Icon(Icons.create_new_folder_outlined),
      ),
    );
  }

  Future<void> _showCreateFolderDialog(BuildContext context) async {
    final controller = TextEditingController();
    Color selectedColor = Theme.of(context).colorScheme.primary;
    String? selectedIconName; // null means use smart default
    
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,
    ];

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final l10n = AppLocalizations.of(context)!;
          return AlertDialog(
            title: Text(l10n.newFolder),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: l10n.folderName,
                    border: const OutlineInputBorder(),
                  ),
                  autofocus: true,
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 16),
                // Color picker
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: colors.map((color) {
                      final isSelected = selectedColor == color;
                      return GestureDetector(
                        onTap: () => setState(() => selectedColor = color),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: isSelected 
                                ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
                                : null,
                          ),
                          child: isSelected 
                              ? const Icon(Icons.check, size: 16, color: Colors.white)
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                // Icon picker
                Text(
                  'Folder Icon',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 60,
                  width: double.maxFinite,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: FolderIcons.getAvailableIcons().length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // Auto/Smart default option
                        final isSelected = selectedIconName == null;
                        final previewIcon = FolderIcons.getIconData(
                          null,
                          controller.text.isEmpty ? 'Default' : controller.text,
                        );
                        return GestureDetector(
                          onTap: () => setState(() => selectedIconName = null),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 50,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.outlineVariant,
                                width: isSelected ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  previewIcon,
                                  size: 20,
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Auto',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      
                      final iconEntry = FolderIcons.getAvailableIcons()[index - 1];
                      final isSelected = selectedIconName == iconEntry.key;
                      return GestureDetector(
                        onTap: () => setState(() => selectedIconName = iconEntry.key),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 50,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.outlineVariant,
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                iconEntry.value,
                                size: 20,
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                iconEntry.key,
                                style: TextStyle(
                                  fontSize: 9,
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.cancel),
              ),
              FilledButton(
                onPressed: () async {
                  if (controller.text.trim().isNotEmpty) {
                    final folder = Folder(
                      id: DatabaseService.generateId(),
                      name: controller.text.trim(),
                      iconName: selectedIconName,
                      colorValue: selectedColor.toARGB32(),
                      createdAt: DateTime.now(),
                    );
                    
                    await ref.read(foldersProvider.notifier).addFolder(folder);
                    if (context.mounted) Navigator.pop(context);
                  }
                },
                child: Text(l10n.create),
              ),
            ],
          );
        }
      ),
    );
  }
}

class _FolderGridItem extends ConsumerWidget {
  final Folder folder;

  const _FolderGridItem({required this.folder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final color = Color(folder.colorValue);
    final l10n = AppLocalizations.of(context)!;
    
    return InkWell(
      onTap: () {
        context.pushNamed('folder-detail', pathParameters: {'folderId': folder.id});
      },
      onLongPress: () => _showEditDialog(context, ref),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  FolderIcons.getIconData(folder.iconName, folder.name),
                  size: 48,
                  color: color,
                ),
                if (folder.isLocked)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                folder.name,
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.folderItems(folder.documentCount.toString()),
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController(text: folder.name);
    Color selectedColor = Color(folder.colorValue);
    String? selectedIconName = folder.iconName;
    
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,
    ];

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final l10n = AppLocalizations.of(context)!;
          return AlertDialog(
            title: Text(l10n.editFolder),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: l10n.folderName,
                    border: const OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 16),
                // Color picker
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: colors.map((c) {
                      final isSelected = selectedColor == c;
                      return GestureDetector(
                        onTap: () => setState(() => selectedColor = c),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: c,
                            shape: BoxShape.circle,
                            border: isSelected 
                                ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
                                : null,
                          ),
                          child: isSelected 
                              ? const Icon(Icons.check, size: 16, color: Colors.white)
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                // Icon picker
                Text(
                  'Folder Icon',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 60,
                  width: double.maxFinite,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: FolderIcons.getAvailableIcons().length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        // Auto/Smart default option
                        final isSelected = selectedIconName == null;
                        final previewIcon = FolderIcons.getIconData(
                          null,
                          controller.text.isEmpty ? folder.name : controller.text,
                        );
                        return GestureDetector(
                          onTap: () => setState(() => selectedIconName = null),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 50,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.outlineVariant,
                                width: isSelected ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  previewIcon,
                                  size: 20,
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Auto',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      
                      final iconEntry = FolderIcons.getAvailableIcons()[index - 1];
                      final isSelected = selectedIconName == iconEntry.key;
                      return GestureDetector(
                        onTap: () => setState(() => selectedIconName = iconEntry.key),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 50,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.outlineVariant,
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                iconEntry.value,
                                size: 20,
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                iconEntry.key,
                                style: TextStyle(
                                  fontSize: 9,
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  // Handle lock/unlock
                  if (folder.isLocked) {
                    // Unlock folder
                    final authenticated = await AuthService.authenticate(
                      reason: 'Unlock folder "${folder.name}"',
                    );
                    
                    if (authenticated) {
                      // Get documents in this folder
                      final docs = await DatabaseService.getDocumentsInFolder(folder.id);
                      final filePaths = docs.expand((d) => d.pages.map((p) => p.imagePath)).toList();
                      
                      // Decrypt files
                      try {
                        await EncryptionService.decryptFiles(filePaths, folder.id);
                        
                        final updatedFolder = folder.copyWith(isLocked: false);
                        await ref.read(foldersProvider.notifier).updateFolder(updatedFolder);
                        
                        // Explicitly refresh folders to update document counts
                        await ref.read(foldersProvider.notifier).loadFolders();
                        
                        // Don't delete the key yet - keep it in case user locks again
                        if (context.mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Folder unlocked')),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to unlock: $e')),
                          );
                        }
                      }
                    }
                  } else {
                    // Lock folder
                    final canAuth = await AuthService.canAuthenticate();
                    if (!canAuth) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Biometric authentication not available')),
                        );
                      }
                      return;
                    }
                    
                    final authenticated = await AuthService.authenticate(
                      reason: 'Lock folder "${folder.name}"',
                    );
                    
                    if (authenticated) {
                      // Generate encryption key
                      await EncryptionService.generateKeyForFolder(folder.id);
                      
                      // Get documents in this folder
                      final docs = await DatabaseService.getDocumentsInFolder(folder.id);
                      final filePaths = docs.expand((d) => d.pages.map((p) => p.imagePath)).toList();
                      
                      // Encrypt files
                      try {
                        await EncryptionService.encryptFiles(filePaths, folder.id);
                        
                        final updatedFolder = folder.copyWith(isLocked: true);
                        await ref.read(foldersProvider.notifier).updateFolder(updatedFolder);
                        
                        // Explicitly refresh folders to update document counts
                        await ref.read(foldersProvider.notifier).loadFolders();
                        
                        if (context.mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Folder locked and encrypted')),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to lock: $e')),
                          );
                        }
                      }
                    }
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(folder.isLocked ? Icons.lock_open : Icons.lock),
                    const SizedBox(width: 8),
                    Text(folder.isLocked ? 'Unlock' : 'Lock'),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                   final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(l10n.deleteFolderTitle),
                      content: Text(l10n.deleteFolderConfirmation),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text(l10n.cancel),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(l10n.delete),
                        ),
                      ],
                    ),
                  );
                  
                  if (confirm == true) {
                    await ref.read(foldersProvider.notifier).deleteFolder(folder.id);
                    if (context.mounted) Navigator.pop(context);
                  }
                },
                child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
              ),
              FilledButton(
                onPressed: () async {
                  if (controller.text.trim().isNotEmpty) {
                    final updatedFolder = folder.copyWith(
                      name: controller.text.trim(),
                      iconName: selectedIconName,
                      colorValue: selectedColor.toARGB32(),
                    );
                    
                    await ref.read(foldersProvider.notifier).updateFolder(updatedFolder);
                    if (context.mounted) Navigator.pop(context);
                  }
                },
                child: Text(l10n.save),
              ),
            ],
          );
        }
      ),
    );
  }
}
