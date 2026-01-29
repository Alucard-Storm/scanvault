import 'dart:io';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:path/path.dart' as p; // analyzed as unused
// import 'package:path_provider/path_provider.dart'; // analyzed as unused
// import 'package:permission_handler/permission_handler.dart'; // analyzed as unused
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

import '../../models/document.dart';
import '../../providers/document_provider.dart';
import '../../services/pdf_service.dart';

import '../../services/storage_service.dart';
import '../tags/tags_sheet.dart';
import 'share_options_dialog.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/folder_icons.dart';

class DocumentViewerScreen extends ConsumerStatefulWidget {
  final String documentId;

  const DocumentViewerScreen({
    super.key,
    required this.documentId,
  });

  @override
  ConsumerState<DocumentViewerScreen> createState() => _DocumentViewerScreenState();
}

class _DocumentViewerScreenState extends ConsumerState<DocumentViewerScreen> {
  late PageController _pageController;
  int _currentPageIndex = 0;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _addPage(Document document) async {
    if (_isProcessing) return;
    setState(() => _isProcessing = true);

    try {
      final options = DocumentScannerOptions(
        documentFormat: DocumentFormat.jpeg,
        mode: ScannerMode.full,
        pageLimit: 100, // Allow adding multiple pages at once
      );

      final documentScanner = DocumentScanner(options: options);
      final result = await documentScanner.scanDocument();
      
      if (!mounted) return;

      if (result.images.isNotEmpty) {
        // Move to persistent storage and update document
        var currentPages = [...document.pages];
        
        // Actually, let's stick to what was there but adapted
        for (final scannedPath in result.images) {
             final cleanPath = scannedPath.replaceFirst('file://', '');
             final sourceFile = File(cleanPath);
             
             if (!await sourceFile.exists()) continue;

             final fileName = '${document.id}_page_${currentPages.length + 1}_${DateTime.now().millisecondsSinceEpoch}.jpg';
             final newPath = await ref.read(storageServiceProvider).getFilePath(fileName);
             
             await sourceFile.copy(newPath);

             final newPage = ScannedPage(
               id: const Uuid().v4(),
               imagePath: newPath,
               pageNumber: currentPages.length + 1,
               appliedFilter: FilterType.original,
             );
             currentPages.add(newPage);
        }

        final updatedDoc = document.copyWith(
          pages: currentPages,
          modifiedAt: DateTime.now(),
        );

        await ref.read(documentsProvider.notifier).updateDocument(updatedDoc);
        
        if (mounted) {
             ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLocalizations.of(context)!.pagesAdded(result.images.length.toString()))),
            );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.pageAddFailed(e))),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  void _extractText(Document document) async {
    final page = document.pages[_currentPageIndex];
    
    // Check if we already have text
    if (page.ocrText != null && page.ocrText!.isNotEmpty) {
       context.pushNamed(
        'ocr',
        pathParameters: {'documentId': document.id},
        extra: {
          'imageUrl': page.processedImagePath ?? page.imagePath,
          'initialText': page.ocrText,
          'pageId': page.id,
        },
      );
      return;
    }

    // Otherwise, we can extract it in the new screen or here. 
    // The new screen handles extraction if initialText is null.
    context.pushNamed(
      'ocr',
      pathParameters: {'documentId': document.id},
      extra: {
        'imageUrl': page.processedImagePath ?? page.imagePath,
        'pageId': page.id,
      },
    );
  }

  void _sharePdf(Document document) async {
    if (_isProcessing) return;

    // Show options dialog
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => ShareOptionsDialog(document: document),
    );

    if (result == null) return; // Cancelled

    setState(() => _isProcessing = true);

    try {
      final includeOcr = result['includeOcr'] as bool;
      final selectedIndices = result['selectedIndices'] as List<int>;

      final pdfPath = await PdfService.generatePdf(
        document,
        includeOcrText: includeOcr,
        selectedPageIndices: selectedIndices,
      );
      
      await Share.shareXFiles([XFile(pdfPath)], text: document.name);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.exportFailed(e))),
        );
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  void _moveToFolder(Document document) async {
    final folders = ref.read(foldersProvider).valueOrNull ?? [];
    
    if (folders.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.noFoldersAvailable)),
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
              itemCount: folders.length + 1, // +1 for "None" (remove from folder)
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
                  leading: Icon(
                    FolderIcons.getIconData(folder.iconName, folder.name),
                    color: Color(folder.colorValue),
                  ),
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

  void _deleteDocument(Document document) async {
    final l10n = AppLocalizations.of(context)!;
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
    
    if (confirm == true && mounted) {
      await ref.read(documentsProvider.notifier).deleteDocument(document.id);
      if (mounted) context.pop();
    }
  }

  void _showTags(Document document) {
    showModalBottomSheet(
        context: context,
        builder: (context) => TagsSheet(
          isSelectionMode: true,
          selectedTagIds: document.tagIds,
          onTagSelected: (tagId) async {
            final currentTags = Set<String>.from(document.tagIds);
            if (currentTags.contains(tagId)) {
              currentTags.remove(tagId);
            } else {
              currentTags.add(tagId);
            }
            
            await ref.read(documentsProvider.notifier).updateDocument(
              document.copyWith(tagIds: currentTags.toList()),
            );
          },
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final document = ref.watch(documentsProvider.notifier).getDocumentById(widget.documentId);
    final l10n = AppLocalizations.of(context)!;

    if (document == null) {
      return Scaffold(
        body: Center(child: Text(l10n.documentNotFound)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(document.name),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: document.pages.length,
                  onPageChanged: (index) {
                    setState(() => _currentPageIndex = index);
                  },
                  itemBuilder: (context, index) {
                    final page = document.pages[index];
                    // Use processed image if available, otherwise original
                    // If filter is original, processed might be null or same as original
                    final imagePath = page.processedImagePath ?? page.imagePath;
                    final imageWidget = Image.file(
                      File(imagePath),
                      fit: BoxFit.contain,
                    );
                    
                    return InteractiveViewer(
                      child: index == 0 
                          ? Hero(tag: 'doc_thumb_${document.id}', child: imageWidget)
                          : imageWidget,
                    );
                  },
                ),
              ),
            ],
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Chip(
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.9),
                label: Text(
                  l10n.pageCount((_currentPageIndex + 1).toString(), document.pages.length.toString()),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () => _sharePdf(document),
              tooltip: l10n.sharePdf,
            ),
             IconButton(
              icon: const Icon(Icons.crop_rotate), // changed from edit to crop/edit visual
              onPressed: () {
                 final page = document.pages[_currentPageIndex];
                 context.pushNamed(
                   'editor',
                   pathParameters: {'pageId': page.id},
                   extra: page.imagePath,
                 );
              },
              tooltip: l10n.editPage,
            ),
            FloatingActionButton(
              heroTag: 'add_page_fab',
              elevation: 0,
              onPressed: () => _addPage(document),
              tooltip: l10n.addPage,
              child: const Icon(Icons.add_a_photo_outlined),
            ),
             IconButton(
              icon: const Icon(Icons.delete_outline), 
              onPressed: () => _deleteDocument(document),
              tooltip: l10n.delete,
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              tooltip: l10n.moreOptions,
              onSelected: (value) {
                switch (value) {
                  case 'ocr':
                    _extractText(document);
                    break;
                  case 'tags':
                    _showTags(document);
                    break;
                  case 'folder':
                    _moveToFolder(document);
                    break;
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'ocr',
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.text_fields),
                    title: Text(l10n.ocr),
                  ),
                ),
                PopupMenuItem(
                  value: 'tags',
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.label_outline),
                    title: Text(l10n.tags),
                  ),
                ),
                PopupMenuItem(
                  value: 'folder',
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.folder_open),
                    title: Text(l10n.moveToFolder),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
