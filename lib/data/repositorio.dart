import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart';

import '../domain/caja.dart';
import '../domain/lavadero.dart';
import '../domain/servicios.dart';
import 'database.dart';

String nuevaOperacion() {
  final r = Random.secure();
  return '${DateTime.now().microsecondsSinceEpoch}-${List.generate(16, (_) => r.nextInt(256).toRadixString(16).padLeft(2, '0')).join()}';
}

typedef UsoReceta = ({int insumoId, int cantidad});
typedef EleccionServicio = ({int servicioId, int precio});

class DetalleOrden {
  const DetalleOrden(this.orden, this.lineas, this.pagos);
  final OrdenLavado orden;
  final List<LineaLavado> lineas;
  final List<MovimientoCaja> pagos;
  int get total => lineas.fold(0, (s, l) => s + l.precio);
  int get insumos => lineas.fold(0, (s, l) => s + l.costoInsumos);
  int get manoDeObra => lineas.fold(0, (s, l) => s + l.costoManoDeObra);
  int get cobrado => pagos.fold(0, (s, p) => s + p.monto);
  int get saldo =>
      saldoPendiente(totalCentavos: total, cobradoCentavos: cobrado);
  int get margen => total - insumos - manoDeObra;
  EstadoLavado get estado => EstadoLavado.values.byName(orden.estado);
}

class ResumenCaja {
  const ResumenCaja(this.caja, this.movimientos);
  final SesionCaja caja;
  final List<MovimientoCaja> movimientos;
  int esperado(MedioPago medio) => cajaEsperadaCentavos(
    inicialCentavos: medio == MedioPago.efectivo
        ? caja.inicialEfectivo
        : caja.inicialDigital,
    efectivoDeVentasCentavos: movimientos
        .where((m) => m.medio == medio.name && m.clase == 'cobro')
        .fold(0, (s, m) => s + m.monto),
    gastosEnEfectivoCentavos: -movimientos
        .where((m) => m.medio == medio.name && m.monto < 0)
        .fold(0, (s, m) => s + m.monto),
    ingresosEnEfectivoCentavos: movimientos
        .where(
          (m) => m.medio == medio.name && m.monto > 0 && m.clase != 'cobro',
        )
        .fold(0, (s, m) => s + m.monto),
  );
}

/// Reutiliza las cuentas de Nodo Sur. Todas las escrituras de stock y dinero
/// quedan junto con su comprobación en una transacción SQLite.
class Repositorio {
  Repositorio(this.db);
  final LavaderoDatabase db;

  Future<Ajuste> ajustes() => db.select(db.ajustes).getSingle();
  Future<void> guardarAjustes({
    required String nombre,
    required String alias,
    required int valorHora,
  }) async {
    _nombre(nombre);
    _monto(valorHora, permiteCero: true);
    await db
        .update(db.ajustes)
        .write(
          AjustesCompanion(
            nombre: Value(nombre.trim()),
            alias: Value(alias.trim()),
            valorHora: Value(valorHora),
          ),
        );
  }

  Future<List<Insumo>> insumos({bool todos = false}) =>
      (db.select(db.insumos)
            ..where((i) => todos ? const Constant(true) : i.activo.equals(true))
            ..orderBy([(i) => OrderingTerm.asc(i.nombre)]))
          .get();
  Future<List<Servicio>> servicios({bool todos = false}) =>
      (db.select(db.servicios)
            ..where((s) => todos ? const Constant(true) : s.activo.equals(true))
            ..orderBy([(s) => OrderingTerm.asc(s.nombre)]))
          .get();
  Future<List<Tarifa>> tarifas() => db.select(db.tarifas).get();
  Future<List<Receta>> recetas() => db.select(db.recetas).get();

  Future<int> guardarInsumo({
    int? id,
    required String nombre,
    required UnidadInsumo unidad,
    required int contenido,
    required int costoEnvase,
    required int minimo,
    int stockInicial = 0,
    bool activo = true,
  }) => db.transaction(() async {
    _nombre(nombre);
    if (contenido <= 0 || minimo < 0 || stockInicial < 0) {
      throw ArgumentError('Revisá el contenido y las cantidades.');
    }
    _monto(costoEnvase, permiteCero: true);
    if (id == null) {
      final nuevo = await db
          .into(db.insumos)
          .insert(
            InsumosCompanion.insert(
              nombre: nombre.trim(),
              unidad: unidad.clave,
              contenido: contenido,
              costoEnvase: costoEnvase,
              minimo: Value(minimo),
            ),
          );
      if (stockInicial > 0) {
        await _moverInsumo(nuevo, stockInicial, 'Stock inicial');
      }
      return nuevo;
    }
    final anterior = await _insumo(id);
    if (anterior.unidad != unidad.clave) {
      throw ArgumentError('La unidad de un insumo existente no se cambia.');
    }
    await (db.update(db.insumos)..where((i) => i.id.equals(id))).write(
      InsumosCompanion(
        nombre: Value(nombre.trim()),
        contenido: Value(contenido),
        costoEnvase: Value(costoEnvase),
        minimo: Value(minimo),
        activo: Value(activo),
      ),
    );
    return id;
  });

  Future<void> comprarInsumo(
    int id, {
    required int envases,
    required int costoEnvase,
  }) => db.transaction(() async {
    final i = await _insumo(id);
    _monto(costoEnvase, permiteCero: true);
    final cantidad = milesimasDeCompra(
      envases: envases,
      contenidoEnvaseMilesimas: i.contenido,
    );
    await _moverInsumo(id, cantidad, 'Compra de $envases envase(s)');
    await (db.update(db.insumos)..where((i) => i.id.equals(id))).write(
      InsumosCompanion(costoEnvase: Value(costoEnvase)),
    );
  });

  Future<void> contarInsumo(int id, int cantidad) => db.transaction(() async {
    if (cantidad < 0) throw ArgumentError('Lo contado no puede ser negativo.');
    final i = await _insumo(id);
    if (cantidad != i.stock) {
      await _moverInsumo(id, cantidad - i.stock, 'Conteo físico');
    }
  });

  Future<Insumo> _insumo(int id) =>
      (db.select(db.insumos)..where((i) => i.id.equals(id))).getSingle();
  Future<void> _moverInsumo(
    int id,
    int delta,
    String motivo, {
    int? ordenId,
  }) async {
    final i = await _insumo(id);
    await (db.update(db.insumos)..where((i) => i.id.equals(id))).write(
      InsumosCompanion(stock: Value(i.stock + delta)),
    );
    await db
        .into(db.movimientosStock)
        .insert(
          MovimientosStockCompanion.insert(
            insumoId: id,
            ordenId: Value(ordenId),
            anterior: i.stock,
            posterior: i.stock + delta,
            motivo: motivo,
          ),
        );
  }

  Future<List<MovimientoInsumo>> historialInsumo(int id) =>
      (db.select(db.movimientosStock)
            ..where((m) => m.insumoId.equals(id))
            ..orderBy([(m) => OrderingTerm.desc(m.fecha)]))
          .get();

  Future<int> guardarServicio({
    int? id,
    required String nombre,
    required int duracion,
    required bool manoDeObra,
    required Map<TipoVehiculo, int> precios,
    required List<UsoReceta> receta,
    bool activo = true,
    int gananciaBuscada = 6000,
  }) => db.transaction(() async {
    _nombre(nombre);
    if (duracion <= 0) {
      throw ArgumentError('La duración debe ser mayor a cero.');
    }
    if (gananciaBuscada < 0 || gananciaBuscada >= 10000) {
      throw ArgumentError('El margen buscado va de 0 a 99 %.');
    }
    if (precios.isEmpty) {
      throw ArgumentError('Cargá al menos un precio por tipo de vehículo.');
    }
    for (final p in precios.values) {
      _monto(p);
    }
    if (receta.map((r) => r.insumoId).toSet().length != receta.length ||
        receta.any((r) => r.cantidad <= 0)) {
      throw ArgumentError(
        'Revisá las cantidades: cada insumo se agrega una sola vez.',
      );
    }
    for (final r in receta) {
      if (!(await _insumo(r.insumoId)).activo) {
        throw ArgumentError('Hay un insumo dado de baja en la receta.');
      }
    }
    final sid =
        id ??
        await db
            .into(db.servicios)
            .insert(
              ServiciosCompanion.insert(
                nombre: nombre.trim(),
                duracion: duracion,
                manoDeObra: Value(manoDeObra),
                gananciaBuscada: Value(gananciaBuscada),
              ),
            );
    if (id != null) {
      await (db.update(db.servicios)..where((s) => s.id.equals(id))).write(
        ServiciosCompanion(
          nombre: Value(nombre.trim()),
          duracion: Value(duracion),
          manoDeObra: Value(manoDeObra),
          activo: Value(activo),
          gananciaBuscada: Value(gananciaBuscada),
        ),
      );
      await (db.delete(db.tarifas)..where((t) => t.servicioId.equals(id))).go();
      await (db.delete(db.recetas)..where((r) => r.servicioId.equals(id))).go();
    }
    for (final e in precios.entries) {
      await db
          .into(db.tarifas)
          .insert(
            TarifasCompanion.insert(
              servicioId: sid,
              tipo: e.key.name,
              precio: e.value,
            ),
          );
    }
    for (final r in receta) {
      await db
          .into(db.recetas)
          .insert(
            RecetasCompanion.insert(
              servicioId: sid,
              insumoId: r.insumoId,
              cantidad: r.cantidad,
            ),
          );
    }
    return sid;
  });

  Future<CostoDeServicio> costoServicio(int id) async {
    final servicio = await (db.select(
      db.servicios,
    )..where((s) => s.id.equals(id))).getSingle();
    return _costo(servicio, await _usos(id), (await ajustes()).valorHora);
  }

  Future<List<({Insumo insumo, int cantidad})>> _usos(int id) async {
    final rs = await (db.select(
      db.recetas,
    )..where((r) => r.servicioId.equals(id))).get();
    return [
      for (final r in rs)
        (insumo: await _insumo(r.insumoId), cantidad: r.cantidad),
    ];
  }

  CostoDeServicio _costo(
    Servicio s,
    List<({Insumo insumo, int cantidad})> usos,
    int valorHora,
  ) => costoDeServicio(
    receta: [
      for (final u in usos)
        UsoDeInsumo(
          insumo: insumoParaCalculo(u.insumo),
          cantidadMilesimas: u.cantidad,
        ),
    ],
    duracionMinutos: s.duracion,
    valorHoraCentavos: s.manoDeObra ? valorHora : null,
  );

  Future<Vehiculo?> buscarVehiculo(String patente) =>
      (db.select(db.vehiculos)
            ..where((v) => v.patente.equals(normalizarPatente(patente))))
          .getSingleOrNull();
  Future<List<Vehiculo>> vehiculos() => (db.select(
    db.vehiculos,
  )..orderBy([(v) => OrderingTerm.asc(v.patente)])).get();

  Future<void> editarVehiculo(
    int id, {
    required String patente,
    required String modelo,
    required TipoVehiculo tipo,
    required String cliente,
    required String telefono,
    required String notas,
  }) async {
    final placa = validarPatente(patente);
    _nombre(modelo);
    final existente = await buscarVehiculo(placa);
    if (existente != null && existente.id != id) {
      throw ArgumentError('Esa patente ya está cargada.');
    }
    await (db.update(db.vehiculos)..where((v) => v.id.equals(id))).write(
      VehiculosCompanion(
        patente: Value(placa),
        modelo: Value(modelo.trim()),
        tipo: Value(tipo.name),
        cliente: Value(cliente.trim()),
        telefono: Value(telefono.trim()),
        notas: Value(notas.trim()),
      ),
    );
  }

  Future<int> crearOrden({
    required String patente,
    required String modelo,
    required TipoVehiculo tipo,
    required String cliente,
    required String telefono,
    required String responsable,
    required String notas,
    required List<EleccionServicio> servicios,
    required String operacion,
    DateTime? programada,
  }) => db.transaction(() async {
    final existente = await (db.select(
      db.ordenes,
    )..where((o) => o.operacion.equals(operacion))).getSingleOrNull();
    if (existente != null) return existente.id;
    final placa = validarPatente(patente);
    _nombre(modelo);
    _nombre(operacion);
    if (servicios.isEmpty) throw ArgumentError('Elegí al menos un servicio.');
    if (servicios.map((s) => s.servicioId).toSet().length != servicios.length) {
      throw ArgumentError('Un servicio está repetido.');
    }
    final vehiculo = await buscarVehiculo(placa);
    final datos = VehiculosCompanion.insert(
      patente: placa,
      modelo: modelo.trim(),
      tipo: tipo.name,
      cliente: Value(cliente.trim()),
      telefono: Value(telefono.trim()),
    );
    final vid = vehiculo?.id ?? await db.into(db.vehiculos).insert(datos);
    if (vehiculo != null) {
      await (db.update(
        db.vehiculos,
      )..where((v) => v.id.equals(vid))).write(datos);
    }
    final oid = await db
        .into(db.ordenes)
        .insert(
          OrdenesCompanion.insert(
            vehiculoId: vid,
            patente: placa,
            modelo: modelo.trim(),
            tipo: tipo.name,
            cliente: cliente.trim(),
            telefono: telefono.trim(),
            responsable: Value(responsable.trim()),
            notas: Value(notas.trim()),
            programada: Value(programada),
            operacion: operacion,
          ),
        );
    final hora = (await ajustes()).valorHora;
    for (final eleccion in servicios) {
      _monto(eleccion.precio);
      final s = await (db.select(
        db.servicios,
      )..where((s) => s.id.equals(eleccion.servicioId))).getSingle();
      if (!s.activo) {
        throw ArgumentError('El servicio ${s.nombre} ya no se ofrece.');
      }
      final usos = await _usos(s.id);
      if (usos.any((u) => !u.insumo.activo)) {
        throw ArgumentError(
          'Hay un insumo dado de baja en ${s.nombre}. Revisá su receta.',
        );
      }
      final costo = _costo(s, usos, hora);
      await db
          .into(db.lineasOrden)
          .insert(
            LineasOrdenCompanion.insert(
              ordenId: oid,
              servicioId: s.id,
              nombre: s.nombre,
              precio: eleccion.precio,
              duracion: s.duracion,
              costoInsumos: costo.insumosCentavos,
              costoManoDeObra: costo.manoDeObraCentavos,
              receta: jsonEncode([
                for (final u in usos)
                  {'id': u.insumo.id, 'cantidad': u.cantidad},
              ]),
            ),
          );
    }
    return oid;
  });

  Future<DetalleOrden> detalle(int id) async => DetalleOrden(
    await (db.select(db.ordenes)..where((o) => o.id.equals(id))).getSingle(),
    await (db.select(db.lineasOrden)..where((l) => l.ordenId.equals(id))).get(),
    await (db.select(db.movimientosCaja)
          ..where((m) => m.ordenId.equals(id))
          ..orderBy([(m) => OrderingTerm.asc(m.fecha)]))
        .get(),
  );

  Future<List<DetalleOrden>> ordenes() async {
    final filas = await (db.select(
      db.ordenes,
    )..orderBy([(o) => OrderingTerm.desc(o.creada)])).get();
    return [for (final o in filas) await detalle(o.id)];
  }

  Future<Map<int, int>> _consumo(DetalleOrden d) async {
    final resultado = <int, int>{};
    for (final l in d.lineas) {
      for (final r in jsonDecode(l.receta) as List) {
        final id = r['id'] as int;
        resultado[id] = (resultado[id] ?? 0) + (r['cantidad'] as int);
      }
    }
    return resultado;
  }

  Future<List<String>> faltantes(int ordenId) async {
    final resultado = <String>[];
    for (final e in (await _consumo(await detalle(ordenId))).entries) {
      final i = await _insumo(e.key);
      if (i.stock < e.value) resultado.add(i.nombre);
    }
    return resultado;
  }

  Future<void> cambiarEstado(
    int id,
    EstadoLavado siguiente, {
    bool permitirFaltantes = false,
  }) => db.transaction(() async {
    final d = await detalle(id);
    // Un reintento no vuelve a descontar insumos.
    if (d.estado == siguiente) return;
    if (!d.estado.puedePasarA(siguiente)) {
      throw ArgumentError('Ese cambio de estado no corresponde.');
    }
    if (siguiente == EstadoLavado.cancelado) {
      await _devolverAnticipos(d);
    }
    if (siguiente == EstadoLavado.enLavado) {
      if (!permitirFaltantes && (await faltantes(id)).isNotEmpty) {
        throw ArgumentError(
          'No alcanzan los insumos. Revisá el stock antes de empezar.',
        );
      }
      for (final e in (await _consumo(d)).entries) {
        await _moverInsumo(
          e.key,
          -e.value,
          'Lavado #$id · ${d.orden.patente}',
          ordenId: id,
        );
      }
    }
    final ahora = DateTime.now();
    await (db.update(db.ordenes)..where((o) => o.id.equals(id))).write(
      OrdenesCompanion(
        estado: Value(siguiente.name),
        iniciada: siguiente == EstadoLavado.enLavado
            ? Value(ahora)
            : const Value.absent(),
        terminada: siguiente == EstadoLavado.listo
            ? Value(ahora)
            : const Value.absent(),
        entregada: siguiente == EstadoLavado.entregado
            ? Value(ahora)
            : const Value.absent(),
      ),
    );
  });

  Future<void> editarOrden(
    int id, {
    required String notas,
    required String responsable,
    DateTime? programada,
  }) async {
    final d = await detalle(id);
    if (d.estado == EstadoLavado.cancelado ||
        d.estado == EstadoLavado.entregado) {
      throw ArgumentError('La orden ya está cerrada.');
    }
    await (db.update(db.ordenes)..where((o) => o.id.equals(id))).write(
      OrdenesCompanion(
        notas: Value(notas.trim()),
        responsable: Value(responsable.trim()),
        programada: Value(programada),
      ),
    );
  }

  Future<SesionCaja?> cajaAbierta() =>
      (db.select(db.cajas)..where((c) => c.cerrada.isNull())).getSingleOrNull();
  Future<List<SesionCaja>> cajas() => (db.select(
    db.cajas,
  )..orderBy([(c) => OrderingTerm.desc(c.abierta)])).get();
  Future<int> abrirCaja({required int efectivo, required int digital}) =>
      db.transaction(() async {
        _monto(efectivo, permiteCero: true);
        _monto(digital, permiteCero: true);
        if (await cajaAbierta() != null) {
          throw ArgumentError('Ya hay una caja abierta.');
        }
        return db
            .into(db.cajas)
            .insert(
              CajasCompanion.insert(
                inicialEfectivo: efectivo,
                inicialDigital: digital,
              ),
            );
      });
  Future<ResumenCaja> resumenCaja(int id) async => ResumenCaja(
    await (db.select(db.cajas)..where((c) => c.id.equals(id))).getSingle(),
    await (db.select(db.movimientosCaja)
          ..where((m) => m.cajaId.equals(id))
          ..orderBy([(m) => OrderingTerm.desc(m.fecha)]))
        .get(),
  );

  Future<int> _exigirCaja() async {
    final caja = await cajaAbierta();
    if (caja == null) {
      throw ArgumentError('Abrí la caja para registrar dinero.');
    }
    return caja.id;
  }

  Future<bool> _yaRegistrado(String operacion) async =>
      await (db.select(
        db.movimientosCaja,
      )..where((m) => m.operacion.equals(operacion))).getSingleOrNull() !=
      null;

  Future<void> cobrar(
    int id, {
    required int monto,
    required MedioPago medio,
    required String operacion,
  }) => db.transaction(() async {
    if (await _yaRegistrado(operacion)) return;
    final d = await detalle(id);
    if (d.estado == EstadoLavado.cancelado) {
      throw ArgumentError('La orden está cancelada.');
    }
    validarCobro(monto: monto, saldo: d.saldo);
    await db
        .into(db.movimientosCaja)
        .insert(
          MovimientosCajaCompanion.insert(
            cajaId: await _exigirCaja(),
            ordenId: Value(id),
            medio: medio.name,
            monto: monto,
            concepto:
                '${monto < d.saldo ? 'Seña' : 'Cobro'} #$id · ${d.orden.patente}',
            clase: 'cobro',
            operacion: operacion,
          ),
        );
  });

  Future<void> movimiento({
    required int monto,
    required MedioPago medio,
    required bool gasto,
    required String concepto,
    required String operacion,
  }) => db.transaction(() async {
    if (await _yaRegistrado(operacion)) return;
    _monto(monto);
    _nombre(concepto);
    await db
        .into(db.movimientosCaja)
        .insert(
          MovimientosCajaCompanion.insert(
            cajaId: await _exigirCaja(),
            medio: medio.name,
            monto: gasto ? -monto : monto,
            concepto: concepto.trim(),
            clase: gasto ? 'gasto' : 'ingreso',
            operacion: operacion,
          ),
        );
  });

  Future<void> _devolverAnticipos(DetalleOrden d) async {
    if (d.cobrado == 0) return;
    final cid = await _exigirCaja();
    for (final medio in MedioPago.values) {
      final monto = d.pagos
          .where((p) => p.medio == medio.name)
          .fold<int>(0, (s, p) => s + p.monto);
      if (monto > 0) {
        await db
            .into(db.movimientosCaja)
            .insert(
              MovimientosCajaCompanion.insert(
                cajaId: cid,
                ordenId: Value(d.orden.id),
                medio: medio.name,
                monto: -monto,
                concepto: 'Devolución #${d.orden.id} · ${d.orden.patente}',
                clase: 'devolucion',
                operacion: 'cancelar-${d.orden.id}-${medio.name}',
              ),
            );
      }
    }
  }

  Future<void> cerrarCaja(
    int id, {
    required int efectivo,
    required int digital,
  }) => db.transaction(() async {
    _monto(efectivo, permiteCero: true);
    _monto(digital, permiteCero: true);
    final caja = (await resumenCaja(id)).caja;
    if (caja.cerrada != null) return;
    await (db.update(db.cajas)..where((c) => c.id.equals(id))).write(
      CajasCompanion(
        cerrada: Value(DateTime.now()),
        contadoEfectivo: Value(efectivo),
        contadoDigital: Value(digital),
      ),
    );
  });
}

InsumoParaCalculo insumoParaCalculo(Insumo i) => InsumoParaCalculo(
  costoEnvaseCentavos: i.costoEnvase,
  contenidoEnvaseMilesimas: i.contenido,
  stockMilesimas: i.stock,
);

void _nombre(String n) {
  if (n.trim().isEmpty) {
    throw ArgumentError('Completá los campos obligatorios.');
  }
}

void _monto(int n, {bool permiteCero = false}) {
  if (n < (permiteCero ? 0 : 1) || n > 10000000000000) {
    throw ArgumentError('El monto no es válido.');
  }
}
