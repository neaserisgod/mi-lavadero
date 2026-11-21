import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_lavadero/data/database.dart';
import 'package:mi_lavadero/data/repositorio.dart';
import 'package:mi_lavadero/main.dart';
import 'app_test.dart' show completar;

void main() {
  testWidgets('cambiar de sección conserva la búsqueda de lavados', (
    tester,
  ) async {
    final db = LavaderoDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await tester.pumpWidget(LavaderoApp(repo: Repositorio(db)));
    await completar(tester);
    await tester.enterText(find.byType(TextField).first, 'AB123');
    await tester.tap(find.text('Servicios'));
    await completar(tester);
    await tester.tap(find.text('Lavados').last);
    await completar(tester);
    expect(
      tester.widget<TextField>(find.byType(TextField).first).controller?.text ??
          tester
              .widget<EditableText>(find.byType(EditableText).first)
              .controller
              .text,
      'AB123',
    );
    expect(tester.takeException(), isNull);
  });
  for (final size in [const Size(360, 780), const Size(844, 390)]) {
    testWidgets('navegación con texto grande y movimiento reducido en $size', (
      tester,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 1.5;
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      addTearDown(
        tester.platformDispatcher.clearAccessibilityFeaturesTestValue,
      );
      final db = LavaderoDatabase(NativeDatabase.memory());
      addTearDown(db.close);
      await tester.pumpWidget(LavaderoApp(repo: Repositorio(db)));
      await completar(tester);
      await tester.tap(find.text('Servicios'));
      await completar(tester);
      expect(find.text('Agregar servicio'), findsOneWidget);
      await tester.tap(find.text('Agregar servicio'));
      await completar(tester);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(tester.takeException(), isNull);
    });
  }
}
