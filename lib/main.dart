import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

// Import Services
import 'firebase_options.dart';
import 'services/local_storage_service.dart';
import 'services/notification_service.dart';

// Import Providers
import 'providers/auth_provider.dart';
import 'providers/transaction_provider.dart';

// Import Screens
import 'screens/auth/login_screen.dart';
import 'screens/transaction_list_screen.dart';

void main() async {
  // 1. Pastikan binding Flutter sudah siap sebelum menjalankan fungsi async
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Inisialisasi Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 3. Inisialisasi & Jalankan Scheduling Notifikasi (Poin UAS: 20)
  // Memanggil init() di sini akan memicu pop-up izin di Android 13+
  final notifService = NotificationService();
  await notifService.init();
  await notifService.scheduleDailyReminder();

  // 4. Cek Local Storage untuk Session Login (Poin UAS: 10)
  final storage = LocalStorageService();
  final savedEmail = await storage.getEmail();

  runApp(
    // 5. Daftarkan semua Provider untuk State Management
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
      ],
      child: MyApp(initialEmail: savedEmail),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? initialEmail;
  const MyApp({super.key, this.initialEmail});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Keuangan UAS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        // Konsistensi font atau tema bisa ditambahkan di sini
      ),
      // 6. Logika Auto-Login
      // Jika email ditemukan di storage, langsung arahkan ke Dashboard
      home:
          initialEmail == null
              ? const LoginScreen()
              : const TransactionListScreen(),
    );
  }
}
