import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FinancePieChart extends StatelessWidget {
  final int income;
  final int expense;

  const FinancePieChart({
    super.key,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    final total = income + expense;
    if (total == 0) {
      return const Center(child: Text("Belum ada data"));
    }

    return Card(
      child: SizedBox(
        height: 260,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: PieChart(
            PieChartData(
              sectionsSpace: 4,
              centerSpaceRadius: 50,
              sections: [
                PieChartSectionData(
                  color: Colors.green,
                  value: income.toDouble(),
                  title: "${(income / total * 100).toStringAsFixed(1)}%",
                ),
                PieChartSectionData(
                  color: Colors.red,
                  value: expense.toDouble(),
                  title: "${(expense / total * 100).toStringAsFixed(1)}%",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
