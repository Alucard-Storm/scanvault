import 'dart:io';
import 'dart:typed_data';
import 'package:archive/archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../core/exceptions/app_exceptions.dart';
import '../models/document.dart';

/// Service for exporting documents to DOCX format
class DocxService {
  DocxService._();

  /// Generate DOCX from scanned pages with images and optional OCR text
  /// 
  /// Logic:
  /// - If page has OCR text and includeOcrText is true: include both image and text
  /// - If no OCR text or includeOcrText is false: include only the image
  /// - Maintains page order
  static Future<String> generateDocx(
    Document document, {
    bool includeOcrText = false,
    List<int>? selectedPageIndices,
  }) async {
    try {
      final archive = Archive();
      final imageRelationships = <String, String>{};
      final imageFiles = <ArchiveFile>[];
      int imageCounter = 1;

      // Collect images and build content
      final contentParts = <String>[];

      // Pre-calculate which pages will actually be exported
      final exportedIndices = List.generate(document.pages.length, (i) => i)
          .where((i) => selectedPageIndices == null || selectedPageIndices.contains(i))
          .toList();
      
      for (int i = 0; i < document.pages.length; i++) {
        if (selectedPageIndices != null && !selectedPageIndices.contains(i)) {
          continue;
        }

        final page = document.pages[i];
        final imagePath = page.processedImagePath ?? page.imagePath;
        final imageFile = File(imagePath);

        if (!await imageFile.exists()) {
          continue;
        }

        final imageBytes = await imageFile.readAsBytes();
        final extension = p.extension(imagePath).replaceFirst('.', '').toLowerCase();
        final imageFileName = 'image$imageCounter.$extension';
        final rId = 'rId${imageCounter + 1}'; // rId1 is reserved for styles
        
        // Add image to archive
        imageFiles.add(ArchiveFile(
          'word/media/$imageFileName',
          imageBytes.length,
          imageBytes,
        ));
        
        imageRelationships[rId] = 'media/$imageFileName';
        
        // Add page heading
        contentParts.add(_createHeading('Page ${page.pageNumber}'));
        
        // Add image
        contentParts.add(_createImageParagraph(rId, extension));
        
        // Add OCR text if available and requested
        if (includeOcrText && page.ocrText != null && page.ocrText!.isNotEmpty) {
          contentParts.add(_createParagraph('')); // Spacing
          contentParts.add(_createHeading('Extracted Text:', level: 2));
          contentParts.add(_createParagraph(page.ocrText!));
        }
        
        // Add page break (except for last exported page)
        if (i != exportedIndices.last) {
          contentParts.add(_createPageBreak());
        }
        
        imageCounter++;
      }

      // Build document.xml
      final documentXml = _buildDocumentXml(document.name, contentParts.join('\n'));
      archive.addFile(ArchiveFile(
        'word/document.xml',
        documentXml.length,
        Uint8List.fromList(documentXml.codeUnits),
      ));

      // Build document.xml.rels
      final relsXml = _buildDocumentRels(imageRelationships);
      archive.addFile(ArchiveFile(
        'word/_rels/document.xml.rels',
        relsXml.length,
        Uint8List.fromList(relsXml.codeUnits),
      ));

      // Add images
      for (final imageFile in imageFiles) {
        archive.addFile(imageFile);
      }

      // Add required DOCX structure files
      _addRequiredFiles(archive);

      // Encode as ZIP
      final zipEncoder = ZipEncoder();
      final zipBytes = zipEncoder.encode(archive);
      
      if (zipBytes == null) {
        throw ExportException('Failed to encode DOCX', null);
      }

      // Save to file
      final outputDir = await getApplicationDocumentsDirectory();
      final sanitizedName = document.name.replaceAll(RegExp(r'[^\w\s-]'), '');
      final fileName = '${sanitizedName.isEmpty ? 'document' : sanitizedName}_${DateTime.now().millisecondsSinceEpoch}.docx';
      final outputPath = p.join(outputDir.path, 'exports', fileName);

      // Create exports directory if needed
      final exportsDir = Directory(p.join(outputDir.path, 'exports'));
      if (!await exportsDir.exists()) {
        await exportsDir.create(recursive: true);
      }

      final file = File(outputPath);
      await file.writeAsBytes(zipBytes);

      return outputPath;
    } catch (e) {
      if (e is ExportException) rethrow;
      throw ExportException('Failed to generate DOCX', e);
    }
  }

  static String _createHeading(String text, {int level = 1}) {
    final fontSize = level == 1 ? '28' : '24';
    return '''
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Heading$level"/>
        <w:spacing w:before="240" w:after="120"/>
      </w:pPr>
      <w:r>
        <w:rPr>
          <w:b/>
          <w:sz w:val="$fontSize"/>
        </w:rPr>
        <w:t>${_escapeXml(text)}</w:t>
      </w:r>
    </w:p>''';
  }

  static String _createParagraph(String text) {
    // Split text by newlines and create separate runs
    final lines = text.split('\n');
    final runs = lines.asMap().entries.map((entry) {
      final isLast = entry.key == lines.length - 1;
      final line = entry.value;
      return '''
        <w:r>
          <w:t>${_escapeXml(line)}</w:t>
        </w:r>${isLast ? '' : '<w:r><w:br/></w:r>'}''';
    }).join('\n');
    
    return '''
    <w:p>
      <w:pPr>
        <w:spacing w:after="200"/>
      </w:pPr>
      $runs
    </w:p>''';
  }

  static String _createImageParagraph(String rId, String extension) {
    // Image dimensions (EMU units: 1 inch = 914400 EMU)
    // Using A4-ish width (about 6 inches) for good display
    const width = 5486400; // ~6 inches
    const height = 4114800; // ~4.5 inches (maintains rough aspect ratio)
    
    return '''
    <w:p>
      <w:pPr>
        <w:jc w:val="center"/>
      </w:pPr>
      <w:r>
        <w:drawing>
          <wp:inline distT="0" distB="0" distL="0" distR="0">
            <wp:extent cx="$width" cy="$height"/>
            <wp:docPr id="1" name="Image"/>
            <a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">
              <a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture">
                <pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">
                  <pic:nvPicPr>
                    <pic:cNvPr id="0" name="Image"/>
                    <pic:cNvPicPr/>
                  </pic:nvPicPr>
                  <pic:blipFill>
                    <a:blip r:embed="$rId"/>
                    <a:stretch>
                      <a:fillRect/>
                    </a:stretch>
                  </pic:blipFill>
                  <pic:spPr>
                    <a:xfrm>
                      <a:off x="0" y="0"/>
                      <a:ext cx="$width" cy="$height"/>
                    </a:xfrm>
                    <a:prstGeom prst="rect">
                      <a:avLst/>
                    </a:prstGeom>
                  </pic:spPr>
                </pic:pic>
              </a:graphicData>
            </a:graphic>
          </wp:inline>
        </w:drawing>
      </w:r>
    </w:p>''';
  }

  static String _createPageBreak() {
    return '''
    <w:p>
      <w:r>
        <w:br w:type="page"/>
      </w:r>
    </w:p>''';
  }

  static String _buildDocumentXml(String title, String content) {
    return '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
            xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
            xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing">
  <w:body>
    <w:p>
      <w:pPr>
        <w:pStyle w:val="Title"/>
        <w:jc w:val="center"/>
      </w:pPr>
      <w:r>
        <w:rPr>
          <w:b/>
          <w:sz w:val="36"/>
        </w:rPr>
        <w:t>${_escapeXml(title)}</w:t>
      </w:r>
    </w:p>
    <w:p>
      <w:r>
        <w:br w:type="page"/>
      </w:r>
    </w:p>
    $content
    <w:sectPr>
      <w:pgSz w:w="12240" w:h="15840"/>
      <w:pgMar w:top="1440" w:right="1440" w:bottom="1440" w:left="1440"/>
    </w:sectPr>
  </w:body>
</w:document>''';
  }

  static String _buildDocumentRels(Map<String, String> imageRelationships) {
    final imageRels = imageRelationships.entries.map((entry) {
      return '''
    <Relationship Id="${entry.key}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="${entry.value}"/>''';
    }).join('\n');

    return '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
    <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>
$imageRels
</Relationships>''';
  }

  static void _addRequiredFiles(Archive archive) {
    // [Content_Types].xml
    final contentTypes = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
    <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
    <Default Extension="xml" ContentType="application/xml"/>
    <Default Extension="png" ContentType="image/png"/>
    <Default Extension="jpg" ContentType="image/jpeg"/>
    <Default Extension="jpeg" ContentType="image/jpeg"/>
    <Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/>
    <Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/>
</Types>''';
    archive.addFile(ArchiveFile(
      '[Content_Types].xml',
      contentTypes.length,
      Uint8List.fromList(contentTypes.codeUnits),
    ));

    // _rels/.rels
    final rootRels = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
    <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/>
</Relationships>''';
    archive.addFile(ArchiveFile(
      '_rels/.rels',
      rootRels.length,
      Uint8List.fromList(rootRels.codeUnits),
    ));

    // word/styles.xml (minimal styles)
    final styles = '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:styles xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
    <w:style w:type="paragraph" w:styleId="Title">
        <w:name w:val="Title"/>
        <w:rPr>
            <w:b/>
            <w:sz w:val="36"/>
        </w:rPr>
    </w:style>
    <w:style w:type="paragraph" w:styleId="Heading1">
        <w:name w:val="Heading 1"/>
        <w:rPr>
            <w:b/>
            <w:sz w:val="28"/>
        </w:rPr>
    </w:style>
    <w:style w:type="paragraph" w:styleId="Heading2">
        <w:name w:val="Heading 2"/>
        <w:rPr>
            <w:b/>
            <w:sz w:val="24"/>
        </w:rPr>
    </w:style>
</w:styles>''';
    archive.addFile(ArchiveFile(
      'word/styles.xml',
      styles.length,
      Uint8List.fromList(styles.codeUnits),
    ));
  }

  static String _escapeXml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&apos;');
  }
}
