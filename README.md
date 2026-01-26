# 📱 Catatan Keuangan 

Aplikasi manajemen keuangan pribadi berbasis Flutter dan Firebase yang dirancang untuk membantu pengguna mencatat pemasukan dan pengeluaran secara cerdas, aman, dan real-time. Proyek ini merupakan tugas akhir (UAS) untuk mata kuliah Pengembangan Aplikasi Mobile.

![Banner Aplikasi](https://raw.githubusercontent.com/YoriCode11/Catatan-Keuangan-App/main/screenshots/hero_banner.png)

## ✨ Fitur Utama & Dokumentasi Antarmuka

### 🔐 1. Authentication (Firebase Auth)
Fitur pendaftaran dan masuk akun untuk menjamin keamanan data setiap pengguna.
* **Keamanan**: Menggunakan Firebase Authentication (Email & Password).
* **Validasi**: Form login dilengkapi pengecekan input.

| Halaman Login | Halaman Register |
|---|---|
| ![Login](screenshots/login.png) | ![Register](screenshots/register.png) |

---

### 📊 2. Real-time Dashboard (Firestore CRUD)
Halaman utama yang menampilkan ringkasan saldo secara otomatis berdasarkan data transaksi.
* **Summary Panel**: Total Pemasukan, Pengeluaran, dan Saldo (In/Out/Balance).
* **Transaction List**: Menampilkan data secara real-time dari Firestore.

![Dashboard](screenshots/dashboard.png)

---

### 📝 3. Manajemen Transaksi (Create/Update/Delete)
Sistem pencatatan keuangan yang fleksibel dengan kategori yang sudah ditentukan.
* **Kategori**: Makan, Transport, Belanja, Tagihan, Gaji, dan Lainnya.
* **CRUD**: Pengguna dapat menambah, mengedit, dan menghapus catatan transaksi.

| Form Tambah/Edit | Detail Kategori |
|---|---|
| ![Form](screenshots/form_input.png) | ![Kategori](screenshots/category_picker.png) |

---

### 🔔 4. Scheduling & Local Storage
Fitur lanjutan untuk meningkatkan pengalaman pengguna (UX).
* **Scheduling**: Notifikasi pengingat harian untuk mencatat keuangan (Notification Service).
* **Auto-Login**: Aplikasi menyimpan sesi login terakhir di perangkat (Shared Preferences).

![Notification](screenshots/notification_demo.png)

## 🛠️ Detail Teknis & Arsitektur

### 🏗️ Arsitektur Proyek
Aplikasi ini menggunakan pola **Clean Architecture** dengan **Provider** sebagai State Management untuk memastikan kode mudah dikelola dan diuji.

* **Models**: Mendefinisikan struktur data transaksi (`transaction.dart`).
* **Providers**: Mengelola logika bisnis dan sinkronisasi state antara UI dan Firebase.
* **Services**: Menangani integrasi pihak ketiga (Firebase Auth, Firestore, Local Storage, dan Notification).
* **Screens & Widgets**: Komponen antarmuka yang reaktif terhadap perubahan data.

---

### 🧪 Pengujian Unit (Unit Testing)
Untuk menjamin integritas data, aplikasi ini menyertakan Unit Test pada lapisan Model untuk memvalidasi konversi data ke/dari Firestore.

**Cara menjalankan test:**
```bash
flutter test test/transaction_test.dart
