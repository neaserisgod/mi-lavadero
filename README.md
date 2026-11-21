# Mi Lavadero

App personal para un lavadero de autos. Android, datos locales y funcionamiento sin internet. No requiere cuenta, suscripción ni servidor de Nodo Sur.

## Qué permite hacer

- Crear servicios y extras, con duración, precios por tipo de vehículo, insumos y mano de obra.
- Comprar insumos por envase, contar stock, marcar mínimos y consultar movimientos.
- Recibir un vehículo, recuperar su ficha por patente y armar una orden con precios acordados.
- Programar un turno o atender por llegada. Anotar responsable y observaciones.
- Pasar el trabajo de recibido a en lavado, listo y entregado. Los insumos se consumen al empezar, una sola vez.
- Registrar señas, pagos parciales y cobro final en efectivo o digital. La entrega y el pago son independientes.
- Cancelar antes de empezar y registrar la devolución de anticipos, sin devolver insumos que nunca se usaron.
- Consultar historial por vehículo y saldos pendientes, incluso después de entregar.
- Abrir caja, anotar gastos/ingresos, contar y cerrar. Los cierres conservan sus movimientos.
- Cambiar el nombre del lavadero, su alias y el valor de la hora. Exportar/restaurar respaldos completos.

Los pagos digitales se verifican en el banco o billetera y después se anotan: la app no cobra por Mercado Pago ni confirma transferencias automáticamente. El margen mostrado descuenta insumos y mano de obra estimados; no es ganancia neta del negocio.

## Empezar a usarla

1. En Ajustes cargá el nombre de tu lavadero y el valor de tu hora.
2. En Servicios → Insumos cargá tus envases, costos y cantidades.
3. Creá tus servicios y extras con los precios que cobrás y sus insumos.
4. Tocá **Recibir vehículo**. La primera visita guarda su ficha; las siguientes se buscan por patente.
5. Abrí la caja para registrar pagos y gastos. Exportá respaldos y guardalos fuera del celular.

Los ejemplos de los tests son ficticios. Una instalación nueva no trae clientes, autos ni precios inventados.

## Desarrollo

Flutter **3.47.5**, Dart **3.12.2 o superior**, Java 17 o superior y Android SDK. Una sola app: sin flavors ni otras plataformas.

```sh
flutter pub get
dart run build_runner build
flutter analyze
flutter test
flutter run
flutter build apk --debug
```

El APK de prueba queda en `build/app/outputs/flutter-apk/app-debug.apk`. Es una compilación de prueba; para mantener actualizaciones instalables entre equipos hay que conservar la misma clave de firma. No desinstales una versión con datos sin exportar antes su respaldo.

El workflow de CI verifica formato, análisis y tests, y genera un APK de prueba como artifact. La clave de prueba se conserva en el secreto `ANDROID_DEBUG_KEYSTORE` para poder instalar las siguientes compilaciones encima de la anterior. No publica en una tienda ni despliega servidores. Para una distribución estable hay que configurar una firma de producción.

## Estructura

- `lib/domain/`: dinero, costos y reglas puras del lavadero.
- `lib/data/`: SQLite con drift, repositorio transaccional y respaldos.
- `lib/ui/`: cuatro apartados: Lavados, Servicios, Vehículos y Caja.
- `android/`: aplicación `com.neaserisgod.milavadero`.

La base `mi_lavadero` vive dentro de la carpeta de datos de esta app. No usa ni modifica la de Nodo Sur. Los cambios de esquema futuros llevan una migración versionada; nunca se borra la base para actualizar.

Origen y extracción: [PROVENIENCIA.md](docs/PROVENIENCIA.md). Decisiones funcionales: [ALCANCE.md](docs/ALCANCE.md).

## Límites de esta primera versión

- Un solo celular y un solo negocio; sin sincronización, empleados con login ni comisiones.
- La agenda guarda horarios, pero no reserva automáticamente puestos de lavado ni impide turnos simultáneos.
- No incluye fotos, factura fiscal, bot, lector de patentes ni cobro automático.
- La cancelación se ofrece antes de empezar. Un trabajo iniciado conserva el consumo registrado; no hay una devolución automática de productos ya usados.
- Hace falta validar instalación, teclado, compartir archivos y recuperación de respaldos en un Android real.
