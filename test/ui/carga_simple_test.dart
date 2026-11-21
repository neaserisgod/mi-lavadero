import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_lavadero/data/database.dart';
import 'package:mi_lavadero/data/repositorio.dart';
import 'package:mi_lavadero/domain/lavadero.dart';
import 'package:mi_lavadero/domain/servicios.dart';
import 'package:mi_lavadero/ui/catalogo.dart';

import 'app_test.dart' show completar;

void main() {
  late LavaderoDatabase db;
  late Repositorio repo;
  setUp(() {
    db = LavaderoDatabase(NativeDatabase.memory());
    repo = Repositorio(db);
  });
  tearDown(() => db.close());

  Future<void> abrir(WidgetTester tester, {Servicio? servicio}) async {
    final catalogo = await tester.runAsync(() => Catalogo.cargar(repo));
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (_) => EditorServicio(
                    repo: repo,
                    catalogo: catalogo!,
                    servicio: servicio,
                  ),
                ),
              ),
              child: const Text('Abrir'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Abrir'));
    await completar(tester);
  }

  testWidgets(
    'crear servicio requiere solamente nombre y precio y sirve para cualquier vehículo',
    (tester) async {
      await abrir(tester);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Duración en minutos *'), findsNothing);
      expect(find.text('Margen buscado (%)'), findsNothing);
      expect(find.text('Insumos por servicio'), findsNothing);
      await tester.enterText(find.byType(TextField).at(0), 'Lavado exterior');
      await tester.enterText(find.byType(TextField).at(1), '12000');
      await tester.runAsync(() => tester.tap(find.text('Guardar')));
      await completar(tester);
      await tester.runAsync(() async {
        final servicio = (await repo.servicios()).single;
        expect(servicio.nombre, 'Lavado exterior');
        expect(servicio.manoDeObra, isFalse);
        expect((await repo.recetas()), isEmpty);
        final tarifas = await repo.tarifas();
        expect(
          tarifas.map((t) => t.tipo).toSet(),
          TipoVehiculo.values.map((t) => t.name).toSet(),
        );
        expect(tarifas.every((t) => t.precio == 1200000), isTrue);
      });
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'editar sin abrir opciones conserva precios por vehículo, receta y costos',
    (tester) async {
      final servicio = await tester.runAsync(() async {
        final insumo = await repo.guardarInsumo(
          nombre: 'Shampoo',
          unidad: UnidadInsumo.ml,
          contenido: 5000000,
          costoEnvase: 500000,
          minimo: 0,
        );
        final id = await repo.guardarServicio(
          nombre: 'Completo',
          duracion: 45,
          manoDeObra: true,
          precios: {
            TipoVehiculo.auto: 1200000,
            TipoVehiculo.camioneta: 1800000,
          },
          receta: [(insumoId: insumo, cantidad: 50000)],
          gananciaBuscada: 7000,
        );
        return (await repo.servicios()).firstWhere((s) => s.id == id);
      });
      await abrir(tester, servicio: servicio);
      expect(find.byType(TextField), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'Completo especial');
      await tester.runAsync(() => tester.tap(find.text('Guardar')));
      await completar(tester);
      await tester.runAsync(() async {
        final s = (await repo.servicios()).single;
        expect(s.nombre, 'Completo especial');
        expect(s.duracion, 45);
        expect(s.manoDeObra, isTrue);
        expect(s.gananciaBuscada, 7000);
        expect(
          {for (final t in await repo.tarifas()) t.tipo: t.precio},
          {'auto': 1200000, 'camioneta': 1800000},
        );
        expect((await repo.recetas()).single.cantidad, 50000);
      });
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'más opciones permite personalizar y volver a cerrar sin perder lo escrito',
    (tester) async {
      await abrir(tester);
      await tester.enterText(find.byType(TextField).at(0), 'Encerado');
      await tester.enterText(find.byType(TextField).at(1), '15000');
      await tester.tap(find.text('Más opciones'));
      await tester.pump();
      final duracion = find.widgetWithText(TextField, 'Duración en minutos *');
      await tester.scrollUntilVisible(
        duracion,
        160,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.enterText(duracion, '90');
      await tester.scrollUntilVisible(
        find.text('Menos opciones'),
        -160,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Menos opciones'));
      await tester.pumpAndSettle();
      expect(find.byType(TextField), findsNWidgets(2));
      await tester.runAsync(() => tester.tap(find.text('Guardar')));
      await completar(tester);
      await tester.runAsync(() async {
        expect((await repo.servicios()).single.duracion, 90);
      });
      expect(tester.takeException(), isNull);
    },
  );
}
