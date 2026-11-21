import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/database.dart';
import 'data/repositorio.dart';
import 'ui/app.dart';
import 'ui/diseno.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(LavaderoApp(repo: Repositorio(LavaderoDatabase())));
}

class LavaderoApp extends StatelessWidget {
  const LavaderoApp({super.key, required this.repo});
  final Repositorio repo;
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Mi Lavadero',
    debugShowCheckedModeBanner: false,
    locale: const Locale('es', 'AR'),
    supportedLocales: const [Locale('es', 'AR')],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    theme: tema(),
    home: InicioApp(repo: repo),
  );
}
