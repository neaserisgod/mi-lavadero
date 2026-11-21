// Costo, precio y margen sobre el precio de venta. Montos en centavos y porcentajes en puntos básicos.

import 'dinero.dart';

const int _cienPorCientoBp = 10000;

void _validarGananciaBp(int gananciaBp) {
  if (gananciaBp >= _cienPorCientoBp) {
    throw ArgumentError(
      'gananciaBp tiene que ser menor a 10000 (100% de ganancia no existe)',
    );
  }
}

int precioDesdeCostoYGanancia(int costoCentavos, int gananciaBp) {
  _validarGananciaBp(gananciaBp);
  final numerador = costoCentavos * _cienPorCientoBp;
  return redondearFraccionHaciaArriba(
    numerador,
    _cienPorCientoBp - gananciaBp,
    centavosPorPeso,
  );
}

int costoDesdePrecioYGanancia(int precioCentavos, int gananciaBp) {
  _validarGananciaBp(gananciaBp);
  final numerador = precioCentavos * (_cienPorCientoBp - gananciaBp);
  return redondearFraccionHaciaArriba(
    numerador,
    _cienPorCientoBp,
    centavosPorPeso,
  );
}

int gananciaBpDesdeCostoYPrecio(int costoCentavos, int precioCentavos) {
  if (precioCentavos == 0) {
    throw ArgumentError(
      'precioCentavos no puede ser 0 para calcular la ganancia',
    );
  }
  return ((precioCentavos - costoCentavos) * _cienPorCientoBp / precioCentavos)
      .round();
}

int gananciaBruta(
  int precioUnitarioCentavos,
  int costoUnitarioCentavos,
  int cantidad,
) {
  return (precioUnitarioCentavos - costoUnitarioCentavos) * cantidad;
}

const int centavosPorCentena = 10000;

int precioConGananciaACentena(int costoCentavos, int gananciaBp) {
  _validarGananciaBp(gananciaBp);
  final numerador = costoCentavos * _cienPorCientoBp;
  return redondearFraccionHaciaArriba(
    numerador,
    _cienPorCientoBp - gananciaBp,
    centavosPorCentena,
  );
}
