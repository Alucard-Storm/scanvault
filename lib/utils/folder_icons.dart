import 'package:flutter/material.dart';

/// Service to provide smart folder icons based on folder name/category
class FolderIcons {
  FolderIcons._();

  /// Get icon data based on folder name or icon name
  static IconData getIconData(String? iconName, String folderName) {
    // If custom icon is specified, use it
    if (iconName != null && iconName.isNotEmpty) {
      return _getIconFromName(iconName);
    }

    // Otherwise, infer from folder name
    return _getIconFromFolderName(folderName);
  }

  /// Map icon name string to IconData
  static IconData _getIconFromName(String iconName) {
    return _availableIcons[iconName] ?? Icons.folder;
  }

  /// Infer icon from folder name based on smart naming categories
  static IconData _getIconFromFolderName(String folderName) {
    final lowerName = folderName.toLowerCase();

    // Financial category
    if (_containsAny(lowerName, [
      'financial',
      'invoice',
      'bill',
      'receipt',
      'payment',
      'tax',
      'bank',
      'finance',
      'money'
    ])) {
      return Icons.account_balance_wallet;
    }

    // Legal category
    if (_containsAny(lowerName, [
      'legal',
      'contract',
      'agreement',
      'nda',
      'document',
      'law',
      'court'
    ])) {
      return Icons.gavel;
    }

    // Medical category
    if (_containsAny(lowerName, [
      'medical',
      'health',
      'prescription',
      'doctor',
      'hospital',
      'diagnosis',
      'patient',
      'medicine'
    ])) {
      return Icons.local_hospital;
    }

    // Personal/ID category
    if (_containsAny(lowerName, [
      'personal',
      'id',
      'identity',
      'passport',
      'license',
      'driver',
      'card',
      'certificate'
    ])) {
      return Icons.badge;
    }

    // Work category
    if (_containsAny(lowerName, [
      'work',
      'office',
      'business',
      'project',
      'job',
      'career',
      'professional'
    ])) {
      return Icons.work;
    }

    // School/Education category
    if (_containsAny(lowerName, [
      'school',
      'education',
      'study',
      'college',
      'university',
      'course',
      'class',
      'exam'
    ])) {
      return Icons.school;
    }

    // Travel category
    if (_containsAny(lowerName, [
      'travel',
      'trip',
      'vacation',
      'flight',
      'hotel',
      'booking',
      'tour'
    ])) {
      return Icons.flight;
    }

    // Shopping category
    if (_containsAny(lowerName, [
      'shopping',
      'purchase',
      'order',
      'delivery',
      'buy'
    ])) {
      return Icons.shopping_bag;
    }

    // Home category
    if (_containsAny(lowerName, ['home', 'house', 'property', 'rent', 'lease'])) {
      return Icons.home;
    }

    // Insurance category
    if (_containsAny(
        lowerName, ['insurance', 'policy', 'coverage', 'claim'])) {
      return Icons.security;
    }

    // Important category
    if (_containsAny(lowerName, ['important', 'urgent', 'critical', 'priority'])) {
      return Icons.priority_high;
    }

    // Archive category
    if (_containsAny(lowerName, ['archive', 'old', 'past', 'backup'])) {
      return Icons.archive;
    }

    // Default folder icon
    return Icons.folder;
  }

  static bool _containsAny(String text, List<String> keywords) {
    for (final keyword in keywords) {
      if (text.contains(keyword)) return true;
    }
    return false;
  }

  /// Available icons for custom selection
  static const Map<String, IconData> _availableIcons = {
    'folder': Icons.folder,
    'wallet': Icons.account_balance_wallet,
    'gavel': Icons.gavel,
    'hospital': Icons.local_hospital,
    'badge': Icons.badge,
    'work': Icons.work,
    'school': Icons.school,
    'flight': Icons.flight,
    'shopping': Icons.shopping_bag,
    'home': Icons.home,
    'security': Icons.security,
    'priority': Icons.priority_high,
    'archive': Icons.archive,
    'star': Icons.star,
    'favorite': Icons.favorite,
    'bookmark': Icons.bookmark,
    'attach_money': Icons.attach_money,
    'event': Icons.event,
    'description': Icons.description,
    'assignment': Icons.assignment,
    'business_center': Icons.business_center,
    'apartment': Icons.apartment,
    'local_pharmacy': Icons.local_pharmacy,
    'directions_car': Icons.directions_car,
    'restaurant': Icons.restaurant,
    'fitness_center': Icons.fitness_center,
    'pets': Icons.pets,
    'child_care': Icons.child_care,
    'music_note': Icons.music_note,
    'photo': Icons.photo,
    'videocam': Icons.videocam,
    'games': Icons.games,
    'code': Icons.code,
  };

  /// Get list of available icons with their names for selection
  static List<MapEntry<String, IconData>> getAvailableIcons() {
    return _availableIcons.entries.toList();
  }

  /// Get icon name from IconData (reverse lookup)
  static String? getIconName(IconData icon) {
    for (final entry in _availableIcons.entries) {
      if (entry.value == icon) {
        return entry.key;
      }
    }
    return null;
  }
}
