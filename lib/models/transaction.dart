class TransactionModel {
  final String id;
  final String userId;
  final String tanggal;
  final String jenis;
  final int jumlah;
  final String kategori;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.tanggal,
    required this.jenis,
    required this.jumlah,
    required this.kategori,
  });

  factory TransactionModel.fromDoc(Map<String, dynamic> json, String id) {
    return TransactionModel(
      id: id,
      userId: json["userId"] ?? "",
      tanggal: json["tanggal"] ?? "",
      jenis: json["jenis"] ?? "masuk",
      jumlah: json["jumlah"] ?? 0,
      kategori: json["kategori"] ?? "Lainnya",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "tanggal": tanggal,
      "jenis": jenis,
      "jumlah": jumlah,
      "kategori": kategori, // WAJIB ADA AGAR TIDAK KEMBALI KE DEFAULT
    };
  }
}
