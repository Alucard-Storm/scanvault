import 'package:intl/intl.dart';

/// Service to analyze text and offer smart suggestions for naming and categorization
class SmartNamingService {
  SmartNamingService._();

  /// Analyze text to suggest a document name and folder category
  static SmartSuggestion analyzeContent(String text) {
    String? suggestedName;
    String? suggestedCategory;

    // 1. Detect Document Type & Category
    final lowerText = text.toLowerCase();
    
    if (_containsAny(lowerText, ['invoice', 'bill', 'total', 'amount due', 'payment'])) {
      suggestedName = 'Invoice';
      suggestedCategory = 'Financial';
    } else if (_containsAny(lowerText, ['receipt', 'transaction'])) {
      suggestedName = 'Receipt';
      suggestedCategory = 'Financial';
    } else if (_containsAny(lowerText, ['contract', 'agreement', 'nda', 'memorandum'])) {
      suggestedName = 'Contract';
      suggestedCategory = 'Legal';
    } else if (_containsAny(lowerText, ['prescription', 'medical report', 'diagnosis', 'patient'])) {
      suggestedName = 'Medical Record';
      suggestedCategory = 'Medical';
    } else if (_containsAny(lowerText, ['passport', 'identity card', 'driver license', 'license'])) {
      suggestedName = 'ID Card';
      suggestedCategory = 'Personal';
    }

    // 2. Extract Date
    final date = _extractDate(text);
    if (date != null && suggestedName != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(date);
      suggestedName = '$suggestedName $formattedDate';
    }

    return SmartSuggestion(
      name: suggestedName,
      category: suggestedCategory,
    );
  }

  static bool _containsAny(String text, List<String> keywords) {
    for (final keyword in keywords) {
      if (text.contains(keyword)) return true;
    }
    return false;
  }

  static DateTime? _extractDate(String text) {
    // Basic date patterns: YYYY-MM-DD, DD/MM/YYYY, MM/DD/YYYY, DD-MM-YYYY
    // This is a simplified regex approach.
    final datePatterns = [
      RegExp(r'\b\d{4}-\d{2}-\d{2}\b'), // YYYY-MM-DD
      RegExp(r'\b\d{2}/\d{2}/\d{4}\b'), // DD/MM/YYYY or MM/DD/YYYY
      RegExp(r'\b\d{2}-\d{2}-\d{4}\b'), // DD-MM-YYYY
      RegExp(r'\b\d{1,2}\s(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[a-z]*\s\d{4}\b', caseSensitive: false), // 12 Jan 2023
    ];

    for (final regex in datePatterns) {
      final match = regex.firstMatch(text);
      if (match != null) {
        try {
          String dateStr = match.group(0)!;
          // Normalize and parse based on assumed formats (naive approach)
          // Ideally use a more robust date parser or attempt multiple formats
          
          if (dateStr.contains('-')) {
             if (dateStr.length == 10 && dateStr[4] == '-') {
                return DateTime.parse(dateStr); // YYYY-MM-DD
             }
             // Handle DD-MM-YYYY -> naive flip
             final parts = dateStr.split('-');
             if (parts.length == 3 && parts[2].length == 4) {
               return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
             }
          } else if (dateStr.contains('/')) {
             final parts = dateStr.split('/');
             if (parts.length == 3 && parts[2].length == 4) {
               // Ambiguous between DD/MM and MM/DD. Defaulting to DD/MM/YYYY for international context
               return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
             }
          } else {
             // Text format like "12 Jan 2023"
             return DateFormat("d MMM yyyy").parse(dateStr);
          }
        } catch (e) {
          // Date parse failed, continue
        }
      }
    }
    return null;
  }
}

class SmartSuggestion {
  final String? name;
  final String? category;

  SmartSuggestion({this.name, this.category});
}
