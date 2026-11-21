import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../data/database.dart';
import '../data/repositorio.dart';
import '../domain/dinero.dart';
import '../domain/lavadero.dart';
import 'catalogo.dart';
import 'comun.dart';
import 'diseno.dart';

Future<DateTime?> elegirFecha(BuildContext context, DateTime? actual) async {
  final ahora = DateTime.now();
  final dia = await showDatePicker(
    context: context,
    initialDate: actual ?? ahora,
    firstDate: DateTime(2020),
    lastDate: DateTime(2100),
  );
  if (dia == null || !context.mounted) return null;
  final hora = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(actual ?? ahora),
  );
  return hora == null
      ? null
      : DateTime(dia.year, dia.month, dia.day, hora.hour, hora.minute);
}

class OrdenTarjeta extends StatelessWidget {
  const OrdenTarjeta({super.key, required this.detalle, required this.onTap});
  final DetalleOrden detalle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final d = detalle;
    final o = d.orden;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: borde),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        o.patente,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      '#${o.id}',
                      style: const TextStyle(color: Color(0xFF526B64)),
                    ),
                  ],
                ),
                Text(
                  '${o.modelo}${o.cliente.isEmpty ? '' : ' · ${o.cliente}'}',
                ),
                const SizedBox(height: 8),
                Text(
                  d.lineas.map((l) => l.nombre).join(' + '),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (o.programada != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('Turno ${fechaHora(o.programada!)}'),
                  ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    Chip(
                      label: Text(d.estado.etiqueta),
                      visualDensity: VisualDensity.compact,
                    ),
                    Chip(
                      label: Text(
                        d.estado == EstadoLavado.cancelado
                            ? 'Cancelado'
                            : d.saldo == 0
                            ? 'Pagado'
                            : 'Falta ${formatearARS(d.saldo)}',
                      ),
                      visualDensity: VisualDensity.compact,
                      backgroundColor:
                          d.saldo > 0 && d.estado != EstadoLavado.cancelado
                          ? const Color(0xFFFFEDD3)
                          : const Color(0xFFE4F3EB),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NuevaOrden extends StatefulWidget {
  const NuevaOrden({
    super.key,
    required this.repo,
    required this.catalogo,
    this.vehiculo,
  });
  final Repositorio repo;
  final Catalogo catalogo;
  final Vehiculo? vehiculo;
  @override
  State<NuevaOrden> createState() => _NuevaOrdenState();
}

class _NuevaOrdenState extends State<NuevaOrden> {
  late final patente = TextEditingController(text: widget.vehiculo?.patente);
  late final modelo = TextEditingController(text: widget.vehiculo?.modelo);
  late final cliente = TextEditingController(text: widget.vehiculo?.cliente);
  late final telefono = TextEditingController(text: widget.vehiculo?.telefono);
  final responsable = TextEditingController();
  final notas = TextEditingController();
  late TipoVehiculo tipo = widget.vehiculo == null
      ? TipoVehiculo.auto
      : TipoVehiculo.values.byName(widget.vehiculo!.tipo);
  final seleccion = <int, TextEditingController>{};
  final operacion = nuevaOperacion();
  DateTime? programada;
  @override
  void dispose() {
    for (final c in [
      patente,
      modelo,
      cliente,
      telefono,
      responsable,
      notas,
      ...seleccion.values,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void cambiarTipo(TipoVehiculo t) {
    for (final c in seleccion.values) {
      c.dispose();
    }
    setState(() {
      tipo = t;
      seleccion.clear();
    });
  }

  Future<void> buscar() async {
    final texto = normalizarPatente(patente.text);
    final v = await widget.repo.buscarVehiculo(texto);
    if (!mounted || texto != normalizarPatente(patente.text)) return;
    if (v == null) {
      aviso(context, 'Patente nueva. Completá los datos para guardarla.');
      return;
    }
    modelo.text = v.modelo;
    cliente.text = v.cliente;
    telefono.text = v.telefono;
    cambiarTipo(TipoVehiculo.values.byName(v.tipo));
    aviso(context, 'Datos del vehículo recuperados.');
  }

  @override
  Widget build(BuildContext context) {
    final servicios = widget.catalogo.servicios.where((s) => s.activo).toList();
    int total = 0;
    for (final c in seleccion.values) {
      try {
        total += montoCampo(c, cero: true);
      } catch (_) {}
    }
    return Formulario(
      titulo: 'Recibir vehículo',
      accion: 'Crear orden',
      campos: [
        Campo(
          'Patente *',
          patente,
          ayuda: 'Buscala para recuperar al cliente y su vehículo.',
        ),
        OutlinedButton.icon(
          onPressed: buscar,
          icon: const Icon(Icons.search),
          label: const Text('Buscar patente'),
        ),
        const SizedBox(height: 18),
        Campo('Marca y modelo *', modelo),
        DropdownButtonFormField<TipoVehiculo>(
          key: ValueKey(tipo),
          initialValue: tipo,
          decoration: const InputDecoration(labelText: 'Tipo de vehículo'),
          items: [
            for (final t in TipoVehiculo.values)
              DropdownMenuItem(value: t, child: Text(t.etiqueta)),
          ],
          onChanged: (t) => cambiarTipo(t!),
        ),
        const SizedBox(height: 18),
        Campo('Cliente', cliente),
        Campo('Teléfono', telefono),
        Text(
          'Servicios y extras',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Text(
          'Elegí lo que vas a hacer. Podés acordar otro precio para esta orden.',
        ),
        const SizedBox(height: 8),
        if (servicios.isEmpty)
          const Vacio(
            'Primero cargá un servicio',
            'Volvé a Servicios y creá lo que ofrecés, con tus precios.',
          ),
        for (final s in servicios) ...[
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(s.nombre),
            subtitle: Text(
              widget.catalogo.precio(s.id, tipo) == null
                  ? 'Sin tarifa para ${tipo.etiqueta}. Cargala en Servicios.'
                  : '${s.duracion} min · ${formatearARS(widget.catalogo.precio(s.id, tipo)!)}',
            ),
            value: seleccion.containsKey(s.id),
            onChanged: widget.catalogo.precio(s.id, tipo) == null
                ? null
                : (v) => setState(() {
                    if (v!) {
                      seleccion[s.id] = TextEditingController(
                        text: pesosCampo(widget.catalogo.precio(s.id, tipo)!),
                      );
                    } else {
                      seleccion.remove(s.id)?.dispose();
                    }
                  }),
          ),
          if (seleccion[s.id] case final c?)
            Campo(
              'Precio acordado: ${s.nombre} (\$)',
              c,
              numerico: true,
              onChanged: (_) => setState(() {}),
            ),
        ],
        Bloque(
          child: Dato('Total acordado', formatearARS(total), grande: true),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () async {
            final f = await elegirFecha(context, programada);
            if (f != null && mounted) setState(() => programada = f);
          },
          icon: const Icon(Icons.event_outlined),
          label: Text(
            programada == null
                ? 'Programar un turno (opcional)'
                : fechaHora(programada!),
          ),
        ),
        if (programada != null)
          TextButton(
            onPressed: () => setState(() => programada = null),
            child: const Text('Atender por llegada'),
          ),
        const SizedBox(height: 18),
        Campo('Responsable', responsable),
        Campo('Observaciones del vehículo y del trabajo', notas, lineas: 3),
      ],
      guardar: () async {
        await widget.repo.crearOrden(
          patente: patente.text,
          modelo: modelo.text,
          tipo: tipo,
          cliente: cliente.text,
          telefono: telefono.text,
          responsable: responsable.text,
          notas: notas.text,
          servicios: [
            for (final e in seleccion.entries)
              (servicioId: e.key, precio: montoCampo(e.value)),
          ],
          operacion: operacion,
          programada: programada,
        );
        if (context.mounted) Navigator.pop(context, true);
      },
    );
  }
}

class PantallaDetalleOrden extends StatefulWidget {
  const PantallaDetalleOrden({super.key, required this.repo, required this.id});
  final Repositorio repo;
  final int id;
  @override
  State<PantallaDetalleOrden> createState() => _PantallaDetalleOrdenState();
}

class _PantallaDetalleOrdenState extends State<PantallaDetalleOrden> {
  late Future<DetalleOrden> datos = widget.repo.detalle(widget.id);
  void recargar() {
    if (mounted) {
      setState(() {
        datos = widget.repo.detalle(widget.id);
      });
    }
  }

  Future<void> cambiar(DetalleOrden d, EstadoLavado siguiente) async {
    if (siguiente == EstadoLavado.cancelado &&
        !await confirmar(
          context,
          'Cancelar orden',
          d.cobrado > 0
              ? 'Confirmá que devolviste ${formatearARS(d.cobrado)} por los mismos medios de pago. Se registrará la devolución en la caja abierta.'
              : 'Se cancela la orden. No se gastaron insumos.',
          accion: 'Cancelar orden',
        )) {
      return;
    }
    if (!mounted) return;
    if (siguiente == EstadoLavado.entregado &&
        d.saldo > 0 &&
        !await confirmar(
          context,
          'Entregar con saldo pendiente',
          'Todavía falta cobrar ${formatearARS(d.saldo)}. La deuda seguirá visible.',
          accion: 'Entregar',
        )) {
      return;
    }
    try {
      await widget.repo.cambiarEstado(widget.id, siguiente);
    } on ArgumentError catch (e) {
      if (siguiente != EstadoLavado.enLavado ||
          !'${e.message}'.startsWith('No alcanzan') ||
          !mounted) {
        rethrow;
      }
      if (!await confirmar(
        context,
        'Faltan insumos',
        'Revisá o contá el stock en Insumos. Si empezás igual, el stock podrá quedar negativo y quedará registrado.',
        accion: 'Empezar igual',
      )) {
        return;
      }
      await widget.repo.cambiarEstado(
        widget.id,
        siguiente,
        permitirFaltantes: true,
      );
    }
    recargar();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Orden #${widget.id}')),
    body: FutureBuilder(
      future: datos,
      builder: (context, s) {
        if (s.hasError) return Center(child: Text(errorLegible(s.error!)));
        if (!s.hasData) return const Center(child: CircularProgressIndicator());
        final d = s.data!;
        final o = d.orden;
        final siguiente = switch (d.estado) {
          EstadoLavado.recibido => EstadoLavado.enLavado,
          EstadoLavado.enLavado => EstadoLavado.listo,
          EstadoLavado.listo => EstadoLavado.entregado,
          _ => null,
        };
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              o.patente,
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              '${o.modelo} · ${TipoVehiculo.values.byName(o.tipo).etiqueta}',
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                Chip(label: Text(d.estado.etiqueta)),
                Chip(
                  label: Text(
                    d.saldo == 0 ? 'Pagado' : 'Saldo ${formatearARS(d.saldo)}',
                  ),
                ),
              ],
            ),
            if (o.cliente.isNotEmpty) Dato('Cliente', o.cliente),
            if (o.telefono.isNotEmpty) Dato('Teléfono', o.telefono),
            Dato('Ingreso', fechaHora(o.creada)),
            if (o.programada != null) Dato('Turno', fechaHora(o.programada!)),
            if (o.iniciada != null)
              Dato('Inicio del lavado', fechaHora(o.iniciada!)),
            if (o.terminada != null)
              Dato('Listo desde', fechaHora(o.terminada!)),
            if (o.entregada != null) Dato('Entregado', fechaHora(o.entregada!)),
            if (o.responsable.isNotEmpty) Dato('Responsable', o.responsable),
            if (o.notas.isNotEmpty) Bloque(child: Text(o.notas)),
            const SizedBox(height: 12),
            Bloque(
              child: Column(
                children: [
                  for (final l in d.lineas)
                    Dato(l.nombre, formatearARS(l.precio)),
                  const Divider(),
                  Dato('Total', formatearARS(d.total), grande: true),
                  Dato('Cobrado', formatearARS(d.cobrado)),
                  Dato(
                    'Pendiente',
                    d.estado == EstadoLavado.cancelado
                        ? 'Cancelado'
                        : formatearARS(d.saldo),
                  ),
                ],
              ),
            ),
            if (d.estado != EstadoLavado.cancelado) ...[
              if (siguiente != null)
                BotonAccion(
                  switch (siguiente) {
                    EstadoLavado.enLavado => 'Empezar lavado',
                    EstadoLavado.listo => 'Marcar listo',
                    _ => 'Entregar vehículo',
                  },
                  () => cambiar(d, siguiente),
                  icono: Icons.local_car_wash_outlined,
                ),
              const SizedBox(height: 10),
              if (d.saldo > 0)
                BotonAccion('Registrar pago o seña', () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => FormCobro(repo: widget.repo, detalle: d),
                    ),
                  );
                  recargar();
                }, icono: Icons.payments_outlined),
              if (d.estado != EstadoLavado.entregado)
                TextButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) =>
                            EditarOrden(repo: widget.repo, orden: o),
                      ),
                    );
                    recargar();
                  },
                  child: const Text(
                    'Editar observaciones, responsable o turno',
                  ),
                ),
              if (d.estado == EstadoLavado.recibido)
                TextButton(
                  onPressed: () async {
                    try {
                      await cambiar(d, EstadoLavado.cancelado);
                    } catch (e) {
                      if (context.mounted) aviso(context, errorLegible(e));
                    }
                  },
                  child: const Text('Cancelar antes de empezar'),
                ),
            ],
            const SizedBox(height: 16),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: const Text('Costos y margen estimado'),
              children: [
                Dato('Insumos', formatearARS(d.insumos)),
                Dato('Mano de obra', formatearARS(d.manoDeObra)),
                Dato('Margen del trabajo', formatearARS(d.margen)),
                const Text(
                  'Son los costos guardados al crear la orden. El margen todavía no descuenta alquiler, impuestos ni otros gastos del negocio.',
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Pagos y devoluciones',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (d.pagos.isEmpty) const Text('No hay pagos registrados.'),
            for (final p in d.pagos)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  '${p.medio == MedioPago.efectivo.name ? 'Efectivo' : 'Digital'} · ${formatearARS(p.monto)}',
                ),
                subtitle: Text(fechaHora(p.fecha)),
              ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () async {
                final negocio = await widget.repo.ajustes();
                await SharePlus.instance.share(
                  ShareParams(
                    text:
                        '${negocio.nombre}\nOrden #${o.id} · ${o.patente}\n${o.modelo}\n${d.lineas.map((l) => '${l.nombre}: ${formatearARS(l.precio)}').join('\n')}\nTotal: ${formatearARS(d.total)}\nCobrado: ${formatearARS(d.cobrado)}\n${d.estado == EstadoLavado.cancelado ? 'Orden cancelada' : 'Pendiente: ${formatearARS(d.saldo)}'}\n${d.estado.etiqueta}',
                  ),
                );
              },
              icon: const Icon(Icons.share_outlined),
              label: const Text('Compartir detalle'),
            ),
          ],
        );
      },
    ),
  );
}

class FormCobro extends StatefulWidget {
  const FormCobro({super.key, required this.repo, required this.detalle});
  final Repositorio repo;
  final DetalleOrden detalle;
  @override
  State<FormCobro> createState() => _FormCobroState();
}

class _FormCobroState extends State<FormCobro> {
  late final monto = TextEditingController(
    text: pesosCampo(widget.detalle.saldo),
  );
  MedioPago medio = MedioPago.efectivo;
  final operacion = nuevaOperacion();
  @override
  void dispose() {
    monto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Formulario(
    titulo: 'Registrar pago o seña',
    campos: [
      Text(
        widget.detalle.orden.patente,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      Dato('Pendiente', formatearARS(widget.detalle.saldo)),
      const SizedBox(height: 20),
      Campo(
        'Monto recibido (\$) *',
        monto,
        numerico: true,
        ayuda: 'Podés registrar una parte ahora y cobrar el resto después.',
      ),
      SegmentedButton<MedioPago>(
        segments: const [
          ButtonSegment(value: MedioPago.efectivo, label: Text('Efectivo')),
          ButtonSegment(value: MedioPago.digital, label: Text('Digital')),
        ],
        selected: {medio},
        onSelectionChanged: (s) => setState(() => medio = s.first),
      ),
      const SizedBox(height: 20),
      const Text(
        'Registrá únicamente dinero que ya recibiste. Transferencias, QR y Mercado Pago se comprueban en tu banco o billetera.',
      ),
    ],
    guardar: () async {
      await widget.repo.cobrar(
        widget.detalle.orden.id,
        monto: montoCampo(monto),
        medio: medio,
        operacion: operacion,
      );
      if (context.mounted) Navigator.pop(context, true);
    },
  );
}

class EditarOrden extends StatefulWidget {
  const EditarOrden({super.key, required this.repo, required this.orden});
  final Repositorio repo;
  final OrdenLavado orden;
  @override
  State<EditarOrden> createState() => _EditarOrdenState();
}

class _EditarOrdenState extends State<EditarOrden> {
  late final notas = TextEditingController(text: widget.orden.notas);
  late final responsable = TextEditingController(
    text: widget.orden.responsable,
  );
  late DateTime? programada = widget.orden.programada;
  @override
  void dispose() {
    notas.dispose();
    responsable.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Formulario(
    titulo: 'Editar orden #${widget.orden.id}',
    campos: [
      Campo('Responsable', responsable),
      Campo('Observaciones', notas, lineas: 4),
      OutlinedButton(
        onPressed: () async {
          final f = await elegirFecha(context, programada);
          if (f != null && mounted) setState(() => programada = f);
        },
        child: Text(
          programada == null ? 'Programar turno' : fechaHora(programada!),
        ),
      ),
      if (programada != null)
        TextButton(
          onPressed: () => setState(() => programada = null),
          child: const Text('Quitar turno'),
        ),
    ],
    guardar: () async {
      await widget.repo.editarOrden(
        widget.orden.id,
        notas: notas.text,
        responsable: responsable.text,
        programada: programada,
      );
      if (context.mounted) Navigator.pop(context, true);
    },
  );
}
