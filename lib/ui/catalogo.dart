import 'package:flutter/material.dart';

import '../data/database.dart';
import '../data/repositorio.dart';
import '../domain/dinero.dart';
import '../domain/lavadero.dart';
import '../domain/servicios.dart';
import 'comun.dart';

class Catalogo {
  Catalogo(
    this.servicios,
    this.insumos,
    this.tarifas,
    this.recetas,
    this.valorHora,
  );
  final List<Servicio> servicios;
  final List<Insumo> insumos;
  final List<Tarifa> tarifas;
  final List<Receta> recetas;
  final int valorHora;
  static Future<Catalogo> cargar(Repositorio repo) async => Catalogo(
    await repo.servicios(todos: true),
    await repo.insumos(todos: true),
    await repo.tarifas(),
    await repo.recetas(),
    (await repo.ajustes()).valorHora,
  );
  int? precio(int servicioId, TipoVehiculo tipo) {
    for (final t in tarifas) {
      if (t.servicioId == servicioId && t.tipo == tipo.name) return t.precio;
    }
    return null;
  }

  int? precioGeneral(int servicioId) {
    final lista = tarifas.where((t) => t.servicioId == servicioId).toList();
    return lista.length == TipoVehiculo.values.length &&
            lista.map((t) => t.precio).toSet().length == 1
        ? lista.first.precio
        : null;
  }

  List<UsoDeInsumo> usos(int servicioId) => [
    for (final r in recetas.where((r) => r.servicioId == servicioId))
      UsoDeInsumo(
        insumo: insumoParaCalculo(
          insumos.firstWhere((i) => i.id == r.insumoId),
        ),
        cantidadMilesimas: r.cantidad,
      ),
  ];
  CostoDeServicio costo(Servicio s) => costoDeServicio(
    receta: usos(s.id),
    duracionMinutos: s.duracion,
    valorHoraCentavos: s.manoDeObra ? valorHora : null,
  );
}

class PantallaCatalogo extends StatefulWidget {
  const PantallaCatalogo({
    super.key,
    required this.repo,
    required this.catalogo,
    required this.abrir,
  });
  final Repositorio repo;
  final Catalogo catalogo;
  final Future<void> Function(Widget) abrir;
  @override
  State<PantallaCatalogo> createState() => _PantallaCatalogoState();
}

class _PantallaCatalogoState extends State<PantallaCatalogo> {
  int tab = 0;
  bool verInactivos = false;
  @override
  Widget build(BuildContext context) {
    final c = widget.catalogo;
    final servicios = c.servicios
        .where((s) => verInactivos || s.activo)
        .toList();
    final insumos = c.insumos.where((i) => verInactivos || i.activo).toList()
      ..sort((a, b) => (a.stock - a.minimo).compareTo(b.stock - b.minimo));
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        SegmentedButton<int>(
          segments: const [
            ButtonSegment(value: 0, label: Text('Servicios')),
            ButtonSegment(value: 1, label: Text('Insumos')),
          ],
          selected: {tab},
          onSelectionChanged: (s) => setState(() => tab = s.first),
        ),
        const SizedBox(height: 18),
        FilledButton.icon(
          onPressed: () => widget.abrir(
            tab == 0
                ? EditorServicio(repo: widget.repo, catalogo: c)
                : EditorInsumo(repo: widget.repo),
          ),
          icon: const Icon(Icons.add),
          label: Text(tab == 0 ? 'Agregar servicio' : 'Cargar insumo'),
        ),
        if ((tab == 0
            ? c.servicios.any((s) => !s.activo)
            : c.insumos.any((i) => !i.activo)))
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: const Text('Mostrar dados de baja'),
            value: verInactivos,
            onChanged: (v) => setState(() => verInactivos = v),
          ),
        if (tab == 0) ...[
          if (servicios.isEmpty)
            const Vacio(
              'Tus servicios, a tu manera',
              'Cargá lavado exterior, completo, tapizados o los extras que ofrecés. Los precios los ponés vos.',
            ),
          for (final s in servicios)
            Bloque(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${s.nombre}${s.activo ? '' : ' · de baja'}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Editar ${s.nombre}',
                        onPressed: () => widget.abrir(
                          EditorServicio(
                            repo: widget.repo,
                            catalogo: c,
                            servicio: s,
                          ),
                        ),
                        icon: const Icon(Icons.edit_outlined),
                      ),
                    ],
                  ),
                  if (c.costo(s).totalCentavos > 0 || c.usos(s.id).isNotEmpty)
                    Text(
                      '${s.duracion} min · costo estimado ${formatearARS(c.costo(s).totalCentavos)}',
                    ),
                  if (alcanzaPara(c.usos(s.id)) case final n?)
                    Text('Los insumos alcanzan para $n servicios'),
                  const SizedBox(height: 8),
                  if (c.precioGeneral(s.id) case final precio?)
                    Text(
                      formatearARS(precio),
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  else
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        for (final t in TipoVehiculo.values)
                          if (c.precio(s.id, t) case final p?)
                            Chip(
                              label: Text('${t.etiqueta} ${formatearARS(p)}'),
                            ),
                      ],
                    ),
                ],
              ),
            ),
        ] else ...[
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Las compras suman stock. Si ya las pagaste, registrá también el gasto en Caja.',
            ),
          ),
          if (insumos.isEmpty)
            const Vacio(
              'Sabé qué tenés y cuánto rinde',
              'Cargá tus bidones, productos de limpieza y otros materiales.',
            ),
          for (final i in insumos)
            Bloque(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${i.nombre}${i.activo ? '' : ' · de baja'}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Editar ${i.nombre}',
                        onPressed: () => widget.abrir(
                          EditorInsumo(repo: widget.repo, insumo: i),
                        ),
                        icon: const Icon(Icons.edit_outlined),
                      ),
                    ],
                  ),
                  Text(
                    '${textoCantidadDeInsumo(i.stock, UnidadInsumo.desdeClave(i.unidad)!)} disponibles',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Envase de ${textoCantidadDeInsumo(i.contenido, UnidadInsumo.desdeClave(i.unidad)!)} · ${formatearARS(i.costoEnvase)}',
                  ),
                  if (i.stock <= i.minimo)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'Revisar reposición',
                        style: TextStyle(
                          color: Color(0xFFAC4A00),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  Wrap(
                    spacing: 8,
                    children: [
                      TextButton(
                        onPressed: () => widget.abrir(
                          MovimientoInsumoForm(
                            repo: widget.repo,
                            insumo: i,
                            compra: true,
                          ),
                        ),
                        child: const Text('Cargar compra'),
                      ),
                      TextButton(
                        onPressed: () => widget.abrir(
                          MovimientoInsumoForm(
                            repo: widget.repo,
                            insumo: i,
                            compra: false,
                          ),
                        ),
                        child: const Text('Contar stock'),
                      ),
                      TextButton(
                        onPressed: () => widget.abrir(
                          HistorialInsumo(repo: widget.repo, insumo: i),
                        ),
                        child: const Text('Movimientos'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ],
    );
  }
}

class EditorInsumo extends StatefulWidget {
  const EditorInsumo({super.key, required this.repo, this.insumo});
  final Repositorio repo;
  final Insumo? insumo;
  @override
  State<EditorInsumo> createState() => _EditorInsumoState();
}

class _EditorInsumoState extends State<EditorInsumo> {
  late final nombre = TextEditingController(text: widget.insumo?.nombre);
  late final contenido = TextEditingController(
    text: widget.insumo == null
        ? ''
        : textoDeMilesimas(widget.insumo!.contenido),
  );
  late final costo = TextEditingController(
    text: widget.insumo == null ? '' : pesosCampo(widget.insumo!.costoEnvase),
  );
  late final minimo = TextEditingController(
    text: textoDeMilesimas(widget.insumo?.minimo ?? 0),
  );
  final stock = TextEditingController(text: '0');
  late UnidadInsumo unidad =
      UnidadInsumo.desdeClave(widget.insumo?.unidad) ?? UnidadInsumo.ml;
  late bool activo = widget.insumo?.activo ?? true;
  @override
  void dispose() {
    for (final c in [nombre, contenido, costo, minimo, stock]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Formulario(
    titulo: widget.insumo == null ? 'Nuevo insumo' : 'Editar insumo',
    campos: [
      Campo('Nombre *', nombre),
      DropdownButtonFormField<UnidadInsumo>(
        initialValue: unidad,
        decoration: const InputDecoration(labelText: 'Unidad de uso'),
        items: [
          for (final u in UnidadInsumo.values)
            DropdownMenuItem(value: u, child: Text(u.nombre)),
        ],
        onChanged: widget.insumo == null
            ? (u) => setState(() => unidad = u!)
            : null,
      ),
      const SizedBox(height: 16),
      Campo(
        'Contenido de cada envase (${unidad.clave}) *',
        contenido,
        numerico: true,
        ayuda: 'Un bidón de 5 litros contiene 5000 ml.',
      ),
      Campo('Costo del envase (\$) *', costo, numerico: true),
      ExpansionTile(
        title: const Text('Más opciones'),
        tilePadding: EdgeInsets.zero,
        children: [
          Campo('Avisar al llegar a (${unidad.clave})', minimo, numerico: true),
          if (widget.insumo == null)
            Campo(
              'Cantidad que ya tenés (${unidad.clave})',
              stock,
              numerico: true,
            ),
          if (widget.insumo != null)
            SwitchListTile(
              title: const Text('Activo'),
              value: activo,
              onChanged: (v) => setState(() => activo = v),
            ),
        ],
      ),
    ],
    guardar: () async {
      final cant = milesimasDesdeTexto(contenido.text);
      final min = milesimasDesdeTexto(minimo.text);
      final inicial = milesimasDesdeTexto(stock.text);
      if (cant == null || min == null || inicial == null) {
        throw ArgumentError('Revisá las cantidades.');
      }
      await widget.repo.guardarInsumo(
        id: widget.insumo?.id,
        nombre: nombre.text,
        unidad: unidad,
        contenido: cant,
        costoEnvase: montoCampo(costo, cero: true),
        minimo: min,
        stockInicial: inicial,
        activo: activo,
      );
      if (context.mounted) Navigator.pop(context, true);
    },
  );
}

class MovimientoInsumoForm extends StatefulWidget {
  const MovimientoInsumoForm({
    super.key,
    required this.repo,
    required this.insumo,
    required this.compra,
  });
  final Repositorio repo;
  final Insumo insumo;
  final bool compra;
  @override
  State<MovimientoInsumoForm> createState() => _MovimientoInsumoFormState();
}

class _MovimientoInsumoFormState extends State<MovimientoInsumoForm> {
  final cantidad = TextEditingController();
  late final costo = TextEditingController(
    text: pesosCampo(widget.insumo.costoEnvase),
  );
  @override
  void dispose() {
    cantidad.dispose();
    costo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Formulario(
    titulo: widget.compra ? 'Cargar compra' : 'Contar stock',
    campos: [
      Text(
        widget.insumo.nombre,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 20),
      Campo(
        widget.compra
            ? 'Cantidad de envases *'
            : 'Cantidad contada (${widget.insumo.unidad}) *',
        cantidad,
        numerico: true,
      ),
      if (widget.compra)
        Campo('Costo actual de cada envase (\$) *', costo, numerico: true),
      Text(
        widget.compra
            ? 'El costo se actualiza para los próximos lavados. Las órdenes ya creadas conservan sus costos.'
            : 'Se guarda el ajuste con su fecha y el stock anterior.',
      ),
    ],
    guardar: () async {
      if (widget.compra) {
        final n = int.tryParse(cantidad.text);
        if (n == null || n <= 0) {
          throw ArgumentError('Ingresá una cantidad entera de envases.');
        }
        await widget.repo.comprarInsumo(
          widget.insumo.id,
          envases: n,
          costoEnvase: montoCampo(costo, cero: true),
        );
      } else {
        final n = milesimasDesdeTexto(cantidad.text);
        if (n == null) throw ArgumentError('Ingresá lo que contaste.');
        await widget.repo.contarInsumo(widget.insumo.id, n);
      }
      if (context.mounted) Navigator.pop(context, true);
    },
  );
}

class HistorialInsumo extends StatelessWidget {
  const HistorialInsumo({super.key, required this.repo, required this.insumo});
  final Repositorio repo;
  final Insumo insumo;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(insumo.nombre)),
    body: FutureBuilder(
      future: repo.historialInsumo(insumo.id),
      builder: (context, s) {
        if (s.hasError) return Center(child: Text(errorLegible(s.error!)));
        if (!s.hasData) return const Center(child: CircularProgressIndicator());
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            if (s.data!.isEmpty)
              const Vacio(
                'Sin movimientos',
                'Las compras, los conteos y los lavados van a aparecer acá.',
              ),
            for (final m in s.data!)
              Bloque(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      m.motivo,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(fechaHora(m.fecha)),
                    Text(
                      '${textoDeMilesimas(m.anterior)} → ${textoDeMilesimas(m.posterior)} ${insumo.unidad}',
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    ),
  );
}

class EditorServicio extends StatefulWidget {
  const EditorServicio({
    super.key,
    required this.repo,
    required this.catalogo,
    this.servicio,
  });
  final Repositorio repo;
  final Catalogo catalogo;
  final Servicio? servicio;
  @override
  State<EditorServicio> createState() => _EditorServicioState();
}

class _EditorServicioState extends State<EditorServicio> {
  late final nombre = TextEditingController(text: widget.servicio?.nombre);
  late final precio = TextEditingController(
    text: widget.servicio == null
        ? ''
        : pesosCampo(
            widget.catalogo.tarifas
                .firstWhere((t) => t.servicioId == widget.servicio!.id)
                .precio,
          ),
  );
  bool avanzado = false;
  late bool preciosDistintos =
      widget.servicio != null &&
      widget.catalogo.precioGeneral(widget.servicio!.id) == null;
  late final duracion = TextEditingController(
    text: '${widget.servicio?.duracion ?? 30}',
  );
  late final margen = TextEditingController(
    text: '${(widget.servicio?.gananciaBuscada ?? 6000) ~/ 100}',
  );
  late final precios = {
    for (final t in TipoVehiculo.values)
      t: TextEditingController(
        text:
            widget.servicio == null ||
                widget.catalogo.precio(widget.servicio!.id, t) == null
            ? ''
            : pesosCampo(widget.catalogo.precio(widget.servicio!.id, t)!),
      ),
  };
  late final cantidades = {
    for (final r in widget.catalogo.recetas.where(
      (r) => r.servicioId == widget.servicio?.id,
    ))
      r.insumoId: TextEditingController(text: textoDeMilesimas(r.cantidad)),
  };
  late bool manoDeObra = widget.servicio?.manoDeObra ?? false;
  late bool activo = widget.servicio?.activo ?? true;
  @override
  void dispose() {
    for (final c in [
      nombre,
      precio,
      duracion,
      margen,
      ...precios.values,
      ...cantidades.values,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final usos = <UsoDeInsumo>[];
    for (final e in cantidades.entries) {
      final i = widget.catalogo.insumos.firstWhere((i) => i.id == e.key);
      usos.add(
        UsoDeInsumo(
          insumo: insumoParaCalculo(i),
          cantidadMilesimas: milesimasDesdeTexto(e.value.text) ?? 0,
        ),
      );
    }
    final costo = costoDeServicio(
      receta: usos,
      duracionMinutos: (int.tryParse(duracion.text) ?? 0).clamp(0, 100000),
      valorHoraCentavos: manoDeObra ? widget.catalogo.valorHora : null,
    );
    final bp = (int.tryParse(margen.text) ?? 60) * 100;
    final sugerido = bp >= 0 && bp < 10000
        ? precioSugeridoCentavos(
            costoCentavos: costo.totalCentavos,
            gananciaBuscadaBp: bp,
          )
        : 0;
    return Formulario(
      titulo: widget.servicio == null ? 'Nuevo servicio' : 'Editar servicio',
      campos: [
        Campo(
          'Nombre *',
          nombre,
          ayuda: 'Por ejemplo: lavado completo, encerado o tapizados.',
        ),
        if (!preciosDistintos)
          Campo(
            r'Precio ($) *',
            precio,
            numerico: true,
            ayuda: 'El mismo para todos los vehículos.',
          ),
        if (preciosDistintos)
          Wrap(
            spacing: 8,
            children: [
              for (final t in TipoVehiculo.values)
                if (precios[t]!.text.isNotEmpty)
                  Chip(label: Text('${t.etiqueta}: \$${precios[t]!.text}')),
            ],
          ),
        TextButton.icon(
          onPressed: () => setState(() => avanzado = !avanzado),
          icon: Icon(avanzado ? Icons.expand_less : Icons.expand_more),
          label: Text(avanzado ? 'Menos opciones' : 'Más opciones'),
        ),
        if (avanzado) ...[
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Precios diferentes por vehículo'),
            value: preciosDistintos,
            onChanged: (v) => setState(() {
              if (v) {
                for (final c in precios.values) {
                  if (c.text.isEmpty) c.text = precio.text;
                }
              } else {
                // Elegir un precio único es explícito; conserva las tarifas mientras se edita.
                if (precio.text.isEmpty) {
                  precio.text = precios.values
                      .firstWhere(
                        (c) => c.text.isNotEmpty,
                        orElse: () => precios.values.first,
                      )
                      .text;
                }
              }
              preciosDistintos = v;
            }),
          ),
          if (preciosDistintos) ...[
            const Text('Dejá vacío un vehículo que no atendés.'),
            const SizedBox(height: 16),
            for (final t in TipoVehiculo.values)
              Campo('${t.etiqueta} (\$)', precios[t]!, numerico: true),
          ],
          Campo(
            'Duración en minutos *',
            duracion,
            numerico: true,
            onChanged: (_) => setState(() {}),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Incluir mano de obra'),
            subtitle: Text(
              'Hora de trabajo: ${formatearARS(widget.catalogo.valorHora)}. Se cambia en Ajustes.',
            ),
            value: manoDeObra,
            onChanged: (v) => setState(() => manoDeObra = v),
          ),
          const SizedBox(height: 16),
          Text(
            'Insumos por servicio',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          for (final i in widget.catalogo.insumos.where(
            (i) => i.activo || cantidades.containsKey(i.id),
          )) ...[
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('${i.nombre} (${i.unidad})'),
              value: cantidades.containsKey(i.id),
              onChanged: (v) => setState(() {
                if (v!) {
                  cantidades[i.id] = TextEditingController();
                } else {
                  cantidades.remove(i.id)?.dispose();
                }
              }),
            ),
            if (cantidades[i.id] case final ctrl?)
              Campo(
                'Cantidad usada (${i.unidad}) *',
                ctrl,
                numerico: true,
                onChanged: (_) => setState(() {}),
              ),
          ],
          if (widget.catalogo.insumos.isEmpty)
            const Text(
              'Podés agregar la receta después de cargar tus insumos.',
            ),
          const SizedBox(height: 16),
          Bloque(
            child: Column(
              children: [
                Dato('Insumos por lavado', formatearARS(costo.insumosCentavos)),
                Dato(
                  'Mano de obra estimada',
                  formatearARS(costo.manoDeObraCentavos),
                ),
                Dato(
                  'Costo estimado',
                  formatearARS(costo.totalCentavos),
                  grande: true,
                ),
                if (alcanzaPara(usos) case final n?)
                  Dato('Alcanza para', '$n servicios'),
              ],
            ),
          ),
          Campo(
            'Margen buscado (%)',
            margen,
            numerico: true,
            onChanged: (_) => setState(() {}),
          ),
          Text(
            'Precio sugerido: ${formatearARS(sugerido)}. No incluye gastos fijos ni impuestos.',
          ),

          if (widget.servicio != null)
            SwitchListTile(
              title: const Text('Se ofrece actualmente'),
              value: activo,
              onChanged: (v) => setState(() => activo = v),
            ),
        ],
      ],
      guardar: () async {
        final min = int.tryParse(duracion.text);
        if (min == null || min <= 0) throw ArgumentError('Revisá la duración.');
        final pct = int.tryParse(margen.text);
        if (pct == null || pct < 0 || pct >= 100) {
          throw ArgumentError('El margen va de 0 a 99 %.');
        }
        final receta = <UsoReceta>[];
        for (final e in cantidades.entries) {
          final n = milesimasDesdeTexto(e.value.text);
          if (n == null || n <= 0) {
            throw ArgumentError(
              'Completá las cantidades de los insumos seleccionados.',
            );
          }
          receta.add((insumoId: e.key, cantidad: n));
        }
        await widget.repo.guardarServicio(
          id: widget.servicio?.id,
          nombre: nombre.text,
          duracion: min,
          manoDeObra: manoDeObra,
          precios: preciosDistintos
              ? {
                  for (final e in precios.entries)
                    if (e.value.text.trim().isNotEmpty)
                      e.key: montoCampo(e.value),
                }
              : {for (final t in TipoVehiculo.values) t: montoCampo(precio)},
          receta: receta,
          activo: activo,
          gananciaBuscada: pct * 100,
        );
        if (context.mounted) Navigator.pop(context, true);
      },
    );
  }
}
