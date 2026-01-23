import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../providers/document_provider.dart';
import '../../services/ocr_service.dart';

class OcrScreen extends ConsumerStatefulWidget {
  final String documentId;
  final String? imageUrl;
  final String? initialText;
  final String? pageId;

  const OcrScreen({
    super.key,
    required this.documentId,
    this.imageUrl,
    this.initialText,
    this.pageId,
  });

  @override
  ConsumerState<OcrScreen> createState() => _OcrScreenState();
}

class _OcrScreenState extends ConsumerState<OcrScreen> {
  late TextEditingController _textController;
  bool _isLoading = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialText);
    
    if (widget.initialText == null || widget.initialText!.isEmpty) {
      if (widget.imageUrl != null) {
        _extractText();
      }
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _extractText() async {
    setState(() => _isLoading = true);
    try {
      final text = await OcrService.extractText(widget.imageUrl!);
      if (mounted) {
        setState(() {
          _textController.text = text;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OCR Failed: $e')),
        );
      }
    }
  }

  Future<void> _saveText() async {
    if (widget.pageId == null) return;
    
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    
    setState(() => _isSaving = true);
    
    try {
      final document = ref.read(documentsProvider.notifier).getDocumentById(widget.documentId);
      if (document != null) {
        final updatedPages = document.pages.map((p) {
          if (p.id == widget.pageId) {
            return p.copyWith(ocrText: text);
          }
          return p;
        }).toList();
        
        // Also update document level OCR text if needed, or just keep it per page
        // For now let's just update the page
        
        await ref.read(documentsProvider.notifier).updateDocument(
          document.copyWith(pages: updatedPages),
        );
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Text saved to document')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save: $e')),
        );
      }
    } finally {
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Extracted Text'),
        actions: [
          if (widget.pageId != null)
            IconButton(
              icon: _isSaving 
                ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)) 
                : const Icon(Icons.save_outlined),
              onPressed: _isSaving ? null : _saveText,
              tooltip: 'Save to Document',
            ),
          IconButton(
            icon: const Icon(Icons.translate),
            onPressed: () {
              final text = _textController.text;
              if (text.isNotEmpty) {
                 context.pushNamed('translation', extra: text);
              }
            },
            tooltip: 'Translate',
          ),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: _textController.text));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Copied to clipboard')),
              );
            },
            tooltip: 'Copy',
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
               Share.share(_textController.text);
            },
            tooltip: 'Share',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _textController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'No text extracted...',
                ),
                readOnly: _isSaving,
              ),
            ),
    );
  }
}
