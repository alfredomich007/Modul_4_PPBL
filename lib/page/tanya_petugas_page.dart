
import 'package:flutter/material.dart';

class TanyaPetugasPage extends StatefulWidget {
  const TanyaPetugasPage({super.key});

  @override
  State<TanyaPetugasPage> createState() =>
      _TanyaPetugasPageState();
}

class _TanyaPetugasPageState
    extends State<TanyaPetugasPage> {
  final controller = TextEditingController();

  final List<Map<String, dynamic>> pesan = [
    {
      'isi': 'Selamat datang. Ada yang bisa kami bantu?',
      'warga': false,
    },
  ];

  void kirimPesan() {
    final isi = controller.text.trim();

    if (isi.isEmpty) return;

    setState(() {
      pesan.add({'isi': isi, 'warga': true});
      controller.clear();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tanya Petugas'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pesan.length,
              itemBuilder: (context, index) {
                final item = pesan[index];
                final warga = item['warga'] as bool;

                return Align(
                  alignment: warga
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(
                      maxWidth: 280,
                    ),
                    decoration: BoxDecoration(
                      color: warga
                          ? Colors.teal
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      item['isi'] as String,
                      style: TextStyle(
                        color: warga ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Tulis pesan...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => kirimPesan(),
                    ),
                  ),
                  IconButton(
                    onPressed: kirimPesan,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
