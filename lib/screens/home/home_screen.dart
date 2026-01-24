import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../tags/tags_sheet.dart';
import '../../core/constants/strings.dart';
import '../../l10n/app_localizations.dart';
import '../../models/document.dart';

import '../../providers/document_provider.dart';

/// Home screen displaying the list of scanned documents
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isGridView = false;
  String? _selectedTagId;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final documentsAsync = ref.watch(documentsProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar
          SliverAppBar(
            pinned: true,
            expandedHeight: 140.0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            surfaceTintColor: theme.colorScheme.surfaceTint,
            title: _isSearching
                ? TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: l10n.searchHint,
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.6)),
                    ),
                    style: TextStyle(color: colorScheme.onSurface),
                    onChanged: (value) {
                      setState(() => _searchQuery = value);
                    },
                  )
                : null, // Title is handled by FlexibleSpaceBar when not searching
            actions: [
              IconButton(
                icon: Icon(_isSearching ? Icons.close : Icons.search_rounded),
                onPressed: () {
                  setState(() {
                     if (_isSearching) {
                       _isSearching = false;
                       _searchQuery = '';
                       _searchController.clear();
                     } else {
                       _isSearching = true;
                     }
                  });
                },
              ),
              IconButton(
                icon: Icon(_isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded),
                onPressed: () {
                  setState(() => _isGridView = !_isGridView);
                },
              ),
              IconButton(
                icon: Icon(Icons.filter_list, 
                  color: _selectedTagId != null ? theme.colorScheme.primary : null
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => TagsSheet(
                      isSelectionMode: true,
                      selectedTagIds: _selectedTagId != null ? [_selectedTagId!] : [],
                      onTagSelected: (tagId) {
                        setState(() {
                          // Toggle selection
                          if (_selectedTagId == tagId) {
                            _selectedTagId = null;
                          } else {
                            _selectedTagId = tagId;
                          }
                        });
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ],
            flexibleSpace: _isSearching
                ? null 
                : LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      final top = constraints.biggest.height;
                      final expansion = (top - kToolbarHeight - MediaQuery.of(context).padding.top) / (140.0 - kToolbarHeight - MediaQuery.of(context).padding.top);
                      final clampedExpansion = expansion.clamp(0.0, 1.0);
                      
                      return FlexibleSpaceBar(
                        centerTitle: false, // We control positioning manually via titlePadding or stack
                        expandedTitleScale: 1.0, // We handle scaling manually
                        titlePadding: EdgeInsets.zero,
                        title: SizedBox(
                          height: kToolbarHeight,
                          child: Stack(
                            children: [
                              Align(
                                // Interpolate alignment: 
                                // Expanded (1.0) -> Alignment.center (0.0, 0.0)
                                // Collapsed (0.0) -> Alignment.centerLeft (-1.0, 0.0)
                                // Standard NavigationToolbar padding is typically 16.0 or 72.0 depending on leading.
                                // Let's try simpler logic:
                                // Use fractional offset or padding.
                                alignment: Alignment(
                                  -1.0 + (clampedExpansion * 1.0), // -1 (Left) -> 0 (Center)
                                  0.0,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 16.0 + (clampedExpansion * 0), // Base padding
                                  ),
                                  child: Text(
                                    l10n.appTitle,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onSurface,
                                      // Interpolate font size: 20 (standard) -> 32 (expanded)
                                      fontSize: 20.0 + (clampedExpansion * 12.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Empty state or document list
          documentsAsync.when(
            data: (documents) {
              final filteredDocuments = documents.where((doc) {
                final matchesSearch = _searchQuery.isEmpty || 
                    doc.name.toLowerCase().contains(_searchQuery.toLowerCase());
                
                final matchesTag = _selectedTagId == null || 
                    doc.tagIds.contains(_selectedTagId);
                    
                return matchesSearch && matchesTag;
              }).toList();
                    
              if (filteredDocuments.isEmpty) {
                return SliverFillRemaining(
                  child: _isSearching 
                    ? const Center(child: Text('No results found'))
                    : _buildEmptyState(context, l10n),
                );
              }
              if (_isGridView) {
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final document = filteredDocuments[index];
                      return _DocumentGridItem(document: document);
                    },
                    childCount: filteredDocuments.length,
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final document = filteredDocuments[index];
                    return _DocumentListItem(document: document);
                  },
                  childCount: filteredDocuments.length,
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => SliverFillRemaining(
              child: Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),

      // Scan FAB
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/camera'),
        icon: const Icon(Icons.document_scanner_rounded),
        label: Text(l10n.scanFab),
      ).animate().scale(
            delay: 300.ms,
            duration: 400.ms,
            curve: Curves.easeOutBack,
          ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.document_scanner_outlined,
              size: 120,
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(delay: 200.ms, duration: 400.ms),
            const SizedBox(height: 24),
            Text(
              l10n.noDocuments,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
            const SizedBox(height: 8),
            Text(
              l10n.noDocumentsSubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
          ],
        ),
      ),
    );
  }
}

class _DocumentListItem extends ConsumerWidget {
  final Document document;

  const _DocumentListItem({required this.document});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat.yMMMd().add_jm();
    final l10n = AppLocalizations.of(context)!;

    return Dismissible(
      key: Key(document.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: theme.colorScheme.error,
        child: Icon(Icons.delete, color: theme.colorScheme.onError),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppLocalizations.of(context)!.deleteDocumentTitle),
            content: Text(AppLocalizations.of(context)!.deleteConfirmation(document.name)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(AppLocalizations.of(context)!.delete),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        ref.read(documentsProvider.notifier).deleteDocument(document.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.deleted(document.name))),
        );
      },
      child: ListTile(
        leading: Hero(
          tag: 'doc_thumb_${document.id}',
          child: Container(
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
        ),
        title: Text(
          document.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          '${document.pages.length} pages • ${dateFormat.format(document.modifiedAt)}',
          style: theme.textTheme.bodySmall,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showOptions(context, ref, document),
        ),
        onTap: () {
           context.push('/document/${document.id}');
        },
      ),
    );
  }
  
  void _showOptions(BuildContext context, WidgetRef ref, Document document) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text(l10n.rename),
              onTap: () async {
                Navigator.pop(context);
                // Implement rename dialog here if needed, or keeping it simple for now
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder_open),
              title: Text(l10n.moveToFolder),
              onTap: () async {
                 Navigator.pop(context); 
                 await _showMoveDialog(context, ref, document);
              },
            ),
             ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(context);
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(l10n.deleteDocumentTitle),
                    content: Text(l10n.deleteConfirmation(document.name)),
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
                  await ref.read(documentsProvider.notifier).deleteDocument(document.id);
                }
              },
            ),
          ],
        );
      }
    );
  }

  Future<void> _showMoveDialog(BuildContext context, WidgetRef ref, Document document) async {
    final folders = ref.read(foldersProvider).valueOrNull ?? [];
    
    // We need l10n here too, but it's async and context might be invalid if we wait?
    // Actually method is async but using context.mounted check.
    // We can get l10n from context at start.
    // However, context passed to showDialog builder will have l10n.
    
    if (folders.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No folders available. Create one first.')),
        );
      }
      return;
    }

    await showDialog(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.moveToFolder),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: folders.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return ListTile(
                    leading: const Icon(Icons.folder_off),
                    title: Text(l10n.moveToRoot),
                    onTap: () async {
                      Navigator.pop(context);
                      await ref.read(documentsProvider.notifier).updateDocument(
                        document.copyWith(folderId: null),
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.movedToRoot)),
                        );
                      }
                    },
                  );
                }
                
                final folder = folders[index - 1];
                return ListTile(
                  leading: Icon(Icons.folder, color: Color(folder.colorValue)),
                  title: Text(folder.name),
                  onTap: () async {
                    Navigator.pop(context);
                    await ref.read(documentsProvider.notifier).updateDocument(
                      document.copyWith(folderId: folder.id),
                    );
                     if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.movedTo(folder.name))),
                        );
                      }
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancel),
            ),
          ],
        );
      }
    );
  }
}

class _DocumentGridItem extends StatelessWidget {
  final Document document;
  
  const _DocumentGridItem({required this.document});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat.yMMMd();

    return InkWell(
      onTap: () => context.push('/document/${document.id}'),
      borderRadius: BorderRadius.circular(12),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Hero(
                tag: 'doc_thumb_${document.id}',
                child: document.thumbnailPath != null
                  ? Image.file(
                      File(document.thumbnailPath!),
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Icon(Icons.description, size: 48, color: theme.colorScheme.primary),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${document.pages.length} pages',
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    dateFormat.format(document.modifiedAt),
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
