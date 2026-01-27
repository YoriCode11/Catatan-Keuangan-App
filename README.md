# 📱 Catatan Keuangan

Aplikasi manajemen keuangan pribadi berbasis Flutter dan Firebase yang dirancang untuk membantu pengguna mencatat pemasukan dan pengeluaran secara cerdas, aman, dan real-time.

![Banner Aplikasi](https://raw.githubusercontent.com/YoriCode11/Catatan-Keuangan-App/main/screenshots/hero_banner.png)

## 🚀 Tech Stack
* **Framework**: Flutter (Multi-platform)
* **Backend**: Firebase Authentication & Cloud Firestore (Real-time Database)
* **State Management**: Provider
* **Local Features**: Shared Preferences & Flutter Local Notifications

---

## ✨ Fitur Utama & Dokumentasi Antarmuka

### 🔐 1. Authentication (Firebase Auth)
Fitur pendaftaran dan masuk akun untuk menjamin keamanan data setiap pengguna.
| Halaman Login | Halaman Register |
|---|---|
| ![Login](screenshots/login.png) | ![Register](screenshots/register.png) |

### 📊 2. Real-time Dashboard & Cloud Sync
Sinkronisasi otomatis dengan **Cloud Firestore**. Setiap transaksi yang dicatat akan langsung tersimpan di server.
* **Evidence Cloud**: Data terstruktur tersimpan di Firebase Console.
![Firebase Console](screenshots/firebase_evidence.png) 
*(Gunakan image_840b55.png di sini)*

### 📝 3. Manajemen Transaksi (CRUD)
Pengguna dapat menambah, mengedit, dan menghapus catatan transaksi dengan kategori lengkap.
| Dashboard Utama | Form Input |
|---|---|
| ![Dashboard](screenshots/dashboard.png) | ![Form](screenshots/form_input.png) |

### 🔔 4. Scheduling Notification
Sistem pengingat otomatis (Reminder) yang dijadwalkan muncul setiap hari pukul **20:00**.
* Menggunakan `Flutter Local Notifications` dengan dukungan zona waktu lokal (`timezone`).
![Notification](screenshots/notification_demo.png)

---

## 🛠️ Detail Teknis

### 🏗️ Arsitektur Proyek
Aplikasi menggunakan pola **Clean Architecture** untuk pemisahan logika bisnis (Services), manajemen state (Provider), dan antarmuka (UI).

### ⚙️ Konfigurasi Lingkungan
* **SDK**: Flutter 3.x
* **JDK**: OpenJDK 17
* **Android NDK**: 27.0.12077973
* **Min SDK**: 23 (Android 6.0+)
* **Tested Device**: POCO M3 (Android 11)

---

## 🧪 Pengujian & Instalasi
Aplikasi telah melewati tahap **Unit Testing** pada model data transaksi.

**Cara Menjalankan Test:**
```bash
flutter test test/transaction_test.dart
