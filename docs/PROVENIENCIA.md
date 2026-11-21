# Procedencia del código

Extracción autorizada por el dueño a partir de [neaserisgod/Nodo-Sur-Pos](https://github.com/neaserisgod/Nodo-Sur-Pos), commit `7404374548d9542eab627fca6b20c5c756004301`.

Se reutilizaron y adaptaron los cálculos de `lib/domain/dinero.dart`, `ganancia.dart`, `servicios.dart` y las fórmulas de arqueo de `caja.dart`. Se conservaron las pruebas de dinero e insumos aplicables. Las operaciones de stock mantienen el patrón de guardar anterior, posterior, fecha y motivo en la misma transacción. Los presupuestos guardan sus propios precios, costos y recetas.

La interfaz, la base reducida y las reglas específicas del lavadero se separaron de la app original para no arrastrar sus módulos ni depender de sus servidores. No se copiaron datos de comercios, claves ni credenciales.

Se conserva la fuente Figtree y su licencia en `fonts/Figtree-OFL.txt`. La ausencia de una licencia general en el repositorio de origen no se reemplaza por una licencia nueva sin decisión del dueño.
