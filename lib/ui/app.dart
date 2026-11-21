import 'package:flutter/material.dart';

import '../data/database.dart';
import '../data/repositorio.dart';
import '../domain/dinero.dart';
import '../domain/lavadero.dart';
import 'ajustes.dart';
import 'caja.dart';
import 'catalogo.dart';
import 'comun.dart';
import 'diseno.dart';
import 'ordenes.dart';
import 'vehiculos.dart';

class DatosApp {
  DatosApp(
    this.ajustes,
    this.catalogo,
    this.ordenes,
    this.vehiculos,
    this.cajas,
    this.caja,
  );
  final Ajuste ajustes;
  final Catalogo catalogo;
  final List<DetalleOrden> ordenes;
  final List<Vehiculo> vehiculos;
  final List<SesionCaja> cajas;
  final ResumenCaja? caja;
  static Future<DatosApp> cargar(Repositorio repo) async {
    final cajas = await repo.cajas();
    final abierta = await repo.cajaAbierta();
    return DatosApp(
      await repo.ajustes(),
      await Catalogo.cargar(repo),
      await repo.ordenes(),
      await repo.vehiculos(),
      cajas,
      abierta == null ? null : await repo.resumenCaja(abierta.id),
    );
  }
}

class InicioApp extends StatefulWidget {
  const InicioApp({super.key, required this.repo});
  final Repositorio repo;
  @override
  State<InicioApp> createState() => _InicioAppState();
}

class _InicioAppState extends State<InicioApp>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late final AnimationController cambio = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
    value: 1,
  );
  DatosApp? datos;
  Object? error;
  int pestania = 0;
  int generacion = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    cargar();
  }

  @override
  void dispose() {
    cambio.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) cargar();
  }

  Future<void> cargar() async {
    final version = ++generacion;
    try {
      final nuevo = await DatosApp.cargar(widget.repo);
      if (mounted && version == generacion) {
        setState(() {
          datos = nuevo;
          error = null;
        });
      }
    } catch (e) {
      if (mounted && version == generacion) setState(() => error = e);
    }
  }

  Future<void> abrir(Widget pagina) async {
    await Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => pagina),
    );
    await cargar();
  }

  @override
  Widget build(BuildContext context) {
    final d = datos;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ['Lavados', 'Servicios e insumos', 'Vehículos', 'Caja'][pestania],
          style: const TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w700,
            letterSpacing: -.7,
          ),
        ),
        toolbarHeight: 80,
        actions: [
          IconButton(
            tooltip: 'Ajustes y respaldos',
            onPressed: d == null
                ? null
                : () => abrir(
                    PantallaAjustes(repo: widget.repo, ajustes: d.ajustes),
                  ),
            icon: const Icon(Icons.tune_rounded),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: d == null
            ? error == null
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(errorLegible(error!)),
                            const SizedBox(height: 16),
                            FilledButton(
                              onPressed: cargar,
                              child: const Text('Reintentar'),
                            ),
                          ],
                        ),
                      ),
                    )
            : Column(
                children: [
                  if (error != null)
                    MaterialBanner(
                      content: const Text('No se pudo actualizar la vista.'),
                      actions: [
                        TextButton(
                          onPressed: cargar,
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  Expanded(
                    child: FadeTransition(
                      opacity: CurvedAnimation(
                        parent: cambio,
                        curve: Curves.easeOutCubic,
                      ),
                      child: IndexedStack(
                        index: pestania,
                        children: [
                          PantallaLavados(
                            datos: d,
                            abrir: abrir,
                            repo: widget.repo,
                          ),
                          PantallaCatalogo(
                            repo: widget.repo,
                            catalogo: d.catalogo,
                            abrir: abrir,
                          ),
                          PantallaVehiculos(
                            repo: widget.repo,
                            datos: d,
                            abrir: abrir,
                          ),
                          PantallaCaja(
                            repo: widget.repo,
                            cajas: d.cajas,
                            resumen: d.caja,
                            abrir: abrir,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (d != null && pestania == 0)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: SizedBox(
                width: double.infinity,
                child: BotonAccion(
                  'Recibir vehículo',
                  () => abrir(
                    NuevaOrden(repo: widget.repo, catalogo: d.catalogo),
                  ),
                  icono: Icons.add_rounded,
                ),
              ),
            ),
          BarraPropia(
            actual: pestania,
            cambiar: (i) {
              if (i == pestania) {
                return;
              }
              setState(() => pestania = i);
              if (!MediaQuery.disableAnimationsOf(context)) {
                cambio.forward(from: .35);
              }
            },
            nombres: const ['Lavados', 'Servicios', 'Vehículos', 'Caja'],
            iconos: const [
              Icons.local_car_wash_outlined,
              Icons.grid_view_outlined,
              Icons.directions_car_outlined,
              Icons.account_balance_wallet_outlined,
            ],
          ),
        ],
      ),
    );
  }
}

bool mismoDia(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

class PantallaLavados extends StatefulWidget {
  const PantallaLavados({
    super.key,
    required this.datos,
    required this.repo,
    required this.abrir,
  });
  final DatosApp datos;
  final Repositorio repo;
  final Future<void> Function(Widget) abrir;
  @override
  State<PantallaLavados> createState() => _PantallaLavadosState();
}

class _PantallaLavadosState extends State<PantallaLavados> {
  String buscar = '';
  int filtro = 0;
  int periodo = 0;
  @override
  Widget build(BuildContext context) {
    final hoy = DateTime.now();
    final todos = widget.datos.ordenes;
    final terminadosHoy = todos
        .where(
          (d) => d.orden.terminada != null && mismoDia(d.orden.terminada!, hoy),
        )
        .toList();
    final cobradoHoy = todos
        .expand((d) => d.pagos)
        .where((p) => mismoDia(p.fecha, hoy))
        .fold<int>(0, (s, p) => s + p.monto);
    final filas = todos.where((d) {
      final coincide =
          '${d.orden.patente} ${d.orden.modelo} ${d.orden.cliente} ${d.orden.telefono} ${d.orden.id}'
              .toLowerCase()
              .contains(buscar.toLowerCase());
      final estado = switch (filtro) {
        0 =>
          d.estado != EstadoLavado.cancelado &&
              d.estado != EstadoLavado.entregado,
        1 => d.orden.programada != null && d.estado == EstadoLavado.recibido,
        2 => d.estado != EstadoLavado.cancelado && d.saldo > 0,
        _ => true,
      };
      final fecha = d.orden.programada ?? d.orden.creada;
      final enPeriodo =
          periodo == 0 ||
          (periodo == 1
              ? mismoDia(fecha, hoy)
              : fecha.year == hoy.year && fecha.month == hoy.month);
      return coincide && estado && enPeriodo;
    }).toList();
    if (filtro == 1) {
      filas.sort((a, b) => a.orden.programada!.compareTo(b.orden.programada!));
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
      children: [
        Bloque(
          color: const Color(0xFF183A38),
          child: DefaultTextStyle.merge(
            style: const TextStyle(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Hoy en ${widget.datos.ajustes.nombre}',
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Dato('Cobrado', formatearARS(cobradoHoy), grande: true),
                Dato('Lavados terminados', '${terminadosHoy.length}'),
                Dato(
                  'Margen estimado',
                  formatearARS(terminadosHoy.fold(0, (s, d) => s + d.margen)),
                ),
              ],
            ),
          ),
        ),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Buscar patente, cliente o modelo',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (v) => setState(() => buscar = v),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            for (final (i, nombre) in [
              'En curso',
              'Turnos',
              'Por cobrar',
              'Historial',
            ].indexed)
              ChoiceChip(
                label: Text(nombre),
                selected: filtro == i,
                onSelected: (_) => setState(() => filtro = i),
              ),
          ],
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<int>(
          initialValue: periodo,
          decoration: const InputDecoration(
            labelText: 'Fecha de ingreso o turno',
          ),
          items: const [
            DropdownMenuItem(value: 0, child: Text('Todas las fechas')),
            DropdownMenuItem(value: 1, child: Text('Hoy')),
            DropdownMenuItem(value: 2, child: Text('Este mes')),
          ],
          onChanged: (v) => setState(() => periodo = v!),
        ),
        const SizedBox(height: 16),
        if (filas.isEmpty)
          Vacio(
            todos.isEmpty
                ? 'Tu próximo lavado empieza acá'
                : 'Sin órdenes en esta vista',
            todos.isEmpty
                ? 'Cargá tus servicios y después tocá Recibir vehículo.'
                : 'Probá otro filtro o buscá por patente.',
          ),
        for (final d in filas)
          OrdenTarjeta(
            detalle: d,
            onTap: () => widget.abrir(
              PantallaDetalleOrden(repo: widget.repo, id: d.orden.id),
            ),
          ),
      ],
    );
  }
}
