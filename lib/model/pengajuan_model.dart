
import 'package:flutter/foundation.dart';

class Pengajuan {
  final int id;
  final String nama;
  final String email;
  final String sesi;
  final String bidang;
  final DateTime tanggal;
  bool selesai;

  Pengajuan({
    required this.id,
    required this.nama,
    required this.email,
    required this.sesi,
    required this.bidang,
    required this.tanggal,
    this.selesai = false,
  });
}

class PengajuanModel extends ChangeNotifier {
  final List<Pengajuan> _daftarPengajuan = [];
  int _idBerikutnya = 1;

  List<Pengajuan> get daftarPengajuan =>
      List.unmodifiable(_daftarPengajuan);

  void tambahPengajuan({
    required String nama,
    required String email,
    required String sesi,
    required String bidang,
  }) {
    final pengajuan = Pengajuan(
      id: _idBerikutnya++,
      nama: nama,
      email: email,
      sesi: sesi,
      bidang: bidang,
      tanggal: DateTime.now(),
    );

    _daftarPengajuan.insert(0, pengajuan);
    notifyListeners();
  }

  Pengajuan? cariPengajuan(int id) {
    for (final item in _daftarPengajuan) {
      if (item.id == id) {
        return item;
      }
    }

    return null;
  }

  void tandaiSelesai(int id) {
    final item = cariPengajuan(id);

    if (item != null && !item.selesai) {
      item.selesai = true;
      notifyListeners();
    }
  }

  Map<String, int> get statistikBidang {
    final hasil = <String, int>{
      'Perizinan': 0,
      'Kesehatan': 0,
      'Transportasi': 0,
    };

    for (final item in _daftarPengajuan) {
      hasil[item.bidang] = (hasil[item.bidang] ?? 0) + 1;
    }

    return hasil;
  }
}
