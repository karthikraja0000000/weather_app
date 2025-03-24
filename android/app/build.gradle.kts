plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") // Flutter Plugin must be last
}

android {
    namespace = "com.example.weather_ui"
    compileSdk = 35 // Update this manually to the latest version

    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17" // Match JVM Target with Java 17
    }

    defaultConfig {
        applicationId = "com.example.weather_ui"
        minSdk = 21  // Set manually or check Flutter's minSdk
        targetSdk = 34 // Update this manually
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug") // Keep this for now
        }
    }

    java {
        toolchain.languageVersion.set(JavaLanguageVersion.of(17)) // Correct way to set Java version
    }
}

flutter {
    source = "../.."
}
