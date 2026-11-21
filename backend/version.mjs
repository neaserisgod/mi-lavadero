// Comparador reutilizado de neaserisgod/NodoSurPage, functions/_lib/releases.js.
export function cmpVersion(a, b) {
  const p = (v) => { const s = String(v), [core, rest] = s.split(/[-+]/, 2); const build = /\+/.test(s) ? parseInt(rest, 10) || 0 : 0;
    return { n: [...core.split('.').map((x) => parseInt(x, 10) || 0), build], pre: /-/.test(s) ? rest : null }; };
  const x = p(a), y = p(b);
  for (let i = 0; i < 4; i++) if (x.n[i] !== y.n[i]) return x.n[i] < y.n[i] ? -1 : 1;
  if (x.pre === y.pre) return 0;
  if (x.pre === null) return 1;
  if (y.pre === null) return -1;
  const xs = x.pre.split('.'), ys = y.pre.split('.');
  for (let i = 0; i < Math.max(xs.length, ys.length); i++) {
    if (xs[i] === undefined) return -1;
    if (ys[i] === undefined) return 1;
    const nx = /^\d+$/.test(xs[i]), ny = /^\d+$/.test(ys[i]);
    const c = nx && ny ? Number(xs[i]) - Number(ys[i]) : xs[i] < ys[i] ? -1 : xs[i] > ys[i] ? 1 : 0;
    if (c) return c < 0 ? -1 : 1;
  }
  return 0;
}
