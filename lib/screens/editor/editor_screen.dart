import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;


import '../../models/document.dart';
import '../../providers/document_provider.dart';
import '../../services/filter_service.dart';
import '../../services/storage_service.dart';

/// Editor screen for image enhancement
class EditorScreen extends ConsumerStatefulWidget {
  final String pageId;
  final String? imagePath;

  const EditorScreen({
    super.key,
    required this.pageId,
    this.imagePath,
  });

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  FilterType _selectedFilter = FilterType.original;
  Uint8List? _originalImageBytes;
  Uint8List? _previewImageBytes;
  Map<FilterType, Uint8List>? _thumbnails;
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      if (widget.imagePath == null) {
        throw Exception('Image path is null');
      }

      final file = File(widget.imagePath!);
      if (!await file.exists()) {
        throw Exception('Image file not found');
      }

      final bytes = await file.readAsBytes();
      final thumbnails = await FilterService.generatePreviews(bytes);

      if (mounted) {
        setState(() {
          _originalImageBytes = bytes;
          _previewImageBytes = bytes;
          _thumbnails = thumbnails;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading image: $e')),
        );
        context.pop();
      }
    }
  }

  Future<void> _applyFilter(FilterType filter) async {
    if (_originalImageBytes == null || _selectedFilter == filter) return;

    setState(() => _isLoading = true);
    
    try {
      // If going back to original, just use original bytes
      if (filter == FilterType.original) {
        setState(() {
          _previewImageBytes = _originalImageBytes;
          _selectedFilter = filter;
          _isLoading = false;
        });
        return;
      }

      final filtered = await FilterService.applyFilter(_originalImageBytes!, filter);
      
      if (mounted) {
        setState(() {
          _previewImageBytes = filtered;
          _selectedFilter = filter;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error applying filter: $e');
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error applying filter: $e')),
        );
      }
    }
  }

  Future<void> _saveAndExit() async {
    if (_isSaving || _previewImageBytes == null) return;
    
    setState(() => _isSaving = true);

    try {
      // Find the document that contains this page
      final documents = ref.read(documentsProvider).value ?? [];
      Document? targetDoc;
      ScannedPage? targetPage;

      for (final doc in documents) {
        try {
          final page = doc.pages.firstWhere((p) => p.id == widget.pageId);
          targetDoc = doc;
          targetPage = page;
          break;
        } catch (_) {}
      }

      if (targetDoc == null || targetPage == null) {
        // If we can't find the doc (maybe this is a new scan not yet saved? 
        // Logic might need adjustment if used directly from camera without saving first)
        // For now assume it exists
        throw Exception('Document or page not found');
      }

      String? processedPath;
      
      if (_selectedFilter != FilterType.original) {
        // Save the processed image to a new file in persistent storage
        final originalName = p.basenameWithoutExtension(widget.imagePath!);
        final ext = p.extension(widget.imagePath!);
        final fileName = '${originalName}_${_selectedFilter.name}${DateTime.now().millisecondsSinceEpoch}$ext';
        
        final newPath = await ref.read(storageServiceProvider).getFilePath(fileName);
        
        await File(newPath).writeAsBytes(_previewImageBytes!);
        processedPath = newPath;
      }

      // Update document in provider/database
      final updatedPage = targetPage.copyWith(
        processedImagePath: processedPath,
        appliedFilter: _selectedFilter,
      );

      final updatedPages = targetDoc.pages.map((p) => p.id == widget.pageId ? updatedPage : p).toList();
      final updatedDoc = targetDoc.copyWith(
        pages: updatedPages,
        modifiedAt: DateTime.now(),
        // Update thumbnail if it was the first page
        thumbnailPath: targetDoc.pages.first.id == widget.pageId 
            ? (processedPath ?? targetPage.imagePath) 
            : targetDoc.thumbnailPath,
      );

      await ref.read(documentsProvider.notifier).updateDocument(updatedDoc);

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      debugPrint('Error saving: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Failed to save changes: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Edit'),
        actions: [
          if (!_isLoading && !_isSaving)
            TextButton(
              onPressed: _saveAndExit,
              child: const Text('Done'),
            ),
        ],
      ),
      body: Column(
        children: [
          // Main Image Preview
          Expanded(
            child: Center(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : _previewImageBytes != null
                      ? Image.memory(
                          _previewImageBytes!,
                          fit: BoxFit.contain,
                        )
                      : const Text('No image', style: TextStyle(color: Colors.white)),
            ),
          ),
          
          // Filter Selector
          if (!_isLoading && _thumbnails != null) ...[
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                border: const Border(
                  top: BorderSide(color: Colors.white24, width: 0.5),
                ),
              ),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.horizontal,
                itemCount: FilterType.values.length,
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final filter = FilterType.values[index];
                  final isSelected = filter == _selectedFilter;
                  final thumbnailBytes = _thumbnails![filter];
                  
                  return GestureDetector(
                    onTap: () => _applyFilter(filter),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                         Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            border: isSelected 
                                ? Border.all(color: Theme.of(context).primaryColor, width: 2)
                                : null,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: thumbnailBytes != null
                                ? Image.memory(thumbnailBytes, fit: BoxFit.cover)
                                : Container(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          FilterService.getFilterName(filter),
                          style: TextStyle(
                            color: isSelected ? Theme.of(context).primaryColor : Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
