pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.11.1" apply false
    id("org.jetbrains.kotlin.android") version "2.2.20" apply false
}

include(":app")

// Fix for legacy plugins that don't specify namespace (required for AGP 8.0+)
gradle.beforeProject {
    if (name == "edge_detection") {
        buildscript {
            configurations.all {
                resolutionStrategy.eachDependency {
                    if (requested.group == "com.android.tools.build" && requested.name == "gradle") {
                        // Use Gradle version that matches the project
                    }
                }
            }
        }
    }
}

gradle.afterProject {
    // Skip the main app module - it has its own configuration
    if (project.name == "app") return@afterProject
    
    if (project.hasProperty("android")) {
        val android = project.extensions.findByName("android")
        if (android != null && android is com.android.build.gradle.LibraryExtension) {
            if (android.namespace.isNullOrEmpty()) {
                when (project.name) {
                    "edge_detection" -> android.namespace = "com.sample.edgedetection"
                }
            }
            // Fix JVM target compatibility for legacy plugins - match app's Java 17
            android.compileOptions {
                sourceCompatibility = JavaVersion.VERSION_17
                targetCompatibility = JavaVersion.VERSION_17
            }
        }
    }
    // Force Kotlin JVM target to match Java 17
    project.tasks.withType(org.jetbrains.kotlin.gradle.tasks.KotlinCompile::class.java).configureEach {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        }
    }
}
