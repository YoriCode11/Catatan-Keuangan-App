import 'package:flutter_test/flutter_test.dart';
import 'package:catatan_keuangan/models/transaction.dart'; // Sesuaikan dengan nama project di pubspec.yaml

void main() {
  group('TransactionModel Unit Test', () {
    test('Harus berhasil mengonversi Map dari Firestore ke Model', () {
      // Data simulasi dari Firestore
      final mockData = {
        "userId": "user123",
        "tanggal": "2026-01-25",
        "jenis": "masuk",
        "jumlah": 100000,
        "kategori": "Gaji",
      };
      final String mockId = "doc_abc_123";

      // Eksekusi fungsi fromDoc
      final model = TransactionModel.fromDoc(mockData, mockId);

      // Validasi hasil
      expect(model.id, mockId);
      expect(model.jumlah, 100000);
      expect(model.kategori, "Gaji");
      expect(model.jenis, "masuk");
    });

    test(
      'Harus berhasil mengonversi Model ke Map (toMap) untuk disimpan ke Firestore',
      () {
        // Data simulasi model
        final model = TransactionModel(
          id: "99",
          userId: "user123",
          tanggal: "2026-01-25",
          jenis: "keluar",
          jumlah: 20000,
          kategori: "Makan",
        );

        // Eksekusi fungsi toMap
        final map = model.toMap();

        // Validasi hasil Map
        expect(map["jumlah"], 20000);
        expect(map["kategori"], "Makan");
        expect(map["jenis"], "keluar");
        // Memastikan userId TIDAK ada di toMap sesuai logika FirestoreService kita
        expect(map.containsKey("userId"), false);
      },
    );
  });
}
