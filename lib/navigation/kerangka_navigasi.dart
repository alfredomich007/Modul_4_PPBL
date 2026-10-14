import 'package:flutter/material.dart';

import '../page/halaman_warga.dart';
import '../page/rincian_layanan_page.dart';
import '../page/rincian_pengajuan_page.dart';
import '../page/tanya_petugas_page.dart';
import '../page/lokasi_kantor_page.dart';
import '../page/statistik_layanan_page.dart';
import 'app_routes.dart';

class KerangkaNavigasi {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.warga:
        return MaterialPageRoute(
          builder: (_) => const HalamanWarga(),
        );

      case AppRoutes.rincianLayanan:
        return MaterialPageRoute(
          builder: (_) => const RincianLayananPage(),
        );

      case AppRoutes.rincianPengajuan:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => RincianPengajuanPage(id: id),
        );

      case AppRoutes.tanyaPetugas:
        return MaterialPageRoute(
          builder: (_) => const TanyaPetugasPage(),
        );

      case AppRoutes.lokasiKantor:
        return MaterialPageRoute(
          builder: (_) => const LokasiKantorPage(),
        );

      case AppRoutes.statistikLayanan:
        return MaterialPageRoute(
          builder: (_) => const StatistikLayananPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const HalamanWarga(),
        );
    }
  }
}
