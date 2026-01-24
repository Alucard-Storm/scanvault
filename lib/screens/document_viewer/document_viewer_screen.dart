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
                      if (mounted) {
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
                     if (mounted) {
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
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
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
          IconButton(
            icon: const Icon(Icons.add_a_photo_outlined),
            onPressed: () => _addPage(document),
            tooltip: l10n.addPage,
          ),
          IconButton(
            icon: const Icon(Icons.text_fields),
            onPressed: () => _extractText(document),
            tooltip: l10n.ocr,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _sharePdf(document),
            tooltip: l10n.sharePdf,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
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
              
              if (confirm == true && context.mounted) {
                await ref.read(documentsProvider.notifier).deleteDocument(document.id);
                if (mounted) context.pop();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: () => _moveToFolder(document),
            tooltip: l10n.moveToFolder,
          ),
          IconButton(
            icon: const Icon(Icons.label_outline),
            onPressed: () {
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
            },
            tooltip: l10n.tags,
          ),
        ],
      ),
      body: Stack(
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
              Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.surface,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.pageCount((_currentPageIndex + 1).toString(), document.pages.length.toString()),
                      // Wait, ARB: "Page {current} of {total}" expecting Object.
                      // toString() is fine.
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
