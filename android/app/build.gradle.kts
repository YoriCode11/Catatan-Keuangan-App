plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.catatan_keuangan"
    compileSdk = flutter.compileSdkVersion
    
    // Perbaikan NDK sesuai error sebelumnya
    ndkVersion = "27.0.12077973" 

    compileOptions {
        // Mengaktifkan Desugaring untuk mendukung fitur Java terbaru
        isCoreLibraryDesugaringEnabled = true 
        
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.catatan_keuangan"
        // MinSdk 21 wajib jika menggunakan desugaring
        minSdk = 23 
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Library pendukung agar fitur notifikasi & firebase lancar di Android lama
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}