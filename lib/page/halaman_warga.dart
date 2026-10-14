
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    final daftar =
        context.watch<PengajuanModel>().daftarPengajuan;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nusantara Cerdas'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Layanan Warga',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            _menu(context, 'Warga', AppRoutes.warga),
            _menu(
              context,
              'Tanya Petugas',
              AppRoutes.tanyaPetugas,
            ),
            _menu(
              context,
              'Lokasi Kantor',
              AppRoutes.lokasiKantor,
            ),
            _menu(
              context,
              'Statistik Layanan',
              AppRoutes.statistikLayanan,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Riwayat Pengajuan',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ketuk kartu untuk melihat rincian. '
              'Tekan lama untuk menandai selesai.',
            ),
            const SizedBox(height: 12),
            Expanded(
              child: daftar.isEmpty
                  ? const Center(
                      child: Text(
                        'Belum ada pengajuan.',
                      ),
                    )
                  : ListView.builder(
                      itemCount: daftar.length,
                      itemBuilder: (context, index) {
                        final item = daftar[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.rincianPengajuan,
                              arguments: item.id,
                            );
                          },
                          onLongPress: () {
                            context
                                .read<PengajuanModel>()
                                .tandaiSelesai(item.id);

                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Pengajuan selesai ditindaklanjuti.',
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: ListTile(
                              leading: Icon(
                                item.selesai
                                    ? Icons.check_circle
                                    : Icons.assignment,
                              ),
                              title: Text(item.bidang),
                              subtitle: Text(
                                '${item.nama}\nSesi ${item.sesi}',
                              ),
                              isThreeLine: true,
                              trailing: Text(
                                item.selesai
                                    ? 'Selesai'
                                    : 'Diproses',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.rincianLayanan,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _menu(
    BuildContext context,
    String judul,
    String route,
  ) {
    return ListTile(
      title: Text(judul),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}
