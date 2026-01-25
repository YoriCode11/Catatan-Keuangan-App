import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/transaction.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  // Mendapatkan data milik user yang sedang login saja
  Stream<List<TransactionModel>> getTransactions() {
    final uid = _auth.currentUser?.uid;
    return _db
        .collection('transactions')
        .where('userId', isEqualTo: uid) // Filter berdasarkan user
        .snapshots()
        .map(
          (snap) =>
              snap.docs
                  .map((d) => TransactionModel.fromDoc(d.data(), d.id))
                  .toList(),
        );
  }

  // CREATE: Menambahkan transaksi baru
  Future<void> addTransaction(TransactionModel model) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    // Menggunakan toMap() agar field 'kategori' dan lainnya ikut terkirim
    Map<String, dynamic> data = model.toMap();

    // Pastikan userId dari sistem login yang digunakan
    data['userId'] = uid;

    await _db.collection('transactions').add(data);
  }

  // UPDATE: Memperbarui transaksi yang sudah ada
  Future<void> updateTransaction(String id, TransactionModel model) async {
    // Pastikan ID tidak kosong
    if (id.isEmpty) return;

    // Kita hanya mengupdate field yang ada di toMap()
    // userId akan tetap aman (tidak berubah) di Firestore
    await _db.collection('transactions').doc(id).update(model.toMap());
  }

  // DELETE: Menghapus transaksi
  Future<void> deleteTransaction(String id) async {
    await _db.collection('transactions').doc(id).delete();
  }
}
