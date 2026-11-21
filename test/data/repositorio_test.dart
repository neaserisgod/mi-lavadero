import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_lavadero/data/database.dart';
import 'package:mi_lavadero/data/repositorio.dart';
import 'package:mi_lavadero/data/respaldo.dart';
import 'package:mi_lavadero/domain/lavadero.dart';
import 'package:mi_lavadero/domain/servicios.dart';

void main() {
  late LavaderoDatabase db;
  late Repositorio repo;
  late int insumo;
  late int servicio;
  setUp(() async {
    db = LavaderoDatabase(NativeDatabase.memory());
    repo = Repositorio(db);
    await repo.guardarAjustes(
      nombre: 'Lavadero de prueba',
      alias: 'lavadero',
      valorHora: 600000,
    );
    insumo = await repo.guardarInsumo(
      nombre: 'Shampoo',
      unidad: UnidadInsumo.ml,
      contenido: 5000000,
      costoEnvase: 1000000,
      minimo: 100000,
      stockInicial: 1000000,
    );
    servicio = await repo.guardarServicio(
      nombre: 'Completo',
      duracion: 30,
      manoDeObra: true,
      precios: {TipoVehiculo.auto: 1200000, TipoVehiculo.camioneta: 1800000},
      receta: [(insumoId: insumo, cantidad: 50000)],
    );
  });
  tearDown(() => db.close());
  Future<int> orden({String patente = 'AB123CD', String? operacion}) =>
      repo.crearOrden(
        patente: patente,
        modelo: 'Fiat Uno',
        tipo: TipoVehiculo.auto,
        cliente: 'Ana',
        telefono: '123',
        responsable: 'Yo',
        notas: 'Interior',
        servicios: [(servicioId: servicio, precio: 1200000)],
        operacion: operacion ?? nuevaOperacion(),
      );
  Future<void> caja() => repo.abrirCaja(efectivo: 200000, digital: 100000);

  test(
    'el alta guarda precio, receta, costo y mano de obra del momento',
    () async {
      final id = await orden();
      final d = await repo.detalle(id);
      expect(d.total, 1200000);
      expect(d.insumos, 10000);
      expect(d.manoDeObra, 300000);
      expect(d.margen, 890000);
      expect((await repo.insumos()).single.stock, 1000000);
      expect(
        (await repo.historialInsumo(insumo)).single.motivo,
        'Stock inicial',
      );
    },
  );
  test(
    'editar catálogo no cambia presupuesto, receta ni costos históricos',
    () async {
      final id = await orden();
      await repo.guardarServicio(
        id: servicio,
        nombre: 'Completo nuevo',
        duracion: 60,
        manoDeObra: true,
        precios: {TipoVehiculo.auto: 2000000},
        receta: [(insumoId: insumo, cantidad: 100000)],
      );
      await repo.comprarInsumo(insumo, envases: 1, costoEnvase: 2000000);
      await repo.guardarAjustes(
        nombre: 'Nuevo nombre',
        alias: '',
        valorHora: 900000,
      );
      final d = await repo.detalle(id);
      expect(d.total, 1200000);
      expect(d.lineas.single.nombre, 'Completo');
      expect(d.insumos, 10000);
      expect(d.manoDeObra, 300000);
      await repo.cambiarEstado(id, EstadoLavado.enLavado);
      expect((await repo.insumos()).single.stock, 5950000);
    },
  );
  test(
    'consumir al empezar es atómico e idempotente, cobrar no consume',
    () async {
      final id = await orden();
      await caja();
      await repo.cobrar(
        id,
        monto: 1200000,
        medio: MedioPago.digital,
        operacion: 'pago',
      );
      expect((await repo.detalle(id)).estado, EstadoLavado.recibido);
      expect((await repo.insumos()).single.stock, 1000000);
      await Future.wait([
        repo.cambiarEstado(id, EstadoLavado.enLavado),
        repo.cambiarEstado(id, EstadoLavado.enLavado),
      ]);
      expect((await repo.insumos()).single.stock, 950000);
      expect(
        (await repo.historialInsumo(
          insumo,
        )).where((m) => m.ordenId == id).length,
        1,
      );
      await repo.cambiarEstado(id, EstadoLavado.listo);
      await repo.cambiarEstado(id, EstadoLavado.entregado);
      expect((await repo.detalle(id)).orden.entregada, isNotNull);
      expect((await repo.insumos()).single.stock, 950000);
    },
  );
  test('señas y cobro final por distinto medio no duplican dinero', () async {
    final id = await orden();
    await caja();
    await repo.cobrar(
      id,
      monto: 300000,
      medio: MedioPago.efectivo,
      operacion: 'sena',
    );
    expect((await repo.detalle(id)).saldo, 900000);
    await repo.cobrar(
      id,
      monto: 900000,
      medio: MedioPago.digital,
      operacion: 'resto',
    );
    await repo.cobrar(
      id,
      monto: 900000,
      medio: MedioPago.digital,
      operacion: 'resto',
    );
    expect((await repo.detalle(id)).pagos.length, 2);
    final resumen = await repo.resumenCaja((await repo.cajaAbierta())!.id);
    expect(resumen.esperado(MedioPago.efectivo), 500000);
    expect(resumen.esperado(MedioPago.digital), 1000000);
    await expectLater(
      repo.cobrar(id, monto: 1, medio: MedioPago.efectivo, operacion: 'otro'),
      throwsArgumentError,
    );
  });
  test('anotar un gasto e ingreso cambia únicamente su medio', () async {
    await caja();
    await repo.movimiento(
      monto: 100000,
      medio: MedioPago.efectivo,
      gasto: true,
      concepto: 'Insumos',
      operacion: 'gasto',
    );
    await repo.movimiento(
      monto: 50000,
      medio: MedioPago.digital,
      gasto: false,
      concepto: 'Aporte',
      operacion: 'aporte',
    );
    final r = await repo.resumenCaja((await repo.cajaAbierta())!.id);
    expect(r.esperado(MedioPago.efectivo), 100000);
    expect(r.esperado(MedioPago.digital), 150000);
  });
  test(
    'cancelar antes de empezar devuelve anticipos sin inventar stock',
    () async {
      final id = await orden();
      await caja();
      await repo.cobrar(
        id,
        monto: 300000,
        medio: MedioPago.efectivo,
        operacion: 'sena',
      );
      await repo.cobrar(
        id,
        monto: 200000,
        medio: MedioPago.digital,
        operacion: 'sena2',
      );
      await repo.cambiarEstado(id, EstadoLavado.cancelado);
      await repo.cambiarEstado(id, EstadoLavado.cancelado);
      final d = await repo.detalle(id);
      expect(d.cobrado, 0);
      expect(d.pagos.length, 4);
      final r = await repo.resumenCaja((await repo.cajaAbierta())!.id);
      expect(r.esperado(MedioPago.efectivo), 200000);
      expect(r.esperado(MedioPago.digital), 100000);
      expect((await repo.insumos()).single.stock, 1000000);
      await expectLater(
        repo.cobrar(id, monto: 1, medio: MedioPago.efectivo, operacion: 'no'),
        throwsArgumentError,
      );
    },
  );
  test(
    'sin caja no hay cobros ni devolución parcial de una cancelación',
    () async {
      final id = await orden();
      await expectLater(
        repo.cobrar(
          id,
          monto: 100,
          medio: MedioPago.efectivo,
          operacion: 'sin-caja',
        ),
        throwsArgumentError,
      );
      await caja();
      final cid = (await repo.cajaAbierta())!.id;
      await repo.cobrar(
        id,
        monto: 300000,
        medio: MedioPago.efectivo,
        operacion: 'sena',
      );
      await repo.cerrarCaja(cid, efectivo: 500000, digital: 100000);
      await expectLater(
        repo.cambiarEstado(id, EstadoLavado.cancelado),
        throwsArgumentError,
      );
      expect((await repo.detalle(id)).estado, EstadoLavado.recibido);
      expect((await repo.detalle(id)).cobrado, 300000);
    },
  );
  test(
    'el pago final después de cerrar no cambia el cierre anterior',
    () async {
      final id = await orden();
      await caja();
      final cid = (await repo.cajaAbierta())!.id;
      await repo.cobrar(
        id,
        monto: 300000,
        medio: MedioPago.efectivo,
        operacion: 'sena',
      );
      await repo.cerrarCaja(cid, efectivo: 500000, digital: 100000);
      await repo.abrirCaja(efectivo: 500000, digital: 100000);
      await repo.cobrar(
        id,
        monto: 900000,
        medio: MedioPago.digital,
        operacion: 'resto',
      );
      expect((await repo.resumenCaja(cid)).esperado(MedioPago.digital), 100000);
      expect(
        (await repo.resumenCaja(
          (await repo.cajaAbierta())!.id,
        )).esperado(MedioPago.digital),
        1000000,
      );
    },
  );
  test('sin stock avisa; empezar igual conserva el rastro negativo', () async {
    final id = await orden();
    await repo.contarInsumo(insumo, 0);
    await expectLater(
      repo.cambiarEstado(id, EstadoLavado.enLavado),
      throwsArgumentError,
    );
    expect((await repo.detalle(id)).estado, EstadoLavado.recibido);
    await repo.cambiarEstado(
      id,
      EstadoLavado.enLavado,
      permitirFaltantes: true,
    );
    expect((await repo.insumos()).single.stock, -50000);
    await expectLater(
      repo.cambiarEstado(id, EstadoLavado.cancelado),
      throwsArgumentError,
    );
  });
  test('se puede entregar un lavado con saldo, que sigue pendiente', () async {
    final id = await orden();
    for (final e in [
      EstadoLavado.enLavado,
      EstadoLavado.listo,
      EstadoLavado.entregado,
    ]) {
      await repo.cambiarEstado(id, e);
    }
    expect((await repo.detalle(id)).saldo, 1200000);
  });
  test('un error al crear no deja vehículo ni orden incompletos', () async {
    await expectLater(
      repo.crearOrden(
        patente: 'AB123CD',
        modelo: 'Auto',
        tipo: TipoVehiculo.auto,
        cliente: '',
        telefono: '',
        responsable: '',
        notas: '',
        servicios: [(servicioId: servicio, precio: -1)],
        operacion: 'invalida',
      ),
      throwsArgumentError,
    );
    expect(await repo.vehiculos(), isEmpty);
    expect(await repo.ordenes(), isEmpty);
  });
  test('reintentar el alta no duplica orden ni vehículo', () async {
    final a = await orden(operacion: 'alta');
    final b = await orden(operacion: 'alta');
    expect(a, b);
    expect(await repo.ordenes(), hasLength(1));
    expect(await repo.vehiculos(), hasLength(1));
  });
  test(
    'corregir patente preserva el historial por identidad del vehículo',
    () async {
      final id = await orden();
      final v = (await repo.vehiculos()).single;
      await repo.editarVehiculo(
        v.id,
        patente: 'AC456EF',
        modelo: 'Fiat',
        tipo: TipoVehiculo.auto,
        cliente: 'Otro',
        telefono: '',
        notas: 'nota',
      );
      expect((await repo.detalle(id)).orden.patente, 'AB123CD');
      expect((await repo.detalle(id)).orden.vehiculoId, v.id);
      expect((await repo.vehiculos()).single.patente, 'AC456EF');
    },
  );
  test('respaldo completo conserva dinero, stock e historia', () async {
    final id = await orden();
    await caja();
    await repo.cobrar(
      id,
      monto: 300000,
      medio: MedioPago.efectivo,
      operacion: 'sena',
    );
    await repo.cambiarEstado(id, EstadoLavado.enLavado);
    final texto = await Respaldo(db).exportar();
    await repo.contarInsumo(insumo, 0);
    await Respaldo(db).restaurar(texto);
    expect((await repo.detalle(id)).saldo, 900000);
    expect((await repo.insumos()).single.stock, 950000);
    expect(
      jsonDecode(await Respaldo(db).exportar())['tablas'],
      jsonDecode(texto)['tablas'],
    );
  });
  test('respaldo inválido revierte la restauración completa', () async {
    final id = await orden();
    final original = await Respaldo(db).exportar();
    final dato = jsonDecode(original);
    dato['tablas']['ordenes'][0]['estado'] = 'inexistente';
    await expectLater(
      Respaldo(db).restaurar(jsonEncode(dato)),
      throwsFormatException,
    );
    expect((await repo.detalle(id)).estado, EstadoLavado.recibido);
    expect(
      jsonDecode(await Respaldo(db).exportar())['tablas'],
      jsonDecode(original)['tablas'],
    );
    await expectLater(
      Respaldo(db).restaurar('{"formato":"otro"}'),
      throwsFormatException,
    );
  });
}
