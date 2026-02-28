# Platform Integration

<cite>
**Referenced Files in This Document**
- [MainActivity.kt](file://android/app/src/main/kotlin/com/example/scanvault/MainActivity.kt)
- [AndroidManifest.xml](file://android/app/src/main/AndroidManifest.xml)
- [build.gradle.kts](file://android/app/build.gradle.kts)
- [gradle.properties](file://android/gradle.properties)
- [build.gradle.kts](file://android/build.gradle.kts)
- [proguard-rules.pro](file://android/app/proguard-rules.pro)
- [AppDelegate.swift](file://ios/Runner/AppDelegate.swift)
- [Info.plist](file://ios/Runner/Info.plist)
- [my_application.cc](file://linux/runner/my_application.cc)
- [CMakeLists.txt](file://linux/CMakeLists.txt)
- [AppDelegate.swift](file://macos/Runner/AppDelegate.swift)
- [Info.plist](file://macos/Runner/Info.plist)
- [main.cpp](file://windows/runner/main.cpp)
- [CMakeLists.txt](file://windows/CMakeLists.txt)
- [pubspec.yaml](file://pubspec.yaml)
- [camera_service.dart](file://lib/services/camera_service.dart)
- [storage_service.dart](file://lib/services/storage_service.dart)
- [encryption_service.dart](file://lib/services/encryption_service.dart)
- [ocr_service.dart](file://lib/services/ocr_service.dart)
</cite>

## Table of Contents
1. [Introduction](#introduction)
2. [Project Structure](#project-structure)
3. [Core Components](#core-components)
4. [Architecture Overview](#architecture-overview)
5. [Detailed Component Analysis](#detailed-component-analysis)
6. [Dependency Analysis](#dependency-analysis)
7. [Performance Considerations](#performance-considerations)
8. [Troubleshooting Guide](#troubleshooting-guide)
9. [Conclusion](#conclusion)
10. [Appendices](#appendices)

## Introduction
This document explains how ScanVault integrates across Android, iOS, and desktop platforms (Linux, macOS, Windows). It covers Android-specific setup (MainActivity, permissions, manifest, Gradle), iOS integration patterns (App Delegate, Info.plist), and desktop platform support (Linux GTK windowing, macOS Cocoa, Windows Win32). It also documents platform-specific services for camera, storage, encryption, and OCR, along with build configuration differences, deployment strategies, and troubleshooting guidance.

## Project Structure
ScanVault follows Flutter’s standard multi-platform layout with platform-specific folders under android/, ios/, linux/, macos/, and windows/. The Dart application resides under lib/ with platform-agnostic services and UI.

```mermaid
graph TB
subgraph "Flutter App (lib)"
L1["lib/main.dart"]
L2["lib/app.dart"]
S1["lib/services/*"]
end
subgraph "Android"
A1["android/app/src/main/AndroidManifest.xml"]
A2["android/app/src/main/kotlin/.../MainActivity.kt"]
A3["android/app/build.gradle.kts"]
A4["android/gradle.properties"]
A5["android/build.gradle.kts"]
A6["android/app/proguard-rules.pro"]
end
subgraph "iOS"
I1["ios/Runner/AppDelegate.swift"]
I2["ios/Runner/Info.plist"]
end
subgraph "Desktop"
D1["linux/runner/my_application.cc"]
D2["linux/CMakeLists.txt"]
D3["macos/Runner/AppDelegate.swift"]
D4["macos/Runner/Info.plist"]
D5["windows/runner/main.cpp"]
D6["windows/CMakeLists.txt"]
end
L1 --> S1
S1 --> A1
S1 --> I1
S1 --> D1
S1 --> D3
S1 --> D5
```

**Diagram sources**
- [AndroidManifest.xml](file://android/app/src/main/AndroidManifest.xml#L1-L58)
- [MainActivity.kt](file://android/app/src/main/kotlin/com/example/scanvault/MainActivity.kt#L1-L6)
- [build.gradle.kts](file://android/app/build.gradle.kts#L1-L46)
- [gradle.properties](file://android/gradle.properties#L1-L3)
- [build.gradle.kts](file://android/build.gradle.kts#L1-L25)
- [proguard-rules.pro](file://android/app/proguard-rules.pro#L1-L19)
- [AppDelegate.swift](file://ios/Runner/AppDelegate.swift#L1-L14)
- [Info.plist](file://ios/Runner/Info.plist#L1-L50)
- [my_application.cc](file://linux/runner/my_application.cc#L1-L149)
- [CMakeLists.txt](file://linux/CMakeLists.txt#L1-L129)
- [AppDelegate.swift](file://macos/Runner/AppDelegate.swift#L1-L14)
- [Info.plist](file://macos/Runner/Info.plist#L1-L33)
- [main.cpp](file://windows/runner/main.cpp#L1-L44)
- [CMakeLists.txt](file://windows/CMakeLists.txt#L1-L109)

**Section sources**
- [AndroidManifest.xml](file://android/app/src/main/AndroidManifest.xml#L1-L58)
- [MainActivity.kt](file://android/app/src/main/kotlin/com/example/scanvault/MainActivity.kt#L1-L6)
- [build.gradle.kts](file://android/app/build.gradle.kts#L1-L46)
- [gradle.properties](file://android/gradle.properties#L1-L3)
- [build.gradle.kts](file://android/build.gradle.kts#L1-L25)
- [proguard-rules.pro](file://android/app/proguard-rules.pro#L1-L19)
- [AppDelegate.swift](file://ios/Runner/AppDelegate.swift#L1-L14)
- [Info.plist](file://ios/Runner/Info.plist#L1-L50)
- [my_application.cc](file://linux/runner/my_application.cc#L1-L149)
- [CMakeLists.txt](file://linux/CMakeLists.txt#L1-L129)
- [AppDelegate.swift](file://macos/Runner/AppDelegate.swift#L1-L14)
- [Info.plist](file://macos/Runner/Info.plist#L1-L33)
- [main.cpp](file://windows/runner/main.cpp#L1-L44)
- [CMakeLists.txt](file://windows/CMakeLists.txt#L1-L109)

## Core Components
- Camera service: Handles camera permission requests, initialization, capture, flash, zoom, and focus. It uses the camera plugin and permission_handler.
- Storage service: Manages custom storage paths via shared preferences and resolves the effective directory for saving files using path_provider.
- Encryption service: Provides AES-256 encryption/decryption for files and secure key storage per folder using flutter_secure_storage with Android encrypted shared preferences.
- OCR service: Uses Google ML Kit Text Recognition to extract text from images and supports structured block extraction.

These services demonstrate platform abstraction via Flutter plugins and platform channels, while platform-specific implementations are encapsulated in platform code.

**Section sources**
- [camera_service.dart](file://lib/services/camera_service.dart#L1-L140)
- [storage_service.dart](file://lib/services/storage_service.dart#L1-L63)
- [encryption_service.dart](file://lib/services/encryption_service.dart#L1-L150)
- [ocr_service.dart](file://lib/services/ocr_service.dart#L1-L93)

## Architecture Overview
The app uses Flutter’s platform channel model:
- Dart code invokes platform-specific plugins or native code via MethodChannel.
- Android/iOS/desktop handle platform-specific tasks (permissions, UI, file system, hardware).
- Services abstract platform differences for camera, storage, encryption, and OCR.

```mermaid
graph TB
subgraph "Dart Layer"
DS["lib/services/*"]
UI["lib/screens/*"]
end
subgraph "Platform Channels"
CH["MethodChannel/BinaryMessenger"]
end
subgraph "Native Layer"
AN["Android: Java/Kotlin/NDK"]
IO["iOS: Swift/Objective-C"]
LX["Linux: GTK/GLib"]
MAC["macOS: Cocoa"]
WN["Windows: Win32"]
end
UI --> DS
DS --> CH
CH --> AN
CH --> IO
CH --> LX
CH --> MAC
CH --> WN
```

[No sources needed since this diagram shows conceptual workflow, not actual code structure]

## Detailed Component Analysis

### Android Integration
- MainActivity extends FlutterFragmentActivity and delegates lifecycle to Flutter.
- Manifest defines camera and storage permissions, required camera hardware features, and queries for text processing.
- Gradle config sets compile/target SDK, Java 17 compatibility, minSdk 29, and Flutter Gradle plugin.
- ProGuard rules keep Flutter wrappers and ignore missing ML Kit language modules and Play Core deferred components.

```mermaid
sequenceDiagram
participant Sys as "Android OS"
participant Act as "MainActivity"
participant Gen as "GeneratedPluginRegistrant"
participant Cam as "camera plugin"
participant Per as "permission_handler"
Sys->>Act : "Launch activity"
Act->>Gen : "register(with : self)"
Act->>Per : "request camera permission"
Per-->>Act : "status"
Act->>Cam : "initialize camera"
Cam-->>Act : "ready"
Act-->>Sys : "render Flutter UI"
```

**Diagram sources**
- [MainActivity.kt](file://android/app/src/main/kotlin/com/example/scanvault/MainActivity.kt#L1-L6)
- [AndroidManifest.xml](file://android/app/src/main/AndroidManifest.xml#L1-L58)
- [build.gradle.kts](file://android/app/build.gradle.kts#L1-L46)
- [camera_service.dart](file://lib/services/camera_service.dart#L1-L140)

**Section sources**
- [MainActivity.kt](file://android/app/src/main/kotlin/com/example/scanvault/MainActivity.kt#L1-L6)
- [AndroidManifest.xml](file://android/app/src/main/AndroidManifest.xml#L1-L58)
- [build.gradle.kts](file://android/app/build.gradle.kts#L1-L46)
- [gradle.properties](file://android/gradle.properties#L1-L3)
- [build.gradle.kts](file://android/build.gradle.kts#L1-L25)
- [proguard-rules.pro](file://android/app/proguard-rules.pro#L1-L19)

### iOS Integration
- AppDelegate registers plugins and defers to FlutterAppDelegate lifecycle.
- Info.plist defines supported orientations, minimum OS requirements, and Flutter-managed metadata.
- Current iOS limitations: No explicit platform channel handlers or native implementations are present in the repository snapshot; integration relies on Flutter plugins and generated registrants.

```mermaid
sequenceDiagram
participant Sys as "iOS System"
participant App as "AppDelegate"
participant Reg as "GeneratedPluginRegistrant"
participant FLT as "FlutterEngine"
Sys->>App : "launch"
App->>Reg : "register(with : self)"
App->>FLT : "super.application(...)"
FLT-->>Sys : "engine ready"
```

**Diagram sources**
- [AppDelegate.swift](file://ios/Runner/AppDelegate.swift#L1-L14)
- [Info.plist](file://ios/Runner/Info.plist#L1-L50)

**Section sources**
- [AppDelegate.swift](file://ios/Runner/AppDelegate.swift#L1-L14)
- [Info.plist](file://ios/Runner/Info.plist#L1-L50)

### Desktop Platforms (Linux, macOS, Windows)
- Linux: GTK-based windowing with header bar handling, window sizing, and plugin registration. The application ID and RPATH are configured for proper bundling.
- macOS: Cocoa app delegate with secure state restoration and termination behavior.
- Windows: Win32 window creation, console attachment, COM initialization, and message loop.

```mermaid
graph TB
subgraph "Linux"
LApp["my_application.cc"]
LCMake["linux/CMakeLists.txt"]
end
subgraph "macOS"
MApp["AppDelegate.swift"]
MCfg["Info.plist"]
end
subgraph "Windows"
WMain["main.cpp"]
WCMake["windows/CMakeLists.txt"]
end
LApp --> LCMake
MApp --> MCfg
WMain --> WCMake
```

**Diagram sources**
- [my_application.cc](file://linux/runner/my_application.cc#L1-L149)
- [CMakeLists.txt](file://linux/CMakeLists.txt#L1-L129)
- [AppDelegate.swift](file://macos/Runner/AppDelegate.swift#L1-L14)
- [Info.plist](file://macos/Runner/Info.plist#L1-L33)
- [main.cpp](file://windows/runner/main.cpp#L1-L44)
- [CMakeLists.txt](file://windows/CMakeLists.txt#L1-L109)

**Section sources**
- [my_application.cc](file://linux/runner/my_application.cc#L1-L149)
- [CMakeLists.txt](file://linux/CMakeLists.txt#L1-L129)
- [AppDelegate.swift](file://macos/Runner/AppDelegate.swift#L1-L14)
- [Info.plist](file://macos/Runner/Info.plist#L1-L33)
- [main.cpp](file://windows/runner/main.cpp#L1-L44)
- [CMakeLists.txt](file://windows/CMakeLists.txt#L1-L109)

### Platform-Specific Services

#### Camera Service
- Requests camera permission via permission_handler.
- Initializes CameraController with preset resolution and JPEG format.
- Supports flash toggling, zoom clamping, and focus point setting.
- Throws domain-specific exceptions on failure.

```mermaid
flowchart TD
Start(["initialize(resolution,cameraIndex)"]) --> Perm["Request camera permission"]
Perm --> PermOK{"Granted?"}
PermOK --> |No| ErrPerm["Throw camera exception"]
PermOK --> |Yes| ListCam["List available cameras"]
ListCam --> HasCam{"Any camera?"}
HasCam --> |No| ErrNoCam["Throw no cameras exception"]
HasCam --> |Yes| InitCtrl["Create CameraController"]
InitCtrl --> CtrlInit["Initialize controller"]
CtrlInit --> Done(["Ready"])
ErrPerm --> End(["Exit"])
ErrNoCam --> End
Done --> End
```

**Diagram sources**
- [camera_service.dart](file://lib/services/camera_service.dart#L1-L140)

**Section sources**
- [camera_service.dart](file://lib/services/camera_service.dart#L1-L140)

#### Storage Service
- Persists a custom storage path in SharedPreferences.
- Resolves effective directory using path_provider; falls back to app documents + “ScanVault”.
- Ensures directory exists and returns full file paths.

```mermaid
flowchart TD
GetDir["getStorageDirectory()"] --> CheckPref["Read custom path from prefs"]
CheckPref --> HasPref{"Custom path exists?"}
HasPref --> |Yes| Exists{"Directory exists?"}
Exists --> |Yes| ReturnPref["Return custom directory"]
Exists --> |No| Default["getApplicationDocumentsDirectory() + 'ScanVault'"]
HasPref --> |No| Default
Default --> Ensure["Ensure directory exists"]
ReturnPref --> Ensure
Ensure --> Done(["Directory"])
```

**Diagram sources**
- [storage_service.dart](file://lib/services/storage_service.dart#L1-L63)

**Section sources**
- [storage_service.dart](file://lib/services/storage_service.dart#L1-L63)

#### Encryption Service
- Generates AES-256 keys and stores them securely per folder.
- Encrypts/decrypts files by prepending IV and renaming appropriately.
- Detects encrypted files by checking file size and IV presence.

```mermaid
flowchart TD
Start(["encryptFile(path,folderId)"]) --> ReadKey["Read key from secure storage"]
ReadKey --> KeyOK{"Key exists?"}
KeyOK --> |No| ErrKey["Throw key not found"]
KeyOK --> |Yes| ReadBytes["Read original file bytes"]
ReadBytes --> Encrypt["Encrypt with AES-256 and random IV"]
Encrypt --> WriteEnc["Write IV + encrypted bytes"]
WriteEnc --> DeleteOrig["Delete original file"]
DeleteOrig --> Rename["Rename to original name"]
Rename --> Done(["Done"])
ErrKey --> End(["Exit"])
```

**Diagram sources**
- [encryption_service.dart](file://lib/services/encryption_service.dart#L1-L150)

**Section sources**
- [encryption_service.dart](file://lib/services/encryption_service.dart#L1-L150)

#### OCR Service
- Uses Google ML Kit TextRecognizer to extract text from images.
- Supports structured block extraction and combining results from multiple images.
- Disposes recognizer when done.

```mermaid
sequenceDiagram
participant Svc as "OcrService"
participant ML as "TextRecognizer"
participant FS as "File System"
Svc->>FS : "Load image from path"
Svc->>ML : "processImage(InputImage)"
ML-->>Svc : "Recognized text"
Svc-->>Caller : "Full text or structured blocks"
```

**Diagram sources**
- [ocr_service.dart](file://lib/services/ocr_service.dart#L1-L93)

**Section sources**
- [ocr_service.dart](file://lib/services/ocr_service.dart#L1-L93)

## Dependency Analysis
- Flutter dependencies include camera, ML Kit OCR/translation, PDF/printing/archive, sqflite/path_provider, Riverpod, GoRouter, permission_handler, shared_preferences, file_picker, local_auth, flutter_secure_storage, encrypt, and others.
- Android build uses Flutter Gradle plugin, Java 17, minSdk 29, and ProGuard rules for ML Kit and Play Core.
- Desktop builds use CMake with platform-specific packaging and installation steps.

```mermaid
graph LR
P["pubspec.yaml"]
P --> CAM["camera"]
P --> MLT["google_mlkit_text_recognition"]
P --> MLD["google_mlkit_translation"]
P --> PDF["pdf/printing/archive"]
P --> ST["sqflite/path_provider"]
P --> PH["permission_handler"]
P --> SSP["shared_preferences"]
P --> FPL["file_picker"]
P --> LA["local_auth"]
P --> FSS["flutter_secure_storage"]
P --> ENC["encrypt"]
```

**Diagram sources**
- [pubspec.yaml](file://pubspec.yaml#L1-L78)

**Section sources**
- [pubspec.yaml](file://pubspec.yaml#L1-L78)

## Performance Considerations
- Android: Use minSdk 29 to leverage modern APIs; keep Java 17 compatibility; configure ProGuard to exclude ML Kit language modules and Play Core deferred components to reduce overhead.
- Desktop: Ensure proper RPATH and asset bundling; avoid unnecessary UI redraws; defer heavy operations (OCR, encryption) to background threads or isolate them to minimize UI stalls.
- General: Cache frequently accessed directories and keys; reuse recognizers and controllers where possible; dispose resources promptly.

[No sources needed since this section provides general guidance]

## Troubleshooting Guide
- Android camera permission denied: Verify camera permission request and manifest camera features; confirm runtime permission handling in CameraService.
- Android storage permission errors: Review READ_EXTERNAL_STORAGE vs scoped storage; ensure WRITE permission and maxSdk adjustments are appropriate for target SDK.
- Android ProGuard/ML Kit: Keep ML Kit language module ignores and Play Core ignores in proguard-rules.pro.
- iOS plugin registration: Confirm GeneratedPluginRegistrant is registered in AppDelegate.
- Desktop windowing: On Linux, header bar detection depends on window manager; on Windows, ensure COM initialization and console attachment for debugging.
- Encryption failures: Validate folder key existence and file size checks; ensure IV prepending logic is intact.

**Section sources**
- [AndroidManifest.xml](file://android/app/src/main/AndroidManifest.xml#L1-L58)
- [proguard-rules.pro](file://android/app/proguard-rules.pro#L1-L19)
- [AppDelegate.swift](file://ios/Runner/AppDelegate.swift#L1-L14)
- [my_application.cc](file://linux/runner/my_application.cc#L1-L149)
- [main.cpp](file://windows/runner/main.cpp#L1-L44)
- [encryption_service.dart](file://lib/services/encryption_service.dart#L1-L150)

## Conclusion
ScanVault integrates seamlessly across Android, iOS, and desktop through Flutter’s platform abstraction. Platform-specific concerns—permissions, manifest configuration, plugin registration, and native windowing—are isolated in platform code, while core services (camera, storage, encryption, OCR) provide a unified Dart API. Build configurations differ per platform but follow established patterns for Gradle, CMake, and plugin registration.

[No sources needed since this section summarizes without analyzing specific files]

## Appendices

### Build Configuration Differences
- Android: Flutter Gradle plugin, Java 17, minSdk 29, ProGuard rules for ML Kit and Play Core.
- Linux: GTK application, RPATH setup, asset bundling, and AOT library installation for non-Debug builds.
- macOS: Cocoa app delegate and Info.plist entries for deployment target and main nib/class.
- Windows: Win32 windowing, COM initialization, and asset bundling into the executable directory.

**Section sources**
- [build.gradle.kts](file://android/app/build.gradle.kts#L1-L46)
- [gradle.properties](file://android/gradle.properties#L1-L3)
- [CMakeLists.txt](file://linux/CMakeLists.txt#L1-L129)
- [Info.plist](file://macos/Runner/Info.plist#L1-L33)
- [CMakeLists.txt](file://windows/CMakeLists.txt#L1-L109)

### Deployment Strategies
- Android: Sign release builds; use optimized ProGuard rules; publish to stores with appropriate permissions declared.
- Desktop: Package assets and plugins; install ICU data and AOT libraries for non-Debug modes; ensure RPATH for Linux bundles.
- iOS: Register plugins and ensure Info.plist keys align with supported orientations and minimum OS.

**Section sources**
- [build.gradle.kts](file://android/app/build.gradle.kts#L33-L40)
- [CMakeLists.txt](file://linux/CMakeLists.txt#L78-L129)
- [Info.plist](file://ios/Runner/Info.plist#L1-L50)