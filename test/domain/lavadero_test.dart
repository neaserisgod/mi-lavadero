import 'package:flutter_test/flutter_test.dart';
import 'package:mi_lavadero/domain/lavadero.dart';

void main() {
  test('la patente normaliza espacios y guiones, sin imponer país', () {
    expect(validarPatente(' ab 123-cd '), 'AB123CD');
    expect(validarPatente('abc123'), 'ABC123');
    expect(() => validarPatente('??'), throwsArgumentError);
  });
  test('el recorrido no permite saltos ni consume otra vez al repetir', () {
    expect(EstadoLavado.recibido.puedePasarA(EstadoLavado.enLavado), isTrue);
    expect(EstadoLavado.recibido.puedePasarA(EstadoLavado.entregado), isFalse);
    expect(EstadoLavado.enLavado.puedePasarA(EstadoLavado.enLavado), isFalse);
    expect(EstadoLavado.enLavado.puedePasarA(EstadoLavado.cancelado), isFalse);
    expect(EstadoLavado.listo.puedePasarA(EstadoLavado.entregado), isTrue);
  });
  test('se admite pagar parcialmente y se rechazan sobrepagos', () {
    expect(saldoPendiente(totalCentavos: 10000, cobradoCentavos: 3000), 7000);
    expect(() => validarCobro(monto: 7001, saldo: 7000), throwsArgumentError);
    expect(() => validarCobro(monto: -1, saldo: 7000), throwsArgumentError);
    validarCobro(monto: 2000, saldo: 7000);
  });
}
