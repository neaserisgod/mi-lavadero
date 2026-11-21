import 'ui/actualizaciones.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/database.dart';
import 'data/repositorio.dart';
import 'ui/app.dart';
import 'ui/diseno.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    LavaderoApp(repo: Repositorio(LavaderoDatabase()), actualizaciones: true),
  );
}

class LavaderoApp extends StatelessWidget {
  const LavaderoApp({
    super.key,
    required this.repo,
    this.actualizaciones = false,
  });
  final Repositorio repo;
  final bool actualizaciones;
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Mi Lavadero',
    debugShowCheckedModeBanner: false,
    locale: const Locale('es', 'AR'),
    supportedLocales: const [Locale('es', 'AR')],
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    theme: tema(),
    home: actualizaciones
        ? ActualizacionesAutomaticas(
            app: 'mi-lavadero',
            child: InicioApp(repo: repo),
          )
        : InicioApp(repo: repo),
  );
}
