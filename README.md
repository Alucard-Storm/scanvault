# ScanVault

A mobile document scanner application built with Flutter that allows users to capture, enhance, and manage scanned documents with OCR, translation, and document export capabilities.

## Features

- **Document Detection**: Automatic edge detection and perspective correction
- **Image Enhancement**: Apply filters (grayscale, black & white, color enhancement)
- **Multi-page Scanning**: Scan multiple pages into a single document
- **OCR (Text Recognition)**: Extract text from scanned documents
- **Translation**: Translate extracted text to multiple languages
- **Document Export**: Export OCR text to PDF and DOCX formats
- **Organization**: Create folders and tag documents for easy retrieval
- **Material 3 Design**: Modern UI following Material Design 3 guidelines

## Tech Stack

- **Framework**: Flutter
- **Design**: Material 3 (Material You)
- **Image Processing**: OpenCV or flutter_image libraries
- **PDF Generation**: pdf package
- **DOCX Generation**: docx_template or flutter_docx
- **Camera**: camera plugin
- **OCR**: google_mlkit_text_recognition
- **Translation**: google_mlkit_translation or translator package
- **Local Storage**: sqflite or hive

## Requirements

### SDK Versions
- **Minimum SDK**: 29 (Android 10)
- **Target SDK**: 36
- **Flutter SDK**: 3.0+

### Prerequisites
- Android Studio or VS Code
- Android device/emulator (API level 29+)

### Installation

```bash
# Clone the repository
git clone https://github.com/Alucard-Storm/scanvault.git

# Navigate to project directory
cd scanvault

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## Project Structure

```
lib/
├── models/          # Data models
├── screens/         # UI screens
├── widgets/         # Reusable widgets
├── services/        # Business logic (OCR, translation, export)
├── utils/           # Helper functions
└── theme/           # Material 3 theme configuration
```

## Permissions Required

- Camera access
- Storage read/write
- Internet (for translation features)

## Developer

**Alucard Stormbringer**

## License

MIT License
