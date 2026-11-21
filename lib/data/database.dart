// Los checks de drift se resuelven en las columnas generadas.
// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class Ajustes extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get nombre => text().withDefault(const Constant('Mi Lavadero'))();
  TextColumn get alias => text().withDefault(const Constant(''))();
  IntColumn get valorHora => integer().withDefault(const Constant(0))();
  @override
  Set<Column> get primaryKey => {id};
}

class Insumos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  TextColumn get unidad => text()();
  IntColumn get contenido => integer().check(contenido.isBiggerThanValue(0))();
  IntColumn get costoEnvase =>
      integer().check(costoEnvase.isBiggerOrEqualValue(0))();
  IntColumn get stock => integer().withDefault(const Constant(0))();
  IntColumn get minimo => integer().withDefault(const Constant(0))();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
}

class Servicios extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  IntColumn get duracion => integer().check(duracion.isBiggerThanValue(0))();
  BoolColumn get manoDeObra => boolean().withDefault(const Constant(true))();
  IntColumn get gananciaBuscada =>
      integer().withDefault(const Constant(6000))();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
}

class Tarifas extends Table {
  IntColumn get servicioId => integer().references(Servicios, #id)();
  TextColumn get tipo => text()();
  IntColumn get precio => integer().check(precio.isBiggerThanValue(0))();
  @override
  Set<Column> get primaryKey => {servicioId, tipo};
}

class Recetas extends Table {
  IntColumn get servicioId => integer().references(Servicios, #id)();
  IntColumn get insumoId => integer().references(Insumos, #id)();
  IntColumn get cantidad => integer().check(cantidad.isBiggerThanValue(0))();
  @override
  Set<Column> get primaryKey => {servicioId, insumoId};
}

class Vehiculos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get patente => text().unique()();
  TextColumn get modelo => text()();
  TextColumn get tipo => text()();
  TextColumn get cliente => text().withDefault(const Constant(''))();
  TextColumn get telefono => text().withDefault(const Constant(''))();
  TextColumn get notas => text().withDefault(const Constant(''))();
}

@DataClassName('OrdenLavado')
class Ordenes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get vehiculoId => integer().references(Vehiculos, #id)();
  TextColumn get patente => text()();
  TextColumn get modelo => text()();
  TextColumn get tipo => text()();
  TextColumn get cliente => text()();
  TextColumn get telefono => text()();
  TextColumn get responsable => text().withDefault(const Constant(''))();
  TextColumn get notas => text().withDefault(const Constant(''))();
  TextColumn get estado => text().withDefault(const Constant('recibido'))();
  DateTimeColumn get creada => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get programada => dateTime().nullable()();
  DateTimeColumn get iniciada => dateTime().nullable()();
  DateTimeColumn get terminada => dateTime().nullable()();
  DateTimeColumn get entregada => dateTime().nullable()();

  /// Cada alta tiene identidad propia: reintentar una escritura no duplica el trabajo.
  TextColumn get operacion => text().unique()();
}

@DataClassName('LineaLavado')
class LineasOrden extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ordenId => integer().references(Ordenes, #id)();
  IntColumn get servicioId => integer().references(Servicios, #id)();
  TextColumn get nombre => text()();
  IntColumn get precio => integer().check(precio.isBiggerThanValue(0))();
  IntColumn get duracion => integer()();
  IntColumn get costoInsumos => integer()();
  IntColumn get costoManoDeObra => integer()();

  /// Foto de la receta: editar el catálogo nunca cambia un trabajo ya acordado.
  TextColumn get receta => text()();
}

@DataClassName('MovimientoInsumo')
class MovimientosStock extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get insumoId => integer().references(Insumos, #id)();
  IntColumn get ordenId => integer().nullable().references(Ordenes, #id)();
  IntColumn get anterior => integer()();
  IntColumn get posterior => integer()();
  TextColumn get motivo => text()();
  DateTimeColumn get fecha => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('SesionCaja')
class Cajas extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get abierta => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get cerrada => dateTime().nullable()();
  IntColumn get inicialEfectivo => integer()();
  IntColumn get inicialDigital => integer()();
  IntColumn get contadoEfectivo => integer().nullable()();
  IntColumn get contadoDigital => integer().nullable()();
}

@DataClassName('MovimientoCaja')
class MovimientosCaja extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get cajaId => integer().references(Cajas, #id)();
  IntColumn get ordenId => integer().nullable().references(Ordenes, #id)();
  TextColumn get medio => text()();

  /// Positivo entra, negativo sale. La devolución conserva su vínculo con la orden.
  IntColumn get monto => integer()();
  TextColumn get concepto => text()();
  TextColumn get clase => text()();
  TextColumn get operacion => text().unique()();
  DateTimeColumn get fecha => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(
  tables: [
    Ajustes,
    Insumos,
    Servicios,
    Tarifas,
    Recetas,
    Vehiculos,
    Ordenes,
    LineasOrden,
    MovimientosStock,
    Cajas,
    MovimientosCaja,
  ],
)
class LavaderoDatabase extends _$LavaderoDatabase {
  LavaderoDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'mi_lavadero'));
  @override
  int get schemaVersion => 1;
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await into(ajustes).insert(const AjustesCompanion());
    },
    beforeOpen: (_) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await customStatement(
        'CREATE UNIQUE INDEX IF NOT EXISTS una_caja_abierta ON cajas ((1)) WHERE cerrada IS NULL',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS ordenes_por_patente ON ordenes (patente, creada)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS movimientos_de_orden ON movimientos_caja (orden_id)',
      );
    },
  );
}
