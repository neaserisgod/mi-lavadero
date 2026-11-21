# Actualizaciones de las apps personales

Backend publicado: https://apps-personales-actualizaciones.gtalovergamer.workers.dev

Reutiliza el protocolo de `neaserisgod/NodoSurPage`: feed JSON, APK en R2, metadatos inmutables en D1 y comparación de versiones Flutter (`version.mjs` proviene de `functions/_lib/releases.js`). Es un Worker aparte, sin web, usuarios, suscripciones ni acceso a los datos comerciales de las apps. NodoSurPage y el POS no se modifican.

Cada app tiene su propia secuencia: `mi-lavadero` y `mi-reparto`. El repositorio de cada una contiene `.github/workflows/publicar.yml`. En Actions → **Publicar actualización Android** → **Run workflow**, elegir `main` y escribir las notas. También se publica al subir un commit cuyo mensaje empieza por `release:`. Los demás pushes solo verifican; no distribuyen cambios automáticamente.

La versión visible sale de `pubspec.yaml`. El `versionCode` instalado sale del número de ejecución del workflow + 1000 y siempre debe crecer. No borrar y recrear este workflow ni reducir la versión semántica. El backend rechaza duplicados y retrocesos. Un fallo se reintenta mediante una ejecución nueva; una publicación ya registrada no se sobrescribe.

La app busca novedades al abrir y al volver al primer plano, con intervalo mínimo de una hora, y descarga el APK verificado. En Ajustes se puede forzar la búsqueda. Android siempre requiere confirmación para instalar y puede pedir habilitar «Instalar apps desconocidas» una vez. No instala en silencio ni ejecuta un servicio de actualización mientras la app está cerrada. El instalador compara paquete, certificado y número de compilación; los datos permanecen en el mismo almacenamiento.

## API pública

- `GET /health`
- `GET /api/update/latest.json?app=mi-reparto&version=0.2.0%2B1001`: `{update:false}` o versión, compilación, URL, tamaño, SHA256 y notas.
- `GET|HEAD /api/update/file?app=mi-reparto&build=1001`: descarga, Range y ETag.

## Publicación y firma

GitHub OIDC autentica exclusivamente el workflow `publicar.yml` de la rama `main`, con audiencia fija, propietario y repositorios numéricos verificados. No acepta forks, PRs, otras ramas ni otros workflows. No requiere copiar credenciales de Cloudflare a GitHub.

La clave RSA de firma se generó y permanece como secreto `SIGNING_PRIVATE_KEY` del Worker. Solo ese workflow autorizado puede obtenerla durante la compilación; `tool/publicar.py` genera un certificado determinista y un keystore temporal. Nunca se publica el keystore como artifact ni se imprime la clave. La contraseña del contenedor temporal no es una credencial del servidor. No rotar este secreto salvo que se planifique una migración de firma: Android no permite actualizar una app con otro certificado.

- `GET /api/ci/signing-key?app=…`: solo OIDC válido.
- `PUT /api/ci/publish?app=…&version=…`: solo OIDC; tamaño máximo 64 MiB, SHA256 comprobado antes de registrar; ruta R2 única, sin sobrescribir versiones. Se guarda el commit y la ejecución de GitHub de origen.

Los APK publicados son release para Android ARM64. La primera migración desde los antiguos APK de prueba con firma temporal puede requerir exportar respaldo, desinstalar, instalar la versión firmada y restaurar. Las siguientes publicaciones conservan su firma.

## Recursos y comprobaciones

Worker: `apps-personales-actualizaciones`. Bucket privado: `apps-personales-apk`. D1: `apps-personales-versiones` (`04b904d5-45fc-4819-8554-a25a4fb8dee3`). Los recursos contienen versiones y binarios; no clientes, pagos ni ubicaciones de reparto.

```sh
node --test backend/worker.test.mjs
```

Las pruebas cubren autorización OIDC y firma RSA real, aislamiento de apps, comparador y denegación de secretos. Además se debe comprobar cada publicación real y su SHA256. El código del backend está en este repositorio; el workflow y el cliente también se incluyen en `mi-reparto`.
