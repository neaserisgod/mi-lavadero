enum TipoVehiculo {
  auto('Auto'),
  suv('SUV'),
  camioneta('Camioneta'),
  moto('Moto'),
  otro('Otro');

  const TipoVehiculo(this.etiqueta);
  final String etiqueta;
}

enum EstadoLavado {
  recibido('Recibido'),
  enLavado('En lavado'),
  listo('Listo'),
  entregado('Entregado'),
  cancelado('Cancelado');

  const EstadoLavado(this.etiqueta);
  final String etiqueta;

  bool puedePasarA(EstadoLavado siguiente) => switch (this) {
    recibido => siguiente == enLavado || siguiente == cancelado,
    enLavado => siguiente == listo,
    listo => siguiente == entregado,
    entregado || cancelado => false,
  };
}

enum MedioPago { efectivo, digital }

String normalizarPatente(String texto) =>
    texto.toUpperCase().replaceAll(RegExp(r'[\s-]'), '');

String validarPatente(String texto) {
  final patente = normalizarPatente(texto);
  if (!RegExp(r'^[A-Z0-9]{3,12}$').hasMatch(patente)) {
    throw ArgumentError('Ingresá una patente de 3 a 12 letras o números.');
  }
  return patente;
}

/// Acepta patentes de distintos países y vehículos: no impone un formato argentino único.
int saldoPendiente({
  required int totalCentavos,
  required int cobradoCentavos,
}) => totalCentavos - cobradoCentavos;

void validarCobro({required int monto, required int saldo}) {
  if (monto <= 0 || monto > saldo) {
    throw ArgumentError(
      'El monto debe ser mayor a cero y no superar el saldo pendiente.',
    );
  }
}
