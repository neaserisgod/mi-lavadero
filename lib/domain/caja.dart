// Arqueo: saldo inicial más entradas menos salidas. Diferencia = contado menos esperado.

int cajaEsperadaCentavos({
  required int inicialCentavos,
  required int efectivoDeVentasCentavos,
  required int gastosEnEfectivoCentavos,
  required int ingresosEnEfectivoCentavos,
}) {
  return inicialCentavos +
      efectivoDeVentasCentavos -
      gastosEnEfectivoCentavos +
      ingresosEnEfectivoCentavos;
}

int diferenciaArqueo({
  required int contadoCentavos,
  required int esperadoCentavos,
}) {
  return contadoCentavos - esperadoCentavos;
}

int mpEsperadoCentavos({
  required int inicialCentavos,
  required int pagosNoEfectivoCentavos,
  required int gastosPorMpCentavos,
  required int ingresosPorMpCentavos,
}) {
  return inicialCentavos +
      pagosNoEfectivoCentavos -
      gastosPorMpCentavos +
      ingresosPorMpCentavos;
}
