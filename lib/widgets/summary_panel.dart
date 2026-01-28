import 'package:flutter/material.dart';

class SummaryPanel extends StatelessWidget {
  final int income;
  final int expense;
  final int balance;

  const SummaryPanel({
    super.key,
    required this.income,
    required this.expense,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    final isSurplus = balance >= 0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ringkasan Keuangan",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pemasukan:",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Rp $income", style: const TextStyle(color: Colors.green)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pengeluaran:",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Rp $expense", style: const TextStyle(color: Colors.red)),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isSurplus ? "Sisa Dana (Surplus):" : "Sisa Dana (Defisit):",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rp $balance",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSurplus ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
