import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/document.dart';
import '../../models/folder.dart'; // Import Folder
import '../../providers/document_provider.dart';
import '../../services/database_service.dart'; // Import DatabaseService
import '../../services/ocr_service.dart'; // Import OcrService
import '../../services/smart_naming_service.dart'; // Import SmartNamingService
import '../../l10n/app_localizations.dart';

/// Camera screen using google_mlkit_document_scanner
class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    // Auto-start scanning when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScanning();
    });
  }

  Future<void> _startScanning() async {
    try {
      final options = DocumentScannerOptions(
        documentFormat: DocumentFormat.jpeg,
        mode: ScannerMode.full,
        pageLimit: 100,
      );

      final documentScanner = DocumentScanner(options: options);
      final result = await documentScanner.scanDocument();
      
      if (!mounted) return;

      if (result.images.isNotEmpty) {
        await _saveDocument(result.images);
      } else {
        // User cancelled without scanning anything
        if (mounted) context.pop();
      }
    } catch (e) {
      debugPrint('Error scanning: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.errorScanning(e))),
        );
        context.pop();
      }
    }
  }

  Future<void> _saveDocument(List<String> scannedPaths) async {
    if (scannedPaths.isEmpty) return;
    setState(() => _isProcessing = true);
    
    try {
      final now = DateTime.now();
      String name = 'Scan ${now.toString().split('.')[0]}';
      String? folderId;
      String? ocrText;

      final documentId = const Uuid().v4();
      
      // Smart Naming & Categorization Logic
      if (scannedPaths.isNotEmpty) {
        try {
           // 1. Extract text from the first page for analysis
           // Clean path first as well
           final cleanPath = scannedPaths.first.replaceFirst('file://', '');
           final text = await OcrService.extractText(cleanPath);
           
           if (text.isNotEmpty) {
             ocrText = text; // Store it so we don't have to re-OCR immediately if not needed
             
             final suggestion = SmartNamingService.analyzeContent(text);
             
             if (suggestion.name != null) {
               name = suggestion.name!;
             }
             
             if (suggestion.category != null) {
               // Check if folder exists, if not create it
               final existingFolder = await DatabaseService.getFolderByName(suggestion.category!);
               if (existingFolder != null) {
                 folderId = existingFolder.id;
               } else {
                 final newFolderId = const Uuid().v4();
                 final newFolder = Folder(
                   id: newFolderId,
                   name: suggestion.category!,
                   createdAt: DateTime.now(),
                   iconName: 'folder', // Default icon
                 );
                 await DatabaseService.insertFolder(newFolder);
                 folderId = newFolderId;
               }
             }
           }
        } catch (e) {
          debugPrint('Smart naming failed: $e');
          // Continue with default name/folder if smart naming fails
        }
      }

      // Get persistent directory
      final appDir = await getApplicationDocumentsDirectory();
      final vaultDir = Directory(p.join(appDir.path, 'ScanVault'));
      if (!await vaultDir.exists()) {
        await vaultDir.create(recursive: true);
      }

      final pages = <ScannedPage>[];
      String? thumbnailPath;
      
      for (int i = 0; i < scannedPaths.length; i++) {
        final pageId = const Uuid().v4();
        // The paths returned by mlkit are typically temp paths, copy them to our storage
        // Clean the URI if it starts with file://
        final cleanPath = scannedPaths[i].replaceFirst('file://', '');
        final sourceFile = File(cleanPath);
        
        if (!await sourceFile.exists()) {
           debugPrint('File not found at $cleanPath');
           continue;
        }

        final fileName = '${documentId}_page_${i+1}.jpg';
        final newPath = p.join(vaultDir.path, fileName);
        
        await sourceFile.copy(newPath);
        
        // Use the first page as thumbnail
        if (i == 0) thumbnailPath = newPath;

        pages.add(ScannedPage(
          id: pageId,
          imagePath: newPath,
          pageNumber: i + 1,
          appliedFilter: FilterType.original,
          ocrText: (i == 0) ? ocrText : null, // Assign OCR text to the first page if we grabbed it
        ));
      }

      if (pages.isEmpty) {
        throw Exception('No pages could be saved');
      }

      final newDocument = Document(
        id: documentId,
        name: name,
        createdAt: now,
        modifiedAt: now,
        pages: pages,
        thumbnailPath: thumbnailPath!,
        folderId: folderId,
        ocrText: ocrText, // Store document-level OCR text
      );

      await ref.read(documentsProvider.notifier).addDocument(newDocument);
      
      if (mounted) {
        context.pop();
      }
    } catch (e) {
      debugPrint('Error saving document: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(AppLocalizations.of(context)!.saveDocumentFailed(e))),
        );
        context.pop();
      }
    } finally {
       if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Just show a loading indicator while the native scanner is active/processing
    // Note: Localization can be accessed safely here if context is valid
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              _isProcessing ? l10n.savingDocument : l10n.launchingScanner,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
