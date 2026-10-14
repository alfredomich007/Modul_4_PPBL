
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';
import '../navigation/app_routes.dart';

class RincianLayananPage extends StatefulWidget {
  const RincianLayananPage({super.key});

  @override
  State<RincianLayananPage> createState() =>
      _RincianLayananPageState();
}

class _RincianLayananPageState
    extends State<RincianLayananPage> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();

  bool setuju = false;
  bool loading = false;
  String sesi = 'Pagi';
  String bidang = 'Perizinan';

  bool get formValid {
    return namaController.text.trim().isNotEmpty &&
        RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
            .hasMatch(emailController.text.trim()) &&
        setuju &&
        !loading;
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> kirimPengajuan() async {
    if (!formValid) return;

    setState(() => loading = true);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    context.read<PengajuanModel>().tambahPengajuan(
      nama: namaController.text.trim(),
      email: emailController.text.trim(),
      sesi: sesi,
      bidang: bidang,
    );

    setState(() => loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pengajuan berhasil disimpan.'),
      ),
    );

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.warga,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian Layanan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: 'Nama lengkap',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: const OutlineInputBorder(),
                errorText: emailController.text.isNotEmpty &&
                        !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                            .hasMatch(emailController.text.trim())
                    ? 'Format email belum valid'
                    : null,
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: bidang,
              decoration: const InputDecoration(
                labelText: 'Bidang layanan',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Perizinan',
                  child: Text('Perizinan'),
                ),
                DropdownMenuItem(
                  value: 'Kesehatan',
                  child: Text('Kesehatan'),
                ),
                DropdownMenuItem(
                  value: 'Transportasi',
                  child: Text('Transportasi'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => bidang = value);
                }
              },
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Sesi kunjungan'),
            ),
            ...['Pagi', 'Siang', 'Sore'].map(
              (value) => RadioListTile<String>(
                title: Text(value),
                value: value,
                groupValue: sesi,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => sesi = value);
                  }
                },
              ),
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Saya menyetujui penggunaan data pribadi.',
              ),
              value: setuju,
              onChanged: (value) {
                setState(() => setuju = value ?? false);
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: formValid ? kirimPengajuan : null,
                child: loading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Kirim Pengajuan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
