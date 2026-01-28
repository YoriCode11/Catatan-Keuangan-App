import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/transaction_provider.dart';
import '../providers/auth_provider.dart';
import '../services/local_storage_service.dart';
import 'edit_transaction_sheet.dart';
import 'auth/login_screen.dart';

class TransactionListScreen extends StatelessWidget {
  const TransactionListScreen({super.key});

  // Fungsi untuk menampilkan dialog konfirmasi hapus
  void _showDeleteDialog(
    BuildContext context,
    TransactionProvider provider,
    String id,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Hapus Catatan"),
            content: const Text("Yakin ingin menghapus catatan ini?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Batal"),
              ),
              TextButton(
                onPressed: () {
                  provider.delete(id);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Catatan berhasil dihapus")),
                  );
                },
                child: const Text(
                  "Ya, Hapus",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();
    final transactions = provider.transactions;

    double totalMasuk = 0;
    double totalKeluar = 0;
    for (var tx in transactions) {
      if (tx.jenis == 'masuk')
        totalMasuk += tx.jumlah;
      else
        totalKeluar += tx.jumlah;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Catatan Keuangan"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await LocalStorageService().clear();
              await context.read<AuthProvider>().logout();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _summaryItem("Pemasukan", totalMasuk, Colors.greenAccent),
                _summaryItem("Pengeluaran", totalKeluar, Colors.orangeAccent),
                _summaryItem(
                  "Sisa Dana",
                  totalMasuk - totalKeluar,
                  Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
            child:
                transactions.isEmpty
                    ? const Center(child: Text("Belum ada catatan"))
                    : ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final tx = transactions[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                tx.jenis == 'masuk'
                                    ? Colors.green.shade50
                                    : Colors.red.shade50,
                            child: Icon(
                              tx.jenis == 'masuk' ? Icons.add : Icons.remove,
                              color:
                                  tx.jenis == 'masuk'
                                      ? Colors.green
                                      : Colors.red,
                            ),
                          ),
                          title: Text(
                            tx.kategori,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("${tx.tanggal} • Rp ${tx.jumlah}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed:
                                    () => showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder:
                                          (_) => EditTransactionSheet(
                                            id: tx.id,
                                            existing: tx,
                                          ),
                                    ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed:
                                    () => _showDeleteDialog(
                                      context,
                                      provider,
                                      tx.id,
                                    ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => const EditTransactionSheet(),
            ),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _summaryItem(String label, double value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        Text(
          "Rp ${value.toInt()}",
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
