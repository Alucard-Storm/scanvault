import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:printing/printing.dart';

import '../core/exceptions/app_exceptions.dart';
import '../models/document.dart';

/// Service for exporting documents to PDF
class PdfService {
  PdfService._();

  /// Generate PDF from scanned pages
  static Future<String> generatePdf(
    Document document, {
    bool includeOcrText = false,
    List<int>? selectedPageIndices,
  }) async {
    try {
      final pdf = pw.Document();

      for (int i = 0; i < document.pages.length; i++) {
        if (selectedPageIndices != null && !selectedPageIndices.contains(i)) {
          continue;
        }

        final page = document.pages[i];
        // Get the image to use (processed if available, otherwise original)
        final imagePath = page.processedImagePath ?? page.imagePath;
        final imageFile = File(imagePath);

        if (!await imageFile.exists()) {
          continue;
        }

        final imageBytes = await imageFile.readAsBytes();
        final image = pw.MemoryImage(imageBytes);

        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            margin: const pw.EdgeInsets.all(20),
            build: (context) {
              return pw.Center(
                child: pw.Image(image, fit: pw.BoxFit.contain),
              );
            },
          ),
        );
      }

      // Add OCR text page if requested
      if (includeOcrText && document.ocrText != null && document.ocrText!.isNotEmpty) {
        pdf.addPage(
          pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            margin: const pw.EdgeInsets.all(40),
            header: (context) => pw.Text(
              'Extracted Text - ${document.name}',
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            build: (context) => [
              pw.SizedBox(height: 20),
              pw.Text(
                document.ocrText!,
                style: const pw.TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      }

      // Save PDF to file
      final outputDir = await getApplicationDocumentsDirectory();
      final fileName = '${document.name.replaceAll(RegExp(r'[^\w\s-]'), '')}_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final outputPath = p.join(outputDir.path, 'exports', fileName);

      // Create exports directory if needed
      final exportsDir = Directory(p.join(outputDir.path, 'exports'));
      if (!await exportsDir.exists()) {
        await exportsDir.create(recursive: true);
      }

      final file = File(outputPath);
      await file.writeAsBytes(await pdf.save());

      return outputPath;
    } catch (e) {
      throw ExportException('Failed to generate PDF', e);
    }
  }

  /// Generate PDF with just text (for OCR export)
  static Future<String> generateTextPdf(
    String text,
    String title,
  ) async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(40),
          header: (context) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 10),
            child: pw.Text(
              title,
              style: pw.TextStyle(
                fontSize: 20,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          footer: (context) => pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
              'Page ${context.pageNumber} of ${context.pagesCount}',
              style: const pw.TextStyle(fontSize: 10),
            ),
          ),
          build: (context) => [
            pw.Text(
              text,
              style: const pw.TextStyle(fontSize: 12, lineSpacing: 1.5),
            ),
          ],
        ),
      );

      final outputDir = await getApplicationDocumentsDirectory();
      final fileName = '${title.replaceAll(RegExp(r'[^\w\s-]'), '')}_text_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final outputPath = p.join(outputDir.path, 'exports', fileName);

      final exportsDir = Directory(p.join(outputDir.path, 'exports'));
      if (!await exportsDir.exists()) {
        await exportsDir.create(recursive: true);
      }

      final file = File(outputPath);
      await file.writeAsBytes(await pdf.save());

      return outputPath;
    } catch (e) {
      throw ExportException('Failed to generate text PDF', e);
    }
  }

  /// Share PDF directly without saving
  static Future<void> sharePdf(Document document) async {
    try {
      final pdfPath = await generatePdf(document);
      await Printing.sharePdf(
        bytes: await File(pdfPath).readAsBytes(),
        filename: '${document.name}.pdf',
      );
    } catch (e) {
      throw ExportException('Failed to share PDF', e);
    }
  }

  /// Print PDF directly
  static Future<void> printPdf(Document document) async {
    try {
      final pdfPath = await generatePdf(document);
      await Printing.layoutPdf(
        onLayout: (_) async => await File(pdfPath).readAsBytes(),
      );
    } catch (e) {
      throw ExportException('Failed to print PDF', e);
    }
  }
}
