import 'package:flutter/foundation.dart';
import '../models/transaction.dart';
import '../services/firestore_service.dart';

class TransactionProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  // Constructor: Langsung ambil data saat Provider dibuat
  TransactionProvider() {
    _fetchTransactions();
  }

  void _fetchTransactions() {
    _firestoreService.getTransactions().listen((data) {
      _transactions = data;
      notifyListeners();
    });
  }

  // Hitung Total (Bisa dibedakan masuk/keluar)
  double get totalBalance {
    double total = 0;
    for (var tx in _transactions) {
      if (tx.jenis == 'masuk') {
        total += tx.jumlah;
      } else {
        total -= tx.jumlah;
      }
    }
    return total;
  }

  // CREATE ke Firebase
  Future<void> add(TransactionModel tx) async {
    await _firestoreService.addTransaction(tx);
    // notifyListeners() tidak perlu karena sudah ada Stream .listen() di atas
  }

  // UPDATE ke Firebase
  Future<void> update(String id, TransactionModel newTx) async {
    await _firestoreService.updateTransaction(id, newTx);
  }

  // DELETE dari Firebase
  Future<void> delete(String id) async {
    await _firestoreService.deleteTransaction(id);
  }
}
