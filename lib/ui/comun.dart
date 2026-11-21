import 'package:flutter/material.dart';

import '../domain/dinero.dart';
import 'diseno.dart';

String fechaHora(DateTime fecha) =>
    '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year} · ${fecha.hour.toString().padLeft(2, '0')}:${fecha.minute.toString().padLeft(2, '0')}';
String pesosCampo(int centavos) =>
    '${centavos ~/ 100}${centavos % 100 == 0 ? '' : ',${(centavos % 100).toString().padLeft(2, '0')}'}';
int montoCampo(TextEditingController c, {bool cero = false}) {
  final monto = c.text.trim().isEmpty && cero ? 0 : parsearARS(c.text);
  if (monto < 0 || (!cero && monto == 0)) {
    throw ArgumentError('Revisá los montos: deben ser positivos.');
  }
  return monto;
}

String errorLegible(Object error) => error is ArgumentError
    ? '${error.message}'
    : error is FormatException
    ? error.message
    : 'No se pudo guardar. Tus datos siguen en el celular. Detalle: $error';

void aviso(BuildContext context, String mensaje) => ScaffoldMessenger.of(
  context,
).showSnackBar(SnackBar(content: Text(mensaje)));

Future<bool> confirmar(
  BuildContext context,
  String titulo,
  String texto, {
  String accion = 'Confirmar',
}) async =>
    await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(titulo),
        content: Text(texto),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Volver'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(accion),
          ),
        ],
      ),
    ) ??
    false;

class BotonAccion extends StatefulWidget {
  const BotonAccion(this.texto, this.accion, {super.key, this.icono});
  final String texto;
  final Future<void> Function()? accion;
  final IconData? icono;
  @override
  State<BotonAccion> createState() => _BotonAccionState();
}

class _BotonAccionState extends State<BotonAccion> {
  bool ocupado = false;
  bool presionado = false;
  @override
  Widget build(BuildContext context) => Listener(
    onPointerDown: (_) {
      if (!ocupado && widget.accion != null) setState(() => presionado = true);
    },
    onPointerUp: (_) => setState(() => presionado = false),
    onPointerCancel: (_) => setState(() => presionado = false),
    child: AnimatedScale(
      scale: presionado ? .975 : 1,
      duration: movimiento(context, 130),
      curve: Curves.easeOutCubic,
      child: FilledButton.icon(
        onPressed: ocupado || widget.accion == null
            ? null
            : () async {
                setState(() => ocupado = true);
                try {
                  await widget.accion!();
                } catch (e) {
                  if (context.mounted) aviso(context, errorLegible(e));
                } finally {
                  if (mounted) setState(() => ocupado = false);
                }
              },
        icon: ocupado
            ? const SizedBox.square(
                dimension: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(widget.icono ?? Icons.check_rounded),
        label: Text(ocupado ? 'Guardando…' : widget.texto),
      ),
    ),
  );
}

class Campo extends StatelessWidget {
  const Campo(
    this.titulo,
    this.controller, {
    super.key,
    this.numerico = false,
    this.lineas = 1,
    this.onChanged,
    this.soloLectura = false,
    this.ayuda,
  });
  final String titulo;
  final TextEditingController controller;
  final bool numerico;
  final int lineas;
  final bool soloLectura;
  final String? ayuda;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: TextField(
      controller: controller,
      readOnly: soloLectura,
      onChanged: onChanged,
      maxLines: lineas,
      textCapitalization: numerico
          ? TextCapitalization.none
          : TextCapitalization.sentences,
      keyboardType: numerico
          ? const TextInputType.numberWithOptions(decimal: true)
          : lineas > 1
          ? TextInputType.multiline
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: titulo,
        helperText: ayuda,
        helperMaxLines: 3,
      ),
    ),
  );
}

class Formulario extends StatelessWidget {
  const Formulario({
    super.key,
    required this.titulo,
    required this.campos,
    required this.guardar,
    this.accion = 'Guardar',
  });
  final String titulo;
  final List<Widget> campos;
  final Future<void> Function() guardar;
  final String accion;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(titulo)),
    body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: campos,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            child: SizedBox(
              width: double.infinity,
              child: BotonAccion(accion, guardar),
            ),
          ),
        ],
      ),
    ),
  );
}

class Bloque extends StatelessWidget {
  const Bloque({super.key, required this.child, this.color});
  final Widget child;
  final Color? color;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Material(
      color: color ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: borde),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(padding: const EdgeInsets.all(18), child: child),
    ),
  );
}

class Vacio extends StatelessWidget {
  const Vacio(
    this.titulo,
    this.texto, {
    super.key,
    this.icono = Icons.local_car_wash_outlined,
  });
  final String titulo;
  final String texto;
  final IconData icono;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 36),
    child: Column(
      children: [
        Icon(icono, size: 48, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 16),
        Text(
          titulo,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(texto, textAlign: TextAlign.center),
      ],
    ),
  );
}

class Dato extends StatelessWidget {
  const Dato(this.nombre, this.valor, {super.key, this.grande = false});
  final String nombre;
  final String valor;
  final bool grande;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(nombre)),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            valor,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: grande ? 22 : 15,
            ),
          ),
        ),
      ],
    ),
  );
}
