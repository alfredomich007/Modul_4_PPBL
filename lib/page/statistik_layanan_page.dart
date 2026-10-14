
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../model/pengajuan_model.dart';

class StatistikLayananPage extends StatelessWidget {
  const StatistikLayananPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statistik =
        context.watch<PengajuanModel>().statistikBidang;

    final bidang = statistik.keys.toList();
    final jumlah = statistik.values.toList();

    final terbesar = jumlah.isEmpty
        ? 0
        : jumlah.reduce((a, b) => a > b ? a : b);

    final maksimum = (terbesar + 1).toDouble();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik Layanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Jumlah Pengajuan per Bidang',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: maksimum < 5 ? 5 : maksimum,
                  alignment: BarChartAlignment.spaceAround,
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 35,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 48,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();

                          if (index < 0 || index >= bidang.length) {
                            return const SizedBox.shrink();
                          }

                          return SideTitleWidget(
                            meta: meta,
                            child: Text(
                              bidang[index],
                              style: const TextStyle(fontSize: 10),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: List.generate(
                    bidang.length,
                    (index) => BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: jumlah[index].toDouble(),
                          width: 28,
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ...List.generate(
              bidang.length,
              (index) => ListTile(
                title: Text(bidang[index]),
                trailing: Text('${jumlah[index]} pengajuan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
