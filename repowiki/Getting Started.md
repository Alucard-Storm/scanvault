# Getting Started

<cite>
**Referenced Files in This Document**
- [pubspec.yaml](file://pubspec.yaml)
- [README.md](file://README.md)
- [lib/main.dart](file://lib/main.dart)
- [lib/app.dart](file://lib/app.dart)
- [android/app/build.gradle.kts](file://android/app/build.gradle.kts)
- [android/app/src/main/AndroidManifest.xml](file://android/app/src/main/AndroidManifest.xml)
- [android/local.properties](file://android/local.properties)
- [android/gradle.properties](file://android/gradle.properties)
- [ios/Runner/Info.plist](file://ios/Runner/Info.plist)
- [ios/Runner/AppDelegate.swift](file://ios/Runner/AppDelegate.swift)
- [l10n.yaml](file://l10n.yaml)
</cite>

## Table of Contents
1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Installation](#installation)
4. [First Run and Initial Setup](#first-run-and-initial-setup)
5. [Running the App](#running-the-app)
6. [Platform-Specific Setup](#platform-specific-setup)
7. [Basic Usage](#basic-usage)
8. [Troubleshooting](#troubleshooting)
9. [Verification Procedures](#verification-procedures)
10. [Development Workflow and Debugging](#development-workflow-and-debugging)
11. [Conclusion](#conclusion)

## Introduction
ScanVault is a Flutter-based mobile document scanner with OCR, translation, and export capabilities. It supports Android-only at this time and provides features such as document scanning, image enhancement, folder/tag organization, secure locked folders with biometric authentication, text extraction and translation, and exporting to PDF and DOCX.

## Prerequisites
Before installing and running ScanVault, ensure your development environment meets the following requirements.

- Flutter SDK: Minimum version is indicated in the project configuration.
- Dart SDK: Version range is defined in the project configuration.
- Android development environment:
  - Android Studio or VS Code with Flutter plugins
  - JDK 17 or higher for Android builds
  - Android SDK with minimum SDK level and target SDK level as defined by the project
- iOS:
  - The project is Android-only at this time; iOS is not supported.
- Device or emulator:
  - Android device/emulator with camera and sufficient storage
  - Optional biometric hardware for locked folders

**Section sources**
- [README.md](file://README.md#L160-L183)
- [pubspec.yaml](file://pubspec.yaml#L6-L7)
- [android/app/build.gradle.kts](file://android/app/build.gradle.kts#L27-L28)

## Installation
Follow these steps to clone the repository, install dependencies, and configure your development environment.

1. Clone the repository
   - Use your preferred Git client or command-line tool to clone the repository to your local machine.

2. Install dependencies
   - Navigate to the project root directory.
   - Run the dependency installation command to fetch all required packages defined in the project configuration.

3. Configure Android environment
   - Ensure Android Studio or VS Code with Flutter plugins is installed.
   - Verify JDK 17 or higher is installed and configured.
   - Confirm Android SDK, build tools, and platform-tools are installed.

4. Configure local.properties (if needed)
   - Update the Android SDK path and Flutter SDK path in the local properties file to match your system.

5. Build and run
   - Connect an Android device or start an emulator.
   - Run the application using your IDE or the command-line tool.

**Section sources**
- [README.md](file://README.md#L170-L176)
- [android/local.properties](file://android/local.properties#L1-L5)

## First Run and Initial Setup
On first launch, the app initializes core services and sets up the UI.

- Preferred orientation: Portrait-only orientation is enforced during startup.
- Services initialization:
  - Database service is initialized at startup.
  - Storage service is initialized and registered via provider overrides.
- App shell and routing:
  - The app uses a shell route with a persistent bottom navigation bar.
  - Routes include home, folders, settings, camera, editor, document viewer, OCR, and translation screens.

What happens on first run:
- The app initializes the database and storage services.
- The UI is built with theme and localization providers.
- Navigation routes are configured for the main app areas.

**Section sources**
- [lib/main.dart](file://lib/main.dart#L10-L31)
- [lib/app.dart](file://lib/app.dart#L23-L62)
- [lib/app.dart](file://lib/app.dart#L67-L187)

## Running the App
You can run the app on an emulator or a physical Android device.

- Emulator:
  - Start an Android virtual device with Android 10 (API 29) or higher.
  - Ensure the emulator has camera access and sufficient RAM and storage.
- Physical device:
  - Enable developer options and USB debugging.
  - Connect the device and select it as the target device in your IDE or CLI.

- Build modes:
  - The project defines a default debug build mode in local properties.

- Running commands:
  - Use your IDE’s run button or the command-line tool to build and deploy the app.

**Section sources**
- [README.md](file://README.md#L177-L182)
- [android/local.properties](file://android/local.properties#L3-L5)

## Platform-Specific Setup
Android-only setup details:

- Minimum SDK level and target SDK level:
  - Minimum SDK: 29 (Android 10)
  - Target SDK: aligned with Flutter configuration
  - Compile SDK: aligned with Flutter configuration

- Java compatibility:
  - Java 17 compatibility is required for building Android artifacts.

- Permissions:
  - Camera permission is required for scanning.
  - Storage permissions are required for saving and retrieving documents.
  - Internet permission is required for OCR and translation features.
  - Optional biometric permission for locked folders.

- Manifest and permissions:
  - The Android manifest declares required permissions and camera hardware features.
  - Storage permissions include legacy and media permissions for different Android versions.

- iOS:
  - The project is Android-only at this time; iOS is not supported.

**Section sources**
- [README.md](file://README.md#L164-L168)
- [android/app/build.gradle.kts](file://android/app/build.gradle.kts#L27-L28)
- [android/app/build.gradle.kts](file://android/app/build.gradle.kts#L13-L20)
- [android/app/src/main/AndroidManifest.xml](file://android/app/src/main/AndroidManifest.xml#L3-L12)
- [android/app/src/main/AndroidManifest.xml](file://android/app/src/main/AndroidManifest.xml#L14-L45)
- [ios/Runner/Info.plist](file://ios/Runner/Info.plist#L25-L47)

## Basic Usage
After successful setup and first run, you can use the app as follows:

- Home screen:
  - Access the main dashboard and bottom navigation.
- Scanning:
  - Open the camera screen to scan documents; batch or single-page scanning is supported.
- Editing:
  - Use the editor screen to apply filters and enhancements to scanned pages.
- Document viewer:
  - View document details, pages, and metadata.
- OCR and translation:
  - Extract text and translate it to multiple languages.
- Folders and tags:
  - Organize documents into folders and tag them for quick filtering.
- Settings:
  - Adjust theme, language, storage preferences, and other app settings.

Navigation highlights:
- Bottom navigation provides persistent access to major sections.
- Dedicated routes handle camera, editor, document viewer, OCR, and translation flows.

**Section sources**
- [lib/app.dart](file://lib/app.dart#L70-L187)

## Troubleshooting
Common setup and runtime issues:

- Flutter/Dart version mismatch:
  - Ensure your Flutter and Dart SDK versions meet the project’s minimum requirements.

- Android build failures:
  - Verify JDK 17 is installed and selected by your IDE.
  - Confirm Android SDK, build tools, and platform-tools are installed.

- Missing Android SDK path:
  - Update the Android SDK path in local properties to match your system.

- Permissions denied:
  - On first launch, storage permissions are requested. Grant permissions to enable core functionality.
  - Camera permission is required for scanning; grant when prompted.

- Emulator limitations:
  - Some emulators lack camera access. Use a physical device for scanning or enable camera emulation if supported.

- iOS not supported:
  - The project targets Android only; iOS builds are not supported.

- Localization issues:
  - Ensure localization resources are present and configured correctly.

**Section sources**
- [README.md](file://README.md#L170-L176)
- [android/local.properties](file://android/local.properties#L1-L2)
- [android/app/src/main/AndroidManifest.xml](file://android/app/src/main/AndroidManifest.xml#L3-L12)
- [ios/Runner/Info.plist](file://ios/Runner/Info.plist#L25-L47)

## Verification Procedures
To verify your setup and confirm the app runs correctly:

- Build verification:
  - Run a successful build using your IDE or CLI to ensure dependencies resolve and code compiles.

- Device/emulator connectivity:
  - Confirm your device or emulator is detected by the Flutter tool and selected as the target.

- First-run checks:
  - Launch the app and verify:
    - Orientation is locked to portrait.
    - Database and storage services initialize without errors.
    - Navigation loads the home screen with bottom navigation.

- Feature checks:
  - Test camera access and scanning flow.
  - Verify OCR and translation features work with internet permission granted.
  - Confirm document export to PDF and DOCX completes successfully.

- Permissions:
  - Accept storage and camera permissions when prompted.
  - Optionally enable biometric authentication for locked folders.

**Section sources**
- [lib/main.dart](file://lib/main.dart#L10-L31)
- [lib/app.dart](file://lib/app.dart#L23-L62)
- [android/app/src/main/AndroidManifest.xml](file://android/app/src/main/AndroidManifest.xml#L3-L12)

## Development Workflow and Debugging
Recommended development practices:

- Code generation:
  - Use the project’s code generation tools to keep providers, models, and localization up to date.

- Linting:
  - Follow the project’s linting rules to maintain code quality.

- Localization:
  - Manage translations using the ARB files and the localization configuration.

- Debugging:
  - Use your IDE’s debugger to step through initialization and routing logic.
  - Inspect logs for permission requests and service initialization messages.

- Testing:
  - Run unit and widget tests as provided in the project structure.

- Hot reload:
  - Use hot reload frequently during development for rapid iteration.

- Build variants:
  - Use debug mode for development and testing; configure release signing for distribution.

**Section sources**
- [pubspec.yaml](file://pubspec.yaml#L66-L74)
- [analysis_options.yaml](file://analysis_options.yaml#L10-L29)
- [l10n.yaml](file://l10n.yaml#L1-L4)

## Conclusion
You are now ready to develop and run ScanVault on Android. Ensure your environment meets the prerequisites, follow the installation and setup steps, and use the troubleshooting and verification procedures to resolve common issues. Explore the app’s scanning, editing, OCR, translation, and export features to become familiar with the application flow.