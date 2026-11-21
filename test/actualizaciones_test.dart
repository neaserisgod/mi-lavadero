import 'package:flutter_test/flutter_test.dart';
import 'package:mi_lavadero/ui/actualizaciones.dart';

void main() {
  Map<String, dynamic> datos() => {
    'app': 'mi-lavadero',
    'package': 'com.neaserisgod.milavadero',
    'version': '1.0.0+1001',
    'build': 1001,
    'url':
        '$servidorActualizaciones/api/update/file?app=mi-lavadero&build=1001',
    'sha256': 'a' * 64,
    'size': 100,
    'notes': 'Mejoras',
  };
  test('solo acepta el APK de esta app desde el servidor configurado', () {
    final j = datos();
    expect(
      VersionDisponible.desdeJson(
        j,
        'mi-lavadero',
        'com.neaserisgod.milavadero',
      ).build,
      1001,
    );
    for (final cambio in [
      {'app': 'otra'},
      {'package': 'otro'},
      {'url': 'https://otro.example/app.apk'},
      {'sha256': 'invalido'},
      {'size': maximoApk + 1},
    ]) {
      expect(
        () => VersionDisponible.desdeJson(
          {...j, ...cambio},
          'mi-lavadero',
          'com.neaserisgod.milavadero',
        ),
        throwsFormatException,
      );
    }
  });
}
