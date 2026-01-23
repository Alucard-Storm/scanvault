import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

/// Image utility functions for processing scanned documents
class ImageUtils {
  ImageUtils._();

  /// Resize image to specified max dimension while maintaining aspect ratio
  static Future<Uint8List> resizeImage(
    Uint8List imageBytes, {
    int maxDimension = 1920,
    int quality = 85,
  }) async {
    final image = img.decodeImage(imageBytes);
    if (image == null) throw Exception('Failed to decode image');

    final resized = img.copyResize(
      image,
      width: image.width > image.height ? maxDimension : null,
      height: image.height >= image.width ? maxDimension : null,
      interpolation: img.Interpolation.linear,
    );

    return Uint8List.fromList(img.encodeJpg(resized, quality: quality));
  }

  /// Generate thumbnail from image
  static Future<Uint8List> generateThumbnail(
    Uint8List imageBytes, {
    int size = 256,
  }) async {
    final image = img.decodeImage(imageBytes);
    if (image == null) throw Exception('Failed to decode image');

    final thumbnail = img.copyResizeCropSquare(image, size: size);
    return Uint8List.fromList(img.encodeJpg(thumbnail, quality: 80));
  }

  /// Rotate image by specified degrees (90, 180, 270)
  static Future<Uint8List> rotateImage(Uint8List imageBytes, int degrees) async {
    final image = img.decodeImage(imageBytes);
    if (image == null) throw Exception('Failed to decode image');

    final rotated = img.copyRotate(image, angle: degrees.toDouble());
    return Uint8List.fromList(img.encodeJpg(rotated, quality: 90));
  }

  /// Save bytes to file
  static Future<File> saveBytesToFile(Uint8List bytes, String path) async {
    final file = File(path);
    await file.writeAsBytes(bytes);
    return file;
  }

  /// Load image bytes from file
  static Future<Uint8List> loadImageBytes(String path) async {
    final file = File(path);
    return await file.readAsBytes();
  }
}
