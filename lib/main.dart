import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/database.dart';
import 'data/repositorio.dart';
import 'ui/app.dart';

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
    theme: ThemeData(
      useMaterial3: true,
      fontFamily: 'Figtree',
      scaffoldBackgroundColor: const Color(0xFFFAFBFD),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF145DFB),
        primary: const Color(0xFF145DFB),
        surface: const Color(0xFFFAFBFD),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFAFBFD),
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF0F2F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 52),
          textStyle: const TextStyle(
            fontFamily: 'Figtree',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: Color(0xFFE2EBFF),
      ),
    ),
    home: InicioApp(repo: repo),
  );
}
