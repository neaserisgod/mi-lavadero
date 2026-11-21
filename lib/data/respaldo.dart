import 'dart:convert';

import '../domain/lavadero.dart';
import '../domain/servicios.dart';
import 'database.dart';

/// Un formato propio evita mezclar por accidente una base de Nodo Sur con la del lavadero.
/// Se guardan valores SQL, incluidos los ids y las fechas, sin perder precisión.
class Respaldo {
  Respaldo(this.db);
  final LavaderoDatabase db;
  static const formato = 'mi-lavadero';
  static const tablas = [
    'ajustes',
    'insumos',
    'servicios',
    'tarifas',
    'recetas',
    'vehiculos',
    'ordenes',
    'lineas_orden',
    'movimientos_stock',
    'cajas',
    'movimientos_caja',
  ];

  Future<String> exportar() => db.transaction(() async {
    final datos = <String, Object?>{};
    for (final t in tablas) {
      datos[t] = [
        for (final fila in await db.customSelect('SELECT * FROM "$t"').get())
          fila.data,
      ];
    }
    return jsonEncode({
      'formato': formato,
      'version': 1,
      'creado': DateTime.now().toIso8601String(),
      'tablas': datos,
    });
  });

  Future<void> restaurar(String texto) async {
    if (texto.length > 50 * 1024 * 1024) {
      throw const FormatException('El respaldo supera los 50 MB.');
    }
    final dato = jsonDecode(texto);
    if (dato is! Map ||
        dato['formato'] != formato ||
        dato['version'] != 1 ||
        dato['tablas'] is! Map) {
      throw const FormatException(
        'Este archivo no es un respaldo compatible de Mi Lavadero.',
      );
    }
    final contenido = dato['tablas'] as Map;
    if (contenido.length != tablas.length ||
        tablas.any((t) => contenido[t] is! List)) {
      throw const FormatException('El respaldo está incompleto.');
    }
    final columnas = <String, Set<String>>{};
    for (final t in tablas) {
      columnas[t] = (await db.customSelect('PRAGMA table_info("$t")').get())
          .map((r) => r.read<String>('name'))
          .toSet();
      for (final fila in contenido[t] as List) {
        if (fila is! Map ||
            fila.keys.toSet().difference(columnas[t]!).isNotEmpty ||
            fila.length != columnas[t]!.length ||
            fila.values.any((v) => v != null && v is! String && v is! int)) {
          throw FormatException('Datos inválidos en $t.');
        }
      }
    }
    await db.transaction(() async {
      // Primero se borran las tablas hijas; las claves foráneas siguen activas.
      for (final t in tablas.reversed) {
        await db.customStatement('DELETE FROM "$t"');
      }
      for (final t in tablas) {
        final cols = columnas[t]!.toList();
        final sql =
            'INSERT INTO "$t" (${cols.map((c) => '"$c"').join(',')}) VALUES (${cols.map((_) => '?').join(',')})';
        for (final fila in contenido[t] as List) {
          await db.customStatement(sql, [for (final c in cols) fila[c]]);
        }
      }
      if ((await db.select(db.ajustes).get()).length != 1) {
        throw const FormatException('Faltan los ajustes del negocio.');
      }
      for (final v in await db.select(db.vehiculos).get()) {
        if (validarPatente(v.patente) != v.patente ||
            !TipoVehiculo.values.any((t) => t.name == v.tipo)) {
          throw const FormatException('Vehículo inválido.');
        }
      }
      for (final i in await db.select(db.insumos).get()) {
        if (UnidadInsumo.desdeClave(i.unidad) == null || i.minimo < 0) {
          throw const FormatException('Insumo inválido.');
        }
      }
      for (final o in await db.select(db.ordenes).get()) {
        if (!EstadoLavado.values.any((e) => e.name == o.estado)) {
          throw const FormatException('Estado de lavado inválido.');
        }
        final lineas = await (db.select(
          db.lineasOrden,
        )..where((l) => l.ordenId.equals(o.id))).get();
        if (lineas.isEmpty) {
          throw const FormatException('Hay una orden sin servicios.');
        }
        for (final l in lineas) {
          final receta = jsonDecode(l.receta);
          if (l.costoInsumos < 0 ||
              l.costoManoDeObra < 0 ||
              l.duracion <= 0 ||
              receta is! List) {
            throw const FormatException('Costo o receta inválidos.');
          }
          for (final r in receta) {
            if (r is! Map ||
                r['id'] is! int ||
                r['cantidad'] is! int ||
                (r['cantidad'] as int) <= 0 ||
                await (db.select(db.insumos)
                          ..where((i) => i.id.equals(r['id'] as int)))
                        .getSingleOrNull() ==
                    null) {
              throw const FormatException(
                'La receta contiene un insumo inválido.',
              );
            }
          }
        }
      }
      for (final m in await db.select(db.movimientosCaja).get()) {
        if (!MedioPago.values.any((e) => e.name == m.medio) ||
            !['cobro', 'devolucion', 'gasto', 'ingreso'].contains(m.clase) ||
            m.monto == 0) {
          throw const FormatException('Movimiento de dinero inválido.');
        }
      }
      if ((await db.customSelect('PRAGMA foreign_key_check').get())
          .isNotEmpty) {
        throw const FormatException(
          'El respaldo tiene referencias incompletas.',
        );
      }
    });
  }
}
