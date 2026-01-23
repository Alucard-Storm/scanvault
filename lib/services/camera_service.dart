import 'dart:async';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../core/exceptions/app_exceptions.dart';

/// Service for handling camera operations
class CameraService {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;

  /// Get available cameras
  Future<List<CameraDescription>> getAvailableCameras() async {
    _cameras ??= await availableCameras();
    return _cameras!;
  }

  /// Check if camera is initialized
  bool get isInitialized => _isInitialized;

  /// Get current camera controller
  CameraController? get controller => _controller;

  /// Request camera permission
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  /// Initialize camera with specified resolution
  Future<void> initialize({
    ResolutionPreset resolution = ResolutionPreset.high,
    int cameraIndex = 0,
  }) async {
    try {
      // Check permission
      if (!await requestCameraPermission()) {
        throw ScanCameraException('Camera permission denied');
      }

      // Get cameras
      final cameras = await getAvailableCameras();
      if (cameras.isEmpty) {
        throw ScanCameraException('No cameras available');
      }

      // Use rear camera by default
      final camera = cameras.length > cameraIndex ? cameras[cameraIndex] : cameras.first;

      // Dispose existing controller
      await dispose();

      // Create new controller
      _controller = CameraController(
        camera,
        resolution,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await _controller!.initialize();
      _isInitialized = true;
    } catch (e) {
      _isInitialized = false;
      if (e is ScanCameraException) rethrow;
      throw ScanCameraException('Failed to initialize camera', e);
    }
  }

  /// Take a picture and return the file path
  Future<String> takePicture() async {
    if (!_isInitialized || _controller == null) {
      throw ScanCameraException('Camera not initialized');
    }

    try {
      final file = await _controller!.takePicture();
      return file.path;
    } catch (e) {
      throw ScanCameraException('Failed to capture image', e);
    }
  }

  /// Set flash mode
  Future<void> setFlashMode(FlashMode mode) async {
    if (_controller == null) return;
    try {
      await _controller!.setFlashMode(mode);
    } catch (e) {
      debugPrint('Failed to set flash mode: $e');
    }
  }

  /// Toggle flash between off and torch
  Future<FlashMode> toggleFlash() async {
    if (_controller == null) return FlashMode.off;

    final currentMode = _controller!.value.flashMode;
    final newMode = currentMode == FlashMode.off ? FlashMode.torch : FlashMode.off;
    await setFlashMode(newMode);
    return newMode;
  }

  /// Set zoom level (1.0 to maxZoom)
  Future<void> setZoomLevel(double zoom) async {
    if (_controller == null) return;
    try {
      final minZoom = await _controller!.getMinZoomLevel();
      final maxZoom = await _controller!.getMaxZoomLevel();
      final clampedZoom = zoom.clamp(minZoom, maxZoom);
      await _controller!.setZoomLevel(clampedZoom);
    } catch (e) {
      debugPrint('Failed to set zoom: $e');
    }
  }

  /// Focus on a specific point
  Future<void> setFocusPoint(Offset point) async {
    if (_controller == null) return;
    try {
      await _controller!.setFocusPoint(point);
      await _controller!.setFocusMode(FocusMode.auto);
    } catch (e) {
      debugPrint('Failed to set focus point: $e');
    }
  }

  /// Dispose camera controller
  Future<void> dispose() async {
    if (_controller != null) {
      await _controller!.dispose();
      _controller = null;
      _isInitialized = false;
    }
  }
}
