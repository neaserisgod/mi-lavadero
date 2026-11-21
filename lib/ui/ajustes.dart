import 'actualizaciones.dart';
import 'dart:io';
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../data/database.dart';
import '../data/repositorio.dart';
import '../data/respaldo.dart';
import 'comun.dart';

class PantallaAjustes extends StatefulWidget {
  const PantallaAjustes({super.key, required this.repo, required this.ajustes});
  final Repositorio repo;
  final Ajuste ajustes;
  @override
  State<PantallaAjustes> createState() => _PantallaAjustesState();
}

class _PantallaAjustesState extends State<PantallaAjustes> {
  late final nombre = TextEditingController(text: widget.ajustes.nombre);
  late final alias = TextEditingController(text: widget.ajustes.alias);
  late final hora = TextEditingController(
    text: pesosCampo(widget.ajustes.valorHora),
  );
  @override
  void dispose() {
    nombre.dispose();
    alias.dispose();
    hora.dispose();
    super.dispose();
  }

  Future<File> _copia(String prefijo) async {
    final directorio = Directory(
      p.join((await getApplicationDocumentsDirectory()).path, 'respaldos'),
    );
    await directorio.create(recursive: true);
    final fecha = DateTime.now().toIso8601String().replaceAll(':', '-');
    final archivo = File(
      p.join(directorio.path, '$prefijo-$fecha.lavadero.json'),
    );
    await archivo.writeAsString(
      await Respaldo(widget.repo.db).exportar(),
      flush: true,
    );
    return archivo;
  }

  Future<void> _exportar() async {
    final archivo = await _copia('mi-lavadero');
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(archivo.path)],
        subject: 'Respaldo de Mi Lavadero',
      ),
    );
    if (mounted) {
      aviso(
        context,
        'Respaldo creado. Guardalo fuera del celular para poder recuperarlo.',
      );
    }
  }

  Future<void> _restaurar() async {
    final elegido = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (elegido == null || !mounted) return;
    final archivo = elegido;
    if ((await archivo.length() ?? 0) > 50 * 1024 * 1024) {
      throw const FormatException('El respaldo supera los 50 MB.');
    }
    final texto = utf8.decode(await archivo.readAsBytes());
    await _restaurarTexto(texto, archivo.name);
  }

  Future<void> _restaurarTexto(String texto, String nombre) async {
    if (!mounted ||
        !await confirmar(
          context,
          'Restaurar respaldo',
          'Se reemplazarán los datos de esta app por los de $nombre. Antes se guardará una copia de lo que tenés ahora.',
          accion: 'Reemplazar datos',
        )) {
      return;
    }
    final anterior = await _copia('antes-de-restaurar');
    await Respaldo(widget.repo.db).restaurar(texto);
    if (!mounted) return;
    aviso(
      context,
      'Datos restaurados. La copia anterior se guardó en ${p.basename(anterior.path)}.',
    );
    Navigator.pop(context, true);
  }

  Future<void> _verCopias() async {
    final directorio = Directory(
      p.join((await getApplicationDocumentsDirectory()).path, 'respaldos'),
    );
    final archivos = await directorio.exists()
        ? await directorio
              .list()
              .where((f) => f is File && f.path.endsWith('.lavadero.json'))
              .cast<File>()
              .toList()
        : <File>[];
    archivos.sort((a, b) => b.path.compareTo(a.path));
    if (!mounted) return;
    final elegido = await showModalBottomSheet<File>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(ctx).height * 0.6,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Respaldos guardados',
                style: Theme.of(ctx).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              const Text(
                'Tocá una copia para restaurarla. Usá Compartir para guardarla fuera del celular.',
              ),
              if (archivos.isEmpty)
                const Vacio(
                  'Todavía no hay copias',
                  'Exportá tu primer respaldo desde Ajustes.',
                ),
              for (final f in archivos)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(p.basename(f.path)),
                  onTap: () => Navigator.pop(ctx, f),
                  trailing: IconButton(
                    tooltip: 'Compartir copia',
                    icon: const Icon(Icons.share_outlined),
                    onPressed: () async {
                      try {
                        await SharePlus.instance.share(
                          ShareParams(files: [XFile(f.path)]),
                        );
                      } catch (e) {
                        if (ctx.mounted) aviso(ctx, errorLegible(e));
                      }
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
    if (elegido != null) {
      await _restaurarTexto(
        await elegido.readAsString(),
        p.basename(elegido.path),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Formulario(
    titulo: 'Mi lavadero',
    campos: [
      Campo('Nombre de tu lavadero *', nombre),
      Campo('Alias para cobros', alias),
      Campo(
        'Valor de tu hora de trabajo (\$)',
        hora,
        numerico: true,
        ayuda:
            'Se usa para estimar mano de obra. No genera un gasto de caja automáticamente.',
      ),
      const SizedBox(height: 8),
      Text('Tus datos', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 8),
      const Text(
        'Se guardan en este celular. Exportá un respaldo y guardalo en Drive, una computadora o donde prefieras antes de cambiar de equipo o desinstalar.',
      ),
      const SizedBox(height: 16),
      BotonAccion('Exportar respaldo', _exportar, icono: Icons.backup_outlined),
      const SizedBox(height: 10),
      BotonAccion(
        'Restaurar respaldo',
        _restaurar,
        icono: Icons.restore_outlined,
      ),
      const SizedBox(height: 10),
      BotonAccion(
        'Ver respaldos guardados',
        _verCopias,
        icono: Icons.folder_outlined,
      ),
      const SizedBox(height: 20),
      BotonAccion(
        'Buscar actualizaciones',
        () => Actualizador.revisar(context, 'mi-lavadero', manual: true),
        icono: Icons.system_update_alt_rounded,
      ),
      const VersionInstalada(),
      const Text(
        'App personal, sin cuenta ni abono. No necesita internet para trabajar.',
      ),
    ],
    guardar: () async {
      await widget.repo.guardarAjustes(
        nombre: nombre.text,
        alias: alias.text,
        valorHora: montoCampo(hora, cero: true),
      );
      if (context.mounted) Navigator.pop(context, true);
    },
  );
}
