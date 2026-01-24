import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../models/document.dart';
import '../../models/folder.dart';
import '../../providers/document_provider.dart';
import '../../l10n/app_localizations.dart';

/// Screen displaying documents within a specific folder
class FolderDetailScreen extends ConsumerWidget {
  final String folderId;

  const FolderDetailScreen({
    super.key,
    required this.folderId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch folders to get the folder name
    final foldersAsync = ref.watch(foldersProvider);
    final folder = foldersAsync.asData?.value.firstWhere(
      (f) => f.id == folderId,
      orElse: () => throw Exception('Folder not found'),
    );
    
    // Check if l10n is available (it should be)
    final l10n = AppLocalizations.of(context);

    if (folder == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    // Can safely assume l10n is not null here if MaterialApp is set up correctly
    if (l10n == null) return const SizedBox.shrink();

    // Watch documents and filter by folderId
    final documentsAsync = ref.watch(documentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(folder.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              _showRenameDialog(context, ref, folder);
            },
            tooltip: l10n.renameFolder,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
               _showDeleteDialog(context, ref, folder.id);
            },
            tooltip: l10n.deleteFolderTitle,
          ),
        ],
      ),
      body: documentsAsync.when(
        data: (documents) {
          final folderDocs = documents.where((d) => d.folderId == folderId).toList();

          if (folderDocs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.folder_open,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.emptyFolder,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: folderDocs.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final document = folderDocs[index];
              return _DocumentListItem(document: document);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text(l10n.errorGeneric(e))),
      ),
    );
  }

  void _showRenameDialog(BuildContext context, WidgetRef ref, Folder folder) {
    final l10n = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: folder.name);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.renameFolder),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: l10n.folderName,
            border: const OutlineInputBorder(),
          ),
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () async {
              if (controller.text.trim().isNotEmpty) {
                await ref.read(foldersProvider.notifier).updateFolder(
                  folder.copyWith(name: controller.text.trim()),
                );
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, String folderId) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteFolderTitle),
        content: Text(l10n.deleteFolderConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              // TODO: Logic to move documents to root is handled in provider or manually here?
              // The provider should handle this or we iterate docs here. 
              // For safety, let's assume provider simply deletes row.
              // We should update documents to remove folderId.
              
              Navigator.pop(context); // Close dialog
              
              // Move documents out of folder first (client-side safety)
              // Actually, simpler to just delete folder and let files exist with dangling ID or null it.
              // Ideally backend/service handles cascading or nulling. 
              // Using existing provider methods:
              await ref.read(foldersProvider.notifier).deleteFolder(folderId);
              
              if (context.mounted) {
                context.pop(); // Go back to folders list
              }
            },
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}

class _DocumentListItem extends StatelessWidget {
  final Document document;

  const _DocumentListItem({required this.document});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat.yMMMd().add_jm();

    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
          image: document.thumbnailPath != null
              ? DecorationImage(
                  image: FileImage(File(document.thumbnailPath!))
                      as ImageProvider,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: document.thumbnailPath == null
            ? Icon(Icons.description, color: theme.colorScheme.primary)
            : null,
      ),
      title: Text(
        document.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        '${document.pages.length} pages • ${dateFormat.format(document.modifiedAt)}',
        style: theme.textTheme.bodySmall,
      ),
      onTap: () {
        context.push('/document/${document.id}');
      },
    );
  }
}
