
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/pengajuan_model.dart';
import 'navigation/app_routes.dart';
import 'navigation/kerangka_navigasi.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PengajuanModel(),
      child: const NusantaraCerdasApp(),
    ),
  );
}

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nusantara Cerdas Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.warga,
      onGenerateRoute: KerangkaNavigasi.generateRoute,
    );
  }
}
