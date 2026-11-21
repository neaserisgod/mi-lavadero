// Insumos en milésimas de ml, g o unidades. Costos y mano de obra exactos; precio sugerido y rendimiento del stock.

import 'dinero.dart';
import 'ganancia.dart';

const int milesimasPorUnidad = 1000;

const int gananciaBuscadaPorDefectoBp = 6000;

enum UnidadInsumo {
  ml('ml'),
  g('g'),
  u('u');

  const UnidadInsumo(this.clave);

  final String clave;

  String get abreviatura => clave;

  String get nombre => switch (this) {
    ml => 'Mililitros',
    g => 'Gramos',
    u => 'Unidades',
  };

  static UnidadInsumo? desdeClave(String? clave) {
    for (final u in values) {
      if (u.clave == clave) return u;
    }
    return null;
  }
}

class InsumoParaCalculo {
  const InsumoParaCalculo({
    required this.costoEnvaseCentavos,
    required this.contenidoEnvaseMilesimas,
    required this.stockMilesimas,
  });

  final int costoEnvaseCentavos;
  final int contenidoEnvaseMilesimas;
  final int stockMilesimas;
}

class UsoDeInsumo {
  const UsoDeInsumo({required this.insumo, required this.cantidadMilesimas});

  final InsumoParaCalculo insumo;
  final int cantidadMilesimas;
}

void _validarInsumo(InsumoParaCalculo i) {
  if (i.contenidoEnvaseMilesimas <= 0) {
    throw ArgumentError('El envase tiene que traer algo (contenido mayor a 0)');
  }
  if (i.costoEnvaseCentavos < 0) {
    throw ArgumentError('El costo del envase no puede ser negativo');
  }
}

int costoInsumosCentavos(List<UsoDeInsumo> receta) {
  var numerador = BigInt.zero;
  var denominador = BigInt.one;
  for (final uso in receta) {
    _validarInsumo(uso.insumo);
    if (uso.cantidadMilesimas < 0) {
      throw ArgumentError('Una cantidad de la receta no puede ser negativa');
    }
    final n =
        BigInt.from(uso.insumo.costoEnvaseCentavos) *
        BigInt.from(uso.cantidadMilesimas);
    final d = BigInt.from(uso.insumo.contenidoEnvaseMilesimas);
    numerador = numerador * d + n * denominador;
    denominador = denominador * d;
    final mcd = numerador.gcd(denominador);
    if (mcd > BigInt.one) {
      numerador ~/= mcd;
      denominador ~/= mcd;
    }
  }
  final paso = BigInt.from(centavosPorPeso);
  final pasos = _techo(numerador, denominador * paso);
  return (pasos * paso).toInt();
}

BigInt _techo(BigInt a, BigInt b) {
  final q = a ~/ b;
  return a > BigInt.zero && a % b != BigInt.zero ? q + BigInt.one : q;
}

int costoDeUsoCentavos(UsoDeInsumo uso) => costoInsumosCentavos([uso]);

int costoPorUnidadCentavos(InsumoParaCalculo insumo) {
  _validarInsumo(insumo);
  return redondearFraccionHaciaArriba(
    insumo.costoEnvaseCentavos * milesimasPorUnidad,
    insumo.contenidoEnvaseMilesimas,
    centavosPorPeso,
  );
}

int costoManoDeObraCentavos({
  required int duracionMinutos,
  required int valorHoraCentavos,
}) {
  if (duracionMinutos < 0 || valorHoraCentavos < 0) {
    throw ArgumentError('Duración y valor de la hora no pueden ser negativos');
  }
  return redondearFraccionHaciaArriba(
    valorHoraCentavos * duracionMinutos,
    60,
    centavosPorPeso,
  );
}

class CostoDeServicio {
  const CostoDeServicio({
    required this.insumosCentavos,
    required this.manoDeObraCentavos,
  });

  final int insumosCentavos;
  final int manoDeObraCentavos;

  int get totalCentavos => insumosCentavos + manoDeObraCentavos;
}

CostoDeServicio costoDeServicio({
  required List<UsoDeInsumo> receta,
  required int duracionMinutos,
  int? valorHoraCentavos,
  int? costoAManoCentavos,
}) {
  return CostoDeServicio(
    insumosCentavos: receta.isEmpty
        ? (costoAManoCentavos ?? 0)
        : costoInsumosCentavos(receta),
    manoDeObraCentavos: valorHoraCentavos == null
        ? 0
        : costoManoDeObraCentavos(
            duracionMinutos: duracionMinutos,
            valorHoraCentavos: valorHoraCentavos,
          ),
  );
}

int precioSugeridoCentavos({
  required int costoCentavos,
  required int gananciaBuscadaBp,
}) => precioConGananciaACentena(costoCentavos, gananciaBuscadaBp);

int? alcanzaPara(List<UsoDeInsumo> receta) {
  int? minimo;
  for (final uso in receta) {
    if (uso.cantidadMilesimas <= 0) continue;
    final rinde = uso.insumo.stockMilesimas <= 0
        ? 0
        : uso.insumo.stockMilesimas ~/ uso.cantidadMilesimas;
    if (minimo == null || rinde < minimo) minimo = rinde;
  }
  return minimo;
}

int? seAcabaPrimero(List<UsoDeInsumo> receta) {
  int? indice;
  int? rindeMinimo;
  for (var k = 0; k < receta.length; k++) {
    final uso = receta[k];
    if (uso.cantidadMilesimas <= 0) continue;
    final rinde = uso.insumo.stockMilesimas <= 0
        ? 0
        : uso.insumo.stockMilesimas ~/ uso.cantidadMilesimas;
    if (rindeMinimo == null || rinde < rindeMinimo) {
      rindeMinimo = rinde;
      indice = k;
    }
  }
  return indice;
}

int milesimasDeCompra({
  required int envases,
  required int contenidoEnvaseMilesimas,
}) {
  if (envases <= 0) throw ArgumentError('Hay que comprar al menos un envase');
  if (contenidoEnvaseMilesimas <= 0) {
    throw ArgumentError('El envase tiene que traer algo (contenido mayor a 0)');
  }
  return envases * contenidoEnvaseMilesimas;
}

int? milesimasDesdeTexto(String texto) {
  final limpio = texto.trim().replaceAll(',', '.');
  if (limpio.isEmpty ||
      !RegExp(r'^\d*\.?\d*$').hasMatch(limpio) ||
      limpio == '.') {
    return null;
  }
  final partes = limpio.split('.');
  final enteros = int.parse(partes[0].isEmpty ? '0' : partes[0]);
  var decimales = partes.length > 1 ? partes[1] : '';
  var redondeo = 0;
  if (decimales.length > 3) {
    redondeo = int.parse(decimales[3]) >= 5 ? 1 : 0;
    decimales = decimales.substring(0, 3);
  }
  return enteros * milesimasPorUnidad +
      int.parse(decimales.padRight(3, '0')) +
      redondeo;
}

String textoDeMilesimas(int milesimas) {
  final negativo = milesimas < 0;
  final abs = milesimas.abs();
  final enteros = abs ~/ milesimasPorUnidad;
  final resto = abs % milesimasPorUnidad;
  final decimales = resto == 0
      ? ''
      : ',${resto.toString().padLeft(3, '0').replaceFirst(RegExp(r'0+$'), '')}';
  return '${negativo ? '-' : ''}$enteros$decimales';
}

String textoCantidadDeInsumo(int milesimas, UnidadInsumo unidad) {
  final grande = switch (unidad) {
    UnidadInsumo.g => 'kg',
    UnidadInsumo.ml => 'L',
    UnidadInsumo.u => null,
  };
  if (grande != null && milesimas.abs() >= 1000 * milesimasPorUnidad) {
    return '${textoDeMilesimas(milesimas ~/ 1000)} $grande';
  }
  return '${textoDeMilesimas(milesimas)} ${unidad.abreviatura}';
}
