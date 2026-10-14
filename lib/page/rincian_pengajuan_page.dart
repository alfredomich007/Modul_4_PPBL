
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';

class RincianPengajuanPage extends StatelessWidget {
  final int id;

  const RincianPengajuanPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final item = context
        .watch<PengajuanModel>()
        .cariPengajuan(id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian Pengajuan'),
      ),
      body: item == null
          ? const Center(
              child: Text('Pengajuan tidak ditemukan.'),
            )
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _baris('Nomor', item.id.toString()),
                _baris('Nama', item.nama),
                _baris('Email', item.email),
                _baris('Bidang', item.bidang),
                _baris('Sesi', item.sesi),
                _baris(
                  'Tanggal',
                  '${item.tanggal.day}/'
                      '${item.tanggal.month}/'
                      '${item.tanggal.year}',
                ),
                _baris(
                  'Status',
                  item.selesai ? 'Selesai' : 'Diproses',
                ),
              ],
            ),
    );
  }

  Widget _baris(String label, String nilai) {
    return ListTile(
      title: Text(label),
      subtitle: Text(nilai),
    );
  }
}
