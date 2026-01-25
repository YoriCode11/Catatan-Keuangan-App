import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/transaction.dart';
import '../../providers/transaction_provider.dart';
import '../../constants/categories.dart';

class EditTransactionSheet extends StatefulWidget {
  final String? id;
  final TransactionModel? existing;

  const EditTransactionSheet({super.key, this.id, this.existing});

  @override
  State<EditTransactionSheet> createState() => _EditTransactionSheetState();
}

class _EditTransactionSheetState extends State<EditTransactionSheet> {
  final jumlahCtrl = TextEditingController();
  final tanggalCtrl = TextEditingController();
  late String jenis;
  late String kategori;

  @override
  void initState() {
    super.initState();
    // Inisialisasi variabel berdasarkan apakah ini EDIT atau TAMBAH BARU
    if (widget.existing != null) {
      jumlahCtrl.text = widget.existing!.jumlah.toString();
      tanggalCtrl.text = widget.existing!.tanggal;
      jenis = widget.existing!.jenis;
      kategori = widget.existing!.kategori;
    } else {
      tanggalCtrl.text = DateTime.now().toString().split(' ')[0];
      jenis = 'masuk';
      kategori = AppCategories.categories.first; // Default: Makan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.id == null ? "Tambah Transaksi" : "Edit Transaksi",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: jumlahCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Jumlah (Rp)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: tanggalCtrl,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: "Tanggal",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(
                    () =>
                        tanggalCtrl.text = pickedDate.toString().split(' ')[0],
                  );
                }
              },
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: jenis,
              decoration: const InputDecoration(
                labelText: "Jenis",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'masuk', child: Text("Pemasukan")),
                DropdownMenuItem(value: 'keluar', child: Text("Pengeluaran")),
              ],
              onChanged: (val) => setState(() => jenis = val!),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: kategori,
              decoration: const InputDecoration(
                labelText: "Kategori",
                border: OutlineInputBorder(),
              ),
              items:
                  AppCategories.categories.map((cat) {
                    return DropdownMenuItem(value: cat, child: Text(cat));
                  }).toList(),
              onChanged: (val) {
                setState(() => kategori = val!); // Memperbarui state lokal
              },
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  if (jumlahCtrl.text.isEmpty) return;

                  final model = TransactionModel(
                    id: widget.id ?? '',
                    userId: widget.existing?.userId ?? '',
                    tanggal: tanggalCtrl.text,
                    jenis: jenis,
                    jumlah: int.tryParse(jumlahCtrl.text) ?? 0,
                    kategori:
                        kategori, // Mengambil nilai kategori terbaru dari state
                  );

                  if (widget.id == null) {
                    context.read<TransactionProvider>().add(model);
                  } else {
                    context.read<TransactionProvider>().update(
                      widget.id!,
                      model,
                    );
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  "Simpan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
