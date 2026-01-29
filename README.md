# ScanVault

A mobile document scanner application built with Flutter that allows users to capture, enhance, and manage scanned documents with OCR, translation, and document export capabilities.

## Features

### 📸 Scanning & Capture

- **Document Scanner**: Full-screen document scanning with Google ML Kit Document Scanner
- **Edge Detection**: Automatic edge detection and perspective correction
- **Batch Scanning**: Scan multiple pages into a single document in one session
- **Single Page Scan**: Quick single-page document capture

### 🎨 Image Enhancement

- **Smart Filters**: Apply various filters to enhance scanned documents
  - Original (no filter)
  - Grayscale
  - Black & White (high contrast)
  - Color Enhancement
- **Image Editor**: Edit scanned pages with filters and enhancements
- **Thumbnail Generation**: Automatic thumbnail creation for quick preview

### 📄 Document Management

- **Folder Organization**: Create custom folders with smart icons and color coding
  - 13 category-based smart icons (Financial, Legal, Medical, Personal, Work, School, Travel, Shopping, Home, Insurance, Important, Archive)
  - 35+ custom icon options
  - Color customization for visual organization
- **Tag System**: Tag documents with custom labels for easy categorization
- **Smart Naming**: Automatic document naming based on content analysis
  - Detects document types (Invoice, Receipt, Contract, Medical Record, ID Card)
  - Extracts and includes dates from document content
  - Suggests folder categories automatically
- **Search**: Full-text search across document names
- **Filter by Tags**: Quick filtering by tags
- **Document Details**: View creation/modification dates and page counts

### 🔒 Security

- **Locked Folders**: Secure sensitive documents with biometric authentication
- **Encryption**: AES-256 encryption for locked folder contents
- **Platform Keystore**: Secure key storage using Android Keystore
- **Biometric Authentication**: Fingerprint/Face unlock support

### 🔤 OCR & Text Processing

- **Text Extraction**: Accurate OCR using Google ML Kit
- **Multi-language Support**: Extract text in multiple languages
- **Translation**: Translate extracted text to various languages
- **Text Editing**: Edit and refine extracted text
- **Text Export**: Export text to DOCX format

### 📤 Export & Sharing

- **PDF Export**: Generate high-quality PDFs with optional OCR text layer
  - Include/exclude OCR text
  - Select specific pages to export
- **Image Export**: Share original scanned images
- **DOCX Export**: Export extracted text as Word documents
- **Share Integration**: Native Android share functionality

### 🌍 Internationalization

- **Multi-language UI**: Support for 10 languages
  - English
  - Hindi (हिंदी)
  - Bengali (বাংলা)
  - Telugu (తెలుగు)
  - Marathi (मराठी)
  - Tamil (தமிழ்)
  - Gujarati (ગુજરાતી)
  - Kannada (ಕನ್ನಡ)
  - Malayalam (മലയാളം)
  - Punjabi (ਪੰਜਾਬੀ)
- **System Language Detection**: Automatically uses device language

### 🎨 User Interface

- **Material Design 3**: Modern and clean interface following Material You guidelines
- **Dynamic Color**: Adapts to Android 12+ dynamic color themes
- **Dark Mode**: Full dark theme support
- **Smooth Animations**: Flutter Animate for delightful micro-interactions
- **Glass Navigation**: Premium glassmorphism bottom navigation bar
- **Responsive Layout**: Grid and list view options

### ⚙️ Settings & Customization

- **Theme Selection**: Light, Dark, or System theme
- **Language Selection**: Choose from 10 supported languages
- **Storage Management**: View storage usage and free up space
- **Custom Storage**: Select custom storage directory

## Tech Stack

### Core Framework

- **Flutter**: ^3.6.2 - Cross-platform mobile development framework
- **Dart**: SDK >=3.6.0 <4.0.0

### State Management

- **flutter_riverpod**: ^2.6.1 - Reactive state management
- **riverpod_annotation**: ^2.6.1 - Code generation for providers

### UI & Design

- **Material 3**: Built-in Flutter Material Design 3
- **flutter_animate**: ^4.5.0 - Smooth animations and transitions
- **Dynamic Color**: Adaptive theming

### Document Scanning & Image Processing

- **google_mlkit_document_scanner**: ^0.2.1 - Document scanning
- **google_mlkit_text_recognition**: ^0.14.1 - OCR capabilities
- **image_picker**: ^1.1.2 - Image selection from gallery/camera
- **image**: ^4.3.0 - Image manipulation
- **flutter_image_compress**: ^2.3.0 - Image compression

### PDF & Document Generation

- **pdf**: ^3.12.0 - PDF generation
- **printing**: ^5.14.0 - Print and share PDFs
- **syncfusion_flutter_pdf**: ^28.1.36 - Advanced PDF features
- **syncfusion_flutter_officechart**: ^28.1.36 - Chart support
- **docx_template**: ^0.6.0 - DOCX generation

### Database & Storage

- **sqflite**: ^2.4.1 - Local SQLite database
- **path_provider**: ^2.1.5 - File system paths
- **path**: ^1.9.1 - Path manipulation

### Security & Authentication

- **local_auth**: ^2.3.0 - Biometric authentication
- **flutter_secure_storage**: ^9.2.2 - Secure key storage
- **encrypt**: ^5.0.3 - AES encryption

### Localization

- **intl**: ^0.20.1 - Internationalization and formatting
- **flutter_localizations**: Built-in - Localization support

### Utilities

- **go_router**: ^14.6.2 - Declarative routing
- **share_plus**: ^10.1.3 - Native sharing
- **permission_handler**: ^11.3.1 - Runtime permissions
- **freezed**: ^2.5.7 + freezed_annotation: ^2.4.4 - Immutable models
- **json_serializable**: ^6.8.0 - JSON serialization
- **uuid**: ^4.5.1 - Unique ID generation

### Development Tools

- **build_runner**: ^2.4.13 - Code generation
- **riverpod_generator**: ^2.6.2 - Provider code generation
- **flutter_lints**: ^5.0.0 - Linting rules

## Requirements

### Platform Requirements

- **Android**:
  - Minimum SDK: 29 (Android 10)
  - Target SDK: 36 (Android 14+)
  - Compile SDK: 36
- **iOS**: Not currently supported (Android-only app)

### Development Requirements

- **Flutter SDK**: >=3.6.2
- **Dart SDK**: >=3.6.0 <4.0.0
- **Android Studio** or **VS Code** with Flutter plugins
- **Java**: JDK 17 or higher (for Android builds)

### Device Requirements

- **RAM**: Minimum 2GB recommended
- **Storage**: At least 100MB free space for app installation
- **Camera**: Required for document scanning
- **Biometric Hardware** (optional): For locked folder feature

## Permissions

### Required Permissions

The app requires the following permissions to function properly:

#### Camera

```xml
<uses-permission android:name="android.permission.CAMERA"/>
```

- **Purpose**: Capture document scans
- **Usage**: Used by Google ML Kit Document Scanner for document capture
- **When Requested**: When user taps "Scan" button

#### Storage

```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="32"/>
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
```

- **Purpose**: Save and retrieve scanned documents
- **Usage**: Store scanned images, PDFs, and document data
- **When Requested**: On first app launch

#### Internet

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

- **Purpose**: OCR and translation services
- **Usage**: Google ML Kit requires internet for some features
- **Note**: No user data is sent to external servers

### Optional Permissions

#### Biometric Authentication

```xml
<uses-permission android:name="android.permission.USE_BIOMETRIC"/>
```

- **Purpose**: Secure locked folders
- **Usage**: Authenticate access to encrypted folders
- **When Requested**: When enabling locked folder feature

### Permission Handling

- All permissions are requested at runtime following Android best practices
- Users can deny permissions; app will gracefully handle missing permissions
- Storage permission is essential for core functionality
- Camera permission is required for scanning features
- Biometric permission is optional for enhanced security features

## Developer

- Alucard Stormbringer

## License

MIT License
