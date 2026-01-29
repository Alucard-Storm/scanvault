import 'dart:io';
import 'package:share_plus/share_plus.dart';

import '../models/document.dart';

class ExportService {
  ExportService._();

  /// Share multiple images from the document
  static Future<void> shareImages(
    Document document, {
    List<int>? selectedPageIndices,
    String? shareText,
  }) async {
    final List<XFile> files = [];

    for (int i = 0; i < document.pages.length; i++) {
        if (selectedPageIndices != null && !selectedPageIndices.contains(i)) {
          continue;
        }

        final page = document.pages[i];
        final imagePath = page.processedImagePath ?? page.imagePath;
        final file = File(imagePath);

        if (await file.exists()) {
           // We might want to give it a better name when sharing if possible, 
           // but XFile usually takes the path.
           // Sharing internal paths usually works with SharePlus on standard Android/iOS.
           files.add(XFile(imagePath)); 
        }
    }

    if (files.isNotEmpty) {
      await Share.shareXFiles(
        files,
        text: shareText ?? 'Scanned images from ${document.name}',
      );
    }
  }
}
