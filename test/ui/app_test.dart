import 'dart:io';
import 'dart:ui' as ui;

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mi_lavadero/ui/ordenes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_lavadero/data/database.dart';
import 'package:mi_lavadero/data/repositorio.dart';
import 'package:mi_lavadero/domain/lavadero.dart';
import 'package:mi_lavadero/domain/servicios.dart';
import 'package:mi_lavadero/main.dart';

Future<void> completar(WidgetTester tester) async {
  for (var n = 0; n < 6; n++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 30)),
    );
    await tester.pump(const Duration(milliseconds: 80));
  }
  await tester.pump(const Duration(milliseconds: 350));
}

void main() {
  setUpAll(() async {
    final fuente = FontLoader('Figtree')
      ..addFont(rootBundle.load('fonts/Figtree-Regular.ttf'));
    await fuente.load();
    final iconos = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await iconos.load();
  });
  testWidgets('arranca sin cuenta y permite navegar en un celular angosto', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final db = LavaderoDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await tester.pumpWidget(LavaderoApp(repo: Repositorio(db)));
    await completar(tester);
    expect(find.text('Tu próximo lavado empieza acá'), findsOneWidget);
    expect(find.text('Recibir vehículo'), findsOneWidget);
    for (final nombre in ['Servicios', 'Vehículos', 'Caja']) {
      await tester.tap(find.text(nombre).last);
      await completar(tester);
      expect(tester.takeException(), isNull);
    }
    expect(find.text('Abrir caja'), findsOneWidget);
    await tester.tap(find.byTooltip('Ajustes y respaldos'));
    await completar(tester);
    expect(find.text('Nombre de tu lavadero *'), findsOneWidget);
    expect(find.textContaining('Google'), findsNothing);
  });

  testWidgets('recibir, empezar y terminar desde las pantallas del celular', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final db = LavaderoDatabase(NativeDatabase.memory());
    final repo = Repositorio(db);
    addTearDown(db.close);
    await tester.runAsync(() async {
      final insumo = await repo.guardarInsumo(
        nombre: 'Shampoo',
        unidad: UnidadInsumo.ml,
        contenido: 5000000,
        costoEnvase: 1000000,
        minimo: 0,
        stockInicial: 1000000,
      );
      await repo.guardarServicio(
        nombre: 'Completo',
        duracion: 30,
        manoDeObra: false,
        precios: {TipoVehiculo.auto: 1200000},
        receta: [(insumoId: insumo, cantidad: 50000)],
      );
      await repo.abrirCaja(efectivo: 0, digital: 0);
    });
    final captura = GlobalKey();
    await tester.pumpWidget(
      RepaintBoundary(
        key: captura,
        child: LavaderoApp(repo: repo),
      ),
    );
    await completar(tester);
    await tester.tap(find.text('Recibir vehículo'));
    await completar(tester);
    await tester.enterText(find.byType(TextField).at(0), 'AB123CD');
    await tester.enterText(find.byType(TextField).at(1), 'Fiat Uno');
    await tester.scrollUntilVisible(
      find.byType(CheckboxListTile),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.byType(CheckboxListTile));
    await tester.pump(const Duration(milliseconds: 350));
    await tester.runAsync(() => tester.tap(find.text('Crear orden')));
    await completar(tester);
    expect(find.text('AB123CD'), findsOneWidget);
    expect(tester.takeException(), isNull);
    if (const bool.fromEnvironment('CAPTURAS')) {
      await tester.runAsync(() async {
        final boundary =
            captura.currentContext!.findRenderObject()!
                as RenderRepaintBoundary;
        final image = await boundary.toImage(pixelRatio: 2);
        final bytes = (await image.toByteData(format: ui.ImageByteFormat.png))!;
        await Directory('capturas').create();
        await File(
          'capturas/lavados.png',
        ).writeAsBytes(bytes.buffer.asUint8List());
        image.dispose();
      });
    }
    await tester.ensureVisible(find.text('AB123CD'));
    await tester.tap(find.text('AB123CD'));
    await completar(tester);
    expect(find.byType(PantallaDetalleOrden), findsOneWidget);
    for (final texto in [
      'Empezar lavado',
      'Marcar listo',
      'Entregar vehículo',
    ]) {
      await tester.scrollUntilVisible(
        find.text(texto),
        160,
        scrollable: find
            .descendant(
              of: find.byType(PantallaDetalleOrden),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.runAsync(() => tester.tap(find.text(texto)));
      await completar(tester);
      if (texto == 'Entregar vehículo') {
        await tester.tap(find.text('Entregar').last);
        await completar(tester);
      }
      expect(tester.takeException(), isNull);
    }
    await tester.runAsync(() async {
      expect((await repo.ordenes()).single.estado, EstadoLavado.entregado);
      expect((await repo.insumos()).single.stock, 950000);
      expect((await repo.ordenes()).single.saldo, 1200000);
    });
  });
}
