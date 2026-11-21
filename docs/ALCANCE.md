# Mi Lavadero

App propia para un único celular Android. Nombre comercial configurable. Sin cuentas, abonos, servidor ni servicios de Nodo Sur.

## Extracción

Se reutilizan los cálculos exactos de dinero, insumos, mano de obra, rendimiento, precio sugerido y arqueo de Nodo Sur POS; se conserva Figtree. Se adaptan a una base SQLite pequeña, exclusivamente del lavadero. No se copia la aplicación completa ni sus migraciones históricas.

Fuera: almacén, cigarrillos, gastronomía, proveedores/cuentas corrientes, bot, IA, Google, nube, sincronización, Point, actualizaciones remotas y plataformas de escritorio/web. Mercado Pago/transferencia se registra manualmente como dinero digital; no se promete verificar un pago.

## Funcionamiento

- Servicios y extras propios, duración, receta de insumos y precios por tipo de vehículo.
- Insumos en ml, g o unidades: envase, costo, compras, conteo, mínimo y movimientos con motivo.
- Vehículo por patente, cliente y teléfono; órdenes con copia de los datos, servicios, precio, costos, responsable y notas.
- Agenda mediante fecha/hora programada; atención por llegada también. No asigna automáticamente capacidad de puestos.
- Recibido → en lavado → listo → entregado. El pago y las señas son independientes. Se puede entregar con saldo pendiente, que queda visible.
- Los insumos se descuentan una sola vez al empezar, usando la receta guardada en la orden. Cobrar no vuelve a descontarlos. Una devolución de plata no repone químicos ya utilizados.
- Pagos parciales en efectivo o digital, saldo pendiente y devolución con rastro. No se puede devolver más de lo recibido ni cancelar un trabajo iniciado sin dejar asentado lo ocurrido.
- Caja: apertura, gastos/ingresos, revisión de diferencias y cierre; cada movimiento lleva fecha y motivo.
- Historial por patente y período; margen después de insumos y mano de obra estimada separado de gastos reales.
- Exportación y restauración completa mediante archivo local. Restaurar reemplaza datos solamente después de confirmarlo y crea antes una copia de los datos existentes.

## Criterios

Dinero en centavos enteros; cantidades en milésimas. Precios y costos históricos no cambian al editar el catálogo. Operaciones de dinero y stock transaccionales y protegidas frente a doble toque. Base propia `mi_lavadero`, aplicación Android `com.neaserisgod.milavadero`.

Nombre provisional: Mi Lavadero. Los servicios y precios se cargan con valores propios; no se inventan precios para el negocio.
