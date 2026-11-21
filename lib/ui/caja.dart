import 'package:flutter/material.dart';

import '../data/database.dart';
import '../data/repositorio.dart';
import '../domain/caja.dart';
import '../domain/dinero.dart';
import '../domain/lavadero.dart';
import 'comun.dart';

class PantallaCaja extends StatelessWidget {
  const PantallaCaja({
    super.key,
    required this.repo,
    required this.cajas,
    required this.resumen,
    required this.abrir,
  });
  final Repositorio repo;
  final List<SesionCaja> cajas;
  final ResumenCaja? resumen;
  final Future<void> Function(Widget) abrir;
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      if (resumen == null) ...[
        const Vacio(
          'Tu caja está cerrada',
          'Abrila cuando vayas a registrar cobros, señas o gastos. Podés cargar y trabajar órdenes sin abrirla.',
          icono: Icons.account_balance_wallet_outlined,
        ),
        FilledButton.icon(
          onPressed: () => abrir(
            AbrirCaja(repo: repo, anterior: cajas.isEmpty ? null : cajas.first),
          ),
          icon: const Icon(Icons.add),
          label: const Text('Abrir caja'),
        ),
      ] else ...[
        Text('Abierta ${fechaHora(resumen!.caja.abierta)}'),
        const SizedBox(height: 16),
        Bloque(
          color: const Color(0xFFE6EEFF),
          child: Column(
            children: [
              Dato(
                'Efectivo esperado',
                formatearARS(resumen!.esperado(MedioPago.efectivo)),
                grande: true,
              ),
              Dato(
                'Digital esperado',
                formatearARS(resumen!.esperado(MedioPago.digital)),
                grande: true,
              ),
            ],
          ),
        ),
        const Text(
          'Digital agrupa transferencias, QR y billeteras. El saldo se controla a mano.',
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () => abrir(MovimientoCajaForm(repo: repo)),
          icon: const Icon(Icons.swap_vert),
          label: const Text('Anotar gasto o ingreso'),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: () => abrir(CerrarCaja(repo: repo, resumen: resumen!)),
          icon: const Icon(Icons.lock_outline),
          label: const Text('Contar y cerrar caja'),
        ),
        const SizedBox(height: 24),
        Text(
          'Movimientos de esta caja',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        if (resumen!.movimientos.isEmpty)
          const Text('Todavía no hay movimientos.'),
        for (final m in resumen!.movimientos)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(m.concepto),
            subtitle: Text(
              '${m.medio == 'efectivo' ? 'Efectivo' : 'Digital'} · ${fechaHora(m.fecha)}',
            ),
            trailing: Text(formatearARS(m.monto)),
          ),
      ],
      const SizedBox(height: 24),
      Text('Cierres anteriores', style: Theme.of(context).textTheme.titleLarge),
      if (!cajas.any((c) => c.cerrada != null))
        const Text('Los cierres van a quedar guardados acá.'),
      for (final c in cajas.where((c) => c.cerrada != null))
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.lock_outline),
          title: Text(fechaHora(c.cerrada!)),
          subtitle: Text(
            'Contado: ${formatearARS(c.contadoEfectivo!)} efectivo · ${formatearARS(c.contadoDigital!)} digital',
          ),
          onTap: () => abrir(DetalleCierre(repo: repo, id: c.id)),
        ),
    ],
  );
}

class AbrirCaja extends StatefulWidget {
  const AbrirCaja({super.key, required this.repo, this.anterior});
  final Repositorio repo;
  final SesionCaja? anterior;
  @override
  State<AbrirCaja> createState() => _AbrirCajaState();
}

class _AbrirCajaState extends State<AbrirCaja> {
  late final efectivo = TextEditingController(
    text: pesosCampo(widget.anterior?.contadoEfectivo ?? 0),
  );
  late final digital = TextEditingController(
    text: pesosCampo(widget.anterior?.contadoDigital ?? 0),
  );
  @override
  void dispose() {
    efectivo.dispose();
    digital.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Formulario(
    titulo: 'Abrir caja',
    campos: [
      const Text(
        'Contá lo que tenés al empezar. Si ya hiciste un cierre, se precarga lo último que contaste.',
      ),
      const SizedBox(height: 20),
      Campo('Efectivo inicial (\$)', efectivo, numerico: true),
      Campo('Saldo digital inicial (\$)', digital, numerico: true),
    ],
    guardar: () async {
      await widget.repo.abrirCaja(
        efectivo: montoCampo(efectivo, cero: true),
        digital: montoCampo(digital, cero: true),
      );
      if (context.mounted) Navigator.pop(context, true);
    },
  );
}

class MovimientoCajaForm extends StatefulWidget {
  const MovimientoCajaForm({super.key, required this.repo});
  final Repositorio repo;
  @override
  State<MovimientoCajaForm> createState() => _MovimientoCajaFormState();
}

class _MovimientoCajaFormState extends State<MovimientoCajaForm> {
  final monto = TextEditingController();
  final concepto = TextEditingController();
  final operacion = nuevaOperacion();
  bool gasto = true;
  MedioPago medio = MedioPago.efectivo;
  @override
  void dispose() {
    monto.dispose();
    concepto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Formulario(
    titulo: 'Gasto o ingreso',
    campos: [
      SegmentedButton<bool>(
        segments: const [
          ButtonSegment(value: true, label: Text('Gasto')),
          ButtonSegment(value: false, label: Text('Ingreso')),
        ],
        selected: {gasto},
        onSelectionChanged: (s) => setState(() => gasto = s.first),
      ),
      const SizedBox(height: 20),
      Campo('Monto (\$) *', monto, numerico: true),
      Campo(
        'Motivo *',
        concepto,
        ayuda: 'Por ejemplo: compra de shampoo, luz o retiro personal.',
      ),
      SegmentedButton<MedioPago>(
        segments: const [
          ButtonSegment(value: MedioPago.efectivo, label: Text('Efectivo')),
          ButtonSegment(value: MedioPago.digital, label: Text('Digital')),
        ],
        selected: {medio},
        onSelectionChanged: (s) => setState(() => medio = s.first),
      ),
      const SizedBox(height: 16),
      const Text(
        'Los pagos de clientes se registran desde su orden para que el saldo quede actualizado.',
      ),
    ],
    guardar: () async {
      await widget.repo.movimiento(
        monto: montoCampo(monto),
        medio: medio,
        gasto: gasto,
        concepto: concepto.text,
        operacion: operacion,
      );
      if (context.mounted) Navigator.pop(context, true);
    },
  );
}

class CerrarCaja extends StatefulWidget {
  const CerrarCaja({super.key, required this.repo, required this.resumen});
  final Repositorio repo;
  final ResumenCaja resumen;
  @override
  State<CerrarCaja> createState() => _CerrarCajaState();
}

class _CerrarCajaState extends State<CerrarCaja> {
  final efectivo = TextEditingController();
  final digital = TextEditingController();
  ResumenCaja? revision;
  @override
  void dispose() {
    efectivo.dispose();
    digital.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Formulario(
    titulo: 'Contar y cerrar',
    accion: revision == null ? 'Revisar diferencias' : 'Confirmar cierre',
    campos: [
      const Text(
        'Primero contá el efectivo y revisá tu banco o billetera. Después compará con lo esperado.',
      ),
      const SizedBox(height: 20),
      Campo(
        'Efectivo contado (\$) *',
        efectivo,
        numerico: true,
        onChanged: (_) => setState(() => revision = null),
      ),
      Campo(
        'Saldo digital contado (\$) *',
        digital,
        numerico: true,
        onChanged: (_) => setState(() => revision = null),
      ),
      if (revision != null)
        Bloque(
          child: Column(
            children: [
              Dato(
                'Efectivo esperado',
                formatearARS(revision!.esperado(MedioPago.efectivo)),
              ),
              Dato(
                'Diferencia efectivo',
                formatearARS(
                  diferenciaArqueo(
                    contadoCentavos: montoCampo(efectivo, cero: true),
                    esperadoCentavos: revision!.esperado(MedioPago.efectivo),
                  ),
                ),
              ),
              Dato(
                'Digital esperado',
                formatearARS(revision!.esperado(MedioPago.digital)),
              ),
              Dato(
                'Diferencia digital',
                formatearARS(
                  diferenciaArqueo(
                    contadoCentavos: montoCampo(digital, cero: true),
                    esperadoCentavos: revision!.esperado(MedioPago.digital),
                  ),
                ),
              ),
              const Text(
                'Negativo: falta plata. Positivo: sobra. Si falta registrar un movimiento, volvé a Caja antes de cerrar.',
              ),
            ],
          ),
        ),
    ],
    guardar: () async {
      final e = montoCampo(efectivo, cero: true);
      final d = montoCampo(digital, cero: true);
      if (efectivo.text.trim().isEmpty || digital.text.trim().isEmpty) {
        throw ArgumentError('Completá los dos conteos, aunque sean cero.');
      }
      final actual = await widget.repo.resumenCaja(widget.resumen.caja.id);
      if (revision == null ||
          revision!.movimientos.length != actual.movimientos.length) {
        setState(() => revision = actual);
        return;
      }
      await widget.repo.cerrarCaja(actual.caja.id, efectivo: e, digital: d);
      if (context.mounted) Navigator.pop(context, true);
    },
  );
}

class DetalleCierre extends StatelessWidget {
  const DetalleCierre({super.key, required this.repo, required this.id});
  final Repositorio repo;
  final int id;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Caja #$id')),
    body: FutureBuilder(
      future: repo.resumenCaja(id),
      builder: (context, s) {
        if (s.hasError) return Center(child: Text(errorLegible(s.error!)));
        if (!s.hasData) return const Center(child: CircularProgressIndicator());
        final r = s.data!;
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Dato('Apertura', fechaHora(r.caja.abierta)),
            if (r.caja.cerrada != null)
              Dato('Cierre', fechaHora(r.caja.cerrada!)),
            for (final medio in MedioPago.values)
              Bloque(
                child: Column(
                  children: [
                    Dato(
                      medio == MedioPago.efectivo
                          ? 'Efectivo esperado'
                          : 'Digital esperado',
                      formatearARS(r.esperado(medio)),
                    ),
                    Dato(
                      'Contado',
                      formatearARS(
                        (medio == MedioPago.efectivo
                                ? r.caja.contadoEfectivo
                                : r.caja.contadoDigital) ??
                            0,
                      ),
                    ),
                    Dato(
                      'Diferencia',
                      formatearARS(
                        diferenciaArqueo(
                          contadoCentavos:
                              (medio == MedioPago.efectivo
                                  ? r.caja.contadoEfectivo
                                  : r.caja.contadoDigital) ??
                              0,
                          esperadoCentavos: r.esperado(medio),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            for (final m in r.movimientos)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(m.concepto),
                subtitle: Text('${m.medio} · ${fechaHora(m.fecha)}'),
                trailing: Text(formatearARS(m.monto)),
              ),
          ],
        );
      },
    ),
  );
}
