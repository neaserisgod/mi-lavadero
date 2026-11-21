import 'package:flutter/material.dart';

import '../data/database.dart';
import '../data/repositorio.dart';
import '../domain/dinero.dart';
import '../domain/lavadero.dart';
import 'app.dart';
import 'comun.dart';
import 'ordenes.dart';

class PantallaVehiculos extends StatefulWidget {
  const PantallaVehiculos({
    super.key,
    required this.repo,
    required this.datos,
    required this.abrir,
  });
  final Repositorio repo;
  final DatosApp datos;
  final Future<void> Function(Widget) abrir;
  @override
  State<PantallaVehiculos> createState() => _PantallaVehiculosState();
}

class _PantallaVehiculosState extends State<PantallaVehiculos> {
  String buscar = '';
  @override
  Widget build(BuildContext context) {
    final vehiculos = widget.datos.vehiculos.where(
      (v) => '${v.patente} ${v.modelo} ${v.cliente}'.toLowerCase().contains(
        buscar.toLowerCase(),
      ),
    );
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Buscar patente o cliente',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (v) => setState(() => buscar = v),
        ),
        const SizedBox(height: 20),
        if (vehiculos.isEmpty)
          const Vacio(
            'El historial de cada auto',
            'Los vehículos se guardan cuando creás su primera orden.',
          ),
        for (final v in vehiculos)
          Bloque(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.directions_car_outlined),
              title: Text(
                v.patente,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                '${v.modelo}${v.cliente.isEmpty ? '' : ' · ${v.cliente}'}',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => widget.abrir(
                FichaVehiculo(repo: widget.repo, vehiculoId: v.id),
              ),
            ),
          ),
      ],
    );
  }
}

class FichaVehiculo extends StatefulWidget {
  const FichaVehiculo({
    super.key,
    required this.repo,
    required this.vehiculoId,
  });
  final Repositorio repo;
  final int vehiculoId;
  @override
  State<FichaVehiculo> createState() => _FichaVehiculoState();
}

class _FichaVehiculoState extends State<FichaVehiculo> {
  late Future<DatosApp> datos = DatosApp.cargar(widget.repo);
  Future<void> abrir(Widget w) async {
    await Navigator.push(context, MaterialPageRoute<void>(builder: (_) => w));
    if (mounted) {
      setState(() {
        datos = DatosApp.cargar(widget.repo);
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Ficha del vehículo')),
    body: FutureBuilder(
      future: datos,
      builder: (context, s) {
        if (s.hasError) return Center(child: Text(errorLegible(s.error!)));
        if (!s.hasData) return const Center(child: CircularProgressIndicator());
        final d = s.data!;
        final v = d.vehiculos.firstWhere((v) => v.id == widget.vehiculoId);
        final ordenes = d.ordenes
            .where((o) => o.orden.vehiculoId == v.id)
            .toList();
        final saldo = ordenes
            .where((o) => o.estado != EstadoLavado.cancelado)
            .fold<int>(0, (s, o) => s + o.saldo);
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(v.patente, style: Theme.of(context).textTheme.headlineLarge),
            Text(v.modelo),
            if (v.cliente.isNotEmpty) Dato('Cliente', v.cliente),
            if (v.telefono.isNotEmpty) Dato('Teléfono', v.telefono),
            if (v.notas.isNotEmpty) Bloque(child: Text(v.notas)),
            Dato('Saldo pendiente total', formatearARS(saldo)),
            FilledButton.icon(
              onPressed: () => abrir(
                NuevaOrden(
                  repo: widget.repo,
                  catalogo: d.catalogo,
                  vehiculo: v,
                ),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Nuevo lavado'),
            ),
            TextButton(
              onPressed: () =>
                  abrir(EditarVehiculo(repo: widget.repo, vehiculo: v)),
              child: const Text('Editar ficha'),
            ),
            const SizedBox(height: 16),
            Text('Historial', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            for (final o in ordenes)
              OrdenTarjeta(
                detalle: o,
                onTap: () => abrir(
                  PantallaDetalleOrden(repo: widget.repo, id: o.orden.id),
                ),
              ),
          ],
        );
      },
    ),
  );
}

class EditarVehiculo extends StatefulWidget {
  const EditarVehiculo({super.key, required this.repo, required this.vehiculo});
  final Repositorio repo;
  final Vehiculo vehiculo;
  @override
  State<EditarVehiculo> createState() => _EditarVehiculoState();
}

class _EditarVehiculoState extends State<EditarVehiculo> {
  late final patente = TextEditingController(text: widget.vehiculo.patente);
  late final modelo = TextEditingController(text: widget.vehiculo.modelo);
  late final cliente = TextEditingController(text: widget.vehiculo.cliente);
  late final telefono = TextEditingController(text: widget.vehiculo.telefono);
  late final notas = TextEditingController(text: widget.vehiculo.notas);
  late TipoVehiculo tipo = TipoVehiculo.values.byName(widget.vehiculo.tipo);
  @override
  void dispose() {
    for (final c in [patente, modelo, cliente, telefono, notas]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Formulario(
    titulo: 'Editar vehículo',
    campos: [
      Campo('Patente *', patente),
      Campo('Marca y modelo *', modelo),
      DropdownButtonFormField<TipoVehiculo>(
        initialValue: tipo,
        items: [
          for (final t in TipoVehiculo.values)
            DropdownMenuItem(value: t, child: Text(t.etiqueta)),
        ],
        onChanged: (t) => setState(() => tipo = t!),
      ),
      const SizedBox(height: 16),
      Campo('Cliente', cliente),
      Campo('Teléfono', telefono),
      Campo('Notas para próximas visitas', notas, lineas: 3),
      const Text(
        'Las órdenes anteriores conservan los datos y precios con los que se crearon.',
      ),
    ],
    guardar: () async {
      await widget.repo.editarVehiculo(
        widget.vehiculo.id,
        patente: patente.text,
        modelo: modelo.text,
        tipo: tipo,
        cliente: cliente.text,
        telefono: telefono.text,
        notas: notas.text,
      );
      if (context.mounted) Navigator.pop(context, true);
    },
  );
}
