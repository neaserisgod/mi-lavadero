import { cmpVersion } from './version.mjs';
export const BASE = 'https://apps-personales-actualizaciones.gtalovergamer.workers.dev';
const ISSUER = 'https://token.actions.githubusercontent.com';
export const APPS = {
  'mi-lavadero': { repo: 'neaserisgod/mi-lavadero', repoId: '1466340657', package: 'com.neaserisgod.milavadero' },
  'mi-reparto': { repo: 'neaserisgod/mi-reparto', repoId: '1466921013', package: 'com.neaserisgod.mireparto' },
};
const MAX_APK = 64 * 1024 * 1024;
const json = (body, status = 200) => Response.json(body, { status, headers: { 'Cache-Control': 'no-store', 'X-Content-Type-Options': 'nosniff' } });
const bytes = (s) => Uint8Array.from(atob(s.replace(/-/g, '+').replace(/_/g, '/')), c => c.charCodeAt(0));
const decode = (s) => JSON.parse(new TextDecoder().decode(bytes(s)));
const hex = (b) => [...new Uint8Array(b)].map(v => v.toString(16).padStart(2, '0')).join('');
export function claimsOk(c, app, now = Date.now() / 1000) {
  const a = APPS[app];
  return Boolean(a && c.iss === ISSUER && c.aud === BASE && c.exp > now && c.nbf <= now + 10 && c.iat <= now + 10 && now - c.iat < 600 &&
    c.repository === a.repo && c.repository_id === a.repoId && c.repository_owner_id === '98111166' && c.ref === 'refs/heads/main' &&
    c.sub === `repo:${a.repo}:ref:refs/heads/main` && c.workflow_ref === `${a.repo}/.github/workflows/publicar.yml@refs/heads/main` &&
    ['workflow_dispatch', 'push'].includes(c.event_name) && /^[a-f0-9]{40}$/.test(c.sha || '') && /^\d+$/.test(c.run_id || ''));
}
export async function authenticate(request, app, fetcher = fetch) {
  try {
    const token = /^Bearer ([A-Za-z0-9_.-]+)$/.exec(request.headers.get('Authorization') || '')?.[1];
    if (!token || token.length > 20000) return null;
    const parts = token.split('.'); if (parts.length !== 3) return null;
    const h = decode(parts[0]), c = decode(parts[1]);
    if (h.alg !== 'RS256' || !claimsOk(c, app)) return null;
    const response = await fetcher(`${ISSUER}/.well-known/jwks`, { cf: { cacheTtl: 300, cacheEverything: true } });
    if (!response.ok) return null;
    const jwk = (await response.json()).keys.find(k => k.kid === h.kid && k.kty === 'RSA' && k.alg === 'RS256' && k.use === 'sig');
    if (!jwk) return null;
    const key = await crypto.subtle.importKey('jwk', jwk, { name: 'RSASSA-PKCS1-v1_5', hash: 'SHA-256' }, false, ['verify']);
    return await crypto.subtle.verify('RSASSA-PKCS1-v1_5', key, bytes(parts[2]), new TextEncoder().encode(`${parts[0]}.${parts[1]}`)) ? c : null;
  } catch { return null; }
}
export const SCHEMA = `CREATE TABLE IF NOT EXISTS releases (
 app TEXT NOT NULL, version TEXT NOT NULL, build INTEGER NOT NULL, channel TEXT NOT NULL DEFAULT 'stable',
 file_key TEXT NOT NULL UNIQUE, sha256 TEXT NOT NULL, size INTEGER NOT NULL, notes TEXT NOT NULL,
 source_sha TEXT NOT NULL, run_id TEXT NOT NULL, published_at INTEGER NOT NULL, active INTEGER NOT NULL DEFAULT 1,
 PRIMARY KEY(app,build))`;
export async function latest(env, app) {
  const { results } = await env.DB.prepare("SELECT * FROM releases WHERE app=? AND active=1 AND channel='stable' ORDER BY build DESC LIMIT 1").bind(app).all();
  return results[0] || null;
}
export async function handle(request, env) {
  const url = new URL(request.url), app = url.searchParams.get('app');
  if (url.pathname === '/health' && request.method === 'GET') return json({ ok: true, service: 'apps-personales-actualizaciones' });
  if (!APPS[app]) return json({ error: 'app_invalid' }, 400);
  if (url.pathname === '/api/update/latest.json' && request.method === 'GET') {
    const current = url.searchParams.get('version');
    if (current && !/^\d+\.\d+\.\d+\+\d{1,9}$/.test(current)) return json({ error: 'version_invalid' }, 400);
    const r = await latest(env, app);
    if (!r || (current && cmpVersion(r.version, current) <= 0)) return json({ update: false });
    return json({ update: true, app, package: APPS[app].package, version: r.version, build: r.build, channel: 'stable',
      url: `${BASE}/api/update/file?app=${app}&build=${r.build}`, sha256: r.sha256, size: r.size, notes: r.notes, mandatory: false });
  }
  if (url.pathname === '/api/update/file' && ['GET', 'HEAD'].includes(request.method)) {
    const build = Number(url.searchParams.get('build'));
    if (!Number.isSafeInteger(build) || build < 1) return json({ error: 'not_found' }, 404);
    const r = await env.DB.prepare('SELECT * FROM releases WHERE app=? AND build=? AND active=1').bind(app, build).first();
    if (!r) return json({ error: 'not_found' }, 404);
    const o = await env.RELEASES.get(r.file_key, { range: request.headers, onlyIf: request.headers });
    if (!o) return json({ error: 'not_found' }, 404);
    const headers = new Headers({ 'Content-Type': 'application/vnd.android.package-archive', 'Content-Disposition': `attachment; filename="${app}-${r.version}.apk"`, 'Accept-Ranges': 'bytes', 'Cache-Control': 'private, max-age=0, must-revalidate', 'X-Content-Type-Options': 'nosniff', ETag: o.httpEtag });
    if (!('body' in o)) return new Response(null, { status: 304, headers });
    const offset = o.range?.offset ?? (o.range?.suffix ? o.size - o.range.suffix : 0), length = o.range?.length ?? o.size - offset;
    const partial = offset !== 0 || length !== o.size;
    headers.set('Content-Length', String(length));
    if (partial) headers.set('Content-Range', `bytes ${offset}-${offset + length - 1}/${o.size}`);
    return new Response(request.method === 'HEAD' ? null : o.body, { status: partial ? 206 : 200, headers });
  }
  if (url.pathname.startsWith('/api/ci/')) {
    const c = await authenticate(request, app);
    if (!c) return json({ error: 'unauthorized' }, 401);
    if (url.pathname === '/api/ci/signing-key' && request.method === 'GET') {
      if (!env.SIGNING_PRIVATE_KEY) return json({ error: 'signing_unavailable' }, 503);
      return json({ privateKey: env.SIGNING_PRIVATE_KEY });
    }
    if (url.pathname === '/api/ci/publish' && request.method === 'PUT') {
      const version = url.searchParams.get('version'), sha256 = request.headers.get('X-Apk-Sha256');
      const notes = decodeURIComponent(request.headers.get('X-Release-Notes') || 'Actualización');
      const match = /^(\d+\.\d+\.\d+)\+(\d{1,9})$/.exec(version || '');
      const build = match ? Number(match[2]) : 0, size = Number(request.headers.get('Content-Length'));
      if (!match || build < 1 || !/^[a-f0-9]{64}$/.test(sha256 || '') || size < 1 || size > MAX_APK || notes.length > 4000) return json({ error: 'metadata_invalid' }, 400);
      const old = await latest(env, app);
      if (old && (build <= old.build || cmpVersion(version, old.version) <= 0)) return json({ error: 'version_must_increase' }, 409);
      if (await env.DB.prepare('SELECT build FROM releases WHERE app=? AND build=?').bind(app, build).first()) return json({ error: 'version_exists' }, 409);
      // Only bounded release APKs are buffered, never the public download stream.
      const data = await request.arrayBuffer();
      if (data.byteLength !== size || hex(await crypto.subtle.digest('SHA-256', data)) !== sha256) return json({ error: 'checksum_mismatch' }, 422);
      // Unique object per publication: a retried/concurrent job can never overwrite a registered APK.
      const key = `${app}/stable/${version}/${crypto.randomUUID()}.apk`;
      await env.RELEASES.put(key, data, { httpMetadata: { contentType: 'application/vnd.android.package-archive' }, sha256 });
      try {
        await env.DB.prepare('INSERT INTO releases (app,version,build,file_key,sha256,size,notes,source_sha,run_id,published_at) VALUES (?,?,?,?,?,?,?,?,?,?)').bind(app, version, build, key, sha256, size, notes, c.sha, c.run_id, Date.now()).run();
      } catch (error) {
        await env.RELEASES.delete(key);
        if (/UNIQUE/i.test(String(error))) return json({ error: 'version_exists' }, 409);
        throw error;
      }
      return json({ ok: true, app, version, build, sha256, size });
    }
  }
  return json({ error: 'not_found' }, 404);
}
export default { async fetch(request, env) {
  try { return await handle(request, env); }
  catch { console.error(JSON.stringify({ error: 'update_backend_failed', path: new URL(request.url).pathname })); return json({ error: 'server_error' }, 500); }
} };
