import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'register_screen.dart';
import '../../services/local_storage_service.dart';
import '../transaction_list_screen.dart'; // Tambahkan import ini

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String? error;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(error!, style: const TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 16),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                      error = null;
                    });

                    final email = emailCtrl.text.trim();
                    final pass = passCtrl.text.trim();

                    // 1. Panggil fungsi login dari AuthProvider
                    final result = await context.read<AuthProvider>().login(
                      email,
                      pass,
                    );

                    if (result == null) {
                      // 2. Jika Berhasil, simpan ke Local Storage (Poin UAS)
                      await LocalStorageService().saveEmail(email);

                      if (mounted) {
                        // 3. Pindah ke Halaman Transaksi
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const TransactionListScreen(),
                          ),
                        );
                      }
                    } else {
                      // 4. Jika Gagal, tampilkan pesan error
                      setState(() {
                        error = result;
                        isLoading = false;
                      });
                    }
                  },
                  child: const Text("Login"),
                ),
            TextButton(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  ),
              child: const Text("Buat Akun"),
            ),
          ],
        ),
      ),
    );
  }
}
