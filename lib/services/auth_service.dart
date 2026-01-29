import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

/// Service for handling biometric and PIN authentication
class AuthService {
  static final LocalAuthentication _auth = LocalAuthentication();

  /// Check if biometric authentication is available on device
  static Future<bool> canAuthenticate() async {
    try {
      return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    } catch (e) {
      return false;
    }
  }

  /// Get list of available biometric types
  static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (e) {
      return [];
    }
  }

  /// Authenticate user using biometric or device credentials
  static Future<bool> authenticate({
    required String reason,
    bool biometricOnly = false,
  }) async {
    try {
      final canAuth = await canAuthenticate();
      if (!canAuth) {
        return false;
      }

      return await _auth.authenticate(
        localizedReason: reason,
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: biometricOnly,
        ),
      );
    } on PlatformException catch (e) {
      // Handle specific error codes if needed
      print('Authentication error: ${e.code} - ${e.message}');
      return false;
    } catch (e) {
      print('Authentication error: $e');
      return false;
    }
  }

  /// Stop any ongoing authentication
  static Future<void> stopAuthentication() async {
    try {
      await _auth.stopAuthentication();
    } catch (e) {
      print('Stop authentication error: $e');
    }
  }
}
