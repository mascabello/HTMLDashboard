<!doctype html><html><head><meta charset=utf8><meta name=viewport content="width=device-width,initial-scale=1,viewport-fit=cover"><style>:root{color-scheme:light;box-sizing:border-box;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}html{scroll-padding-top:env(safe-area-inset-top,0px)}body{margin:0;padding:0;font:14px -apple-system,BlinkMacSystemFont,sans-serif;background:#fff;color:#000}img{max-width:100%}[hidden]:not([hidden=until-found i]){display:none!important}</style></head><body>
<title>Impact@Scale Planner</title>
<meta name="claude:viewport-fit-sides" content="cover">
<meta name="description" content="Plan where PP&amp;WS capacity goes: Capability Homes, Outcome Teams and Franchise Networks by focus area, with availability in % of FTE and Excel export.">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Archivo:wdth,wght@62..125,100..900&family=IBM+Plex+Mono:wght@400;500;600&display=swap">
<style>
:root {
  /* Layout: a quiet rail of views on the page ground beside a working canvas of panels;
     the ISO week (Mon–Fri capacity) is the unit every grid, chart and export shares. */
  --font-display: "Archivo", "Helvetica Neue", Arial, sans-serif;
  --font-ui: "Archivo", system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
  --font-data: "IBM Plex Mono", ui-monospace, SFMono-Regular, Menlo, Consolas, monospace;

  --bg: #ecf1f3;
  --surface: #ffffff;
  --surface-2: #f5f8f9;
  --hover: #eef4f6;
  --line: #d3dde0;
  --line-strong: #b2c1c6;
  --grid: #e3eaec;
  --fg: #0e222a;
  --fg-2: #4c626b;
  --fg-3: #64767e;
  --accent: #076387;
  --accent-hover: #005171;
  --accent-ink: #ffffff;
  --accent-soft: #dbeff9;
  --accent-text: #076387;
  --focus: #1b86b8;

  --heat-0: #ebf5fa; --heat-1: #c7e3f0; --heat-2: #92c7df; --heat-3: #4f9cc2; --heat-4: #136b94;
  --heat-over: #cf432c; --heat-off: #dfe4e6;
  --hi-0: #0e222a; --hi-1: #0e222a; --hi-2: #0e222a; --hi-3: #0e222a; --hi-4: #ffffff;
  --hi-over: #ffffff; --hi-off: #4c626b;

  --lvl-1: #78b4d1; --lvl-2: #4593b9; --lvl-3: #1a7199; --lvl-4: #075172;
  --li-1: #0e222a; --li-2: #0e222a; --li-3: #ffffff; --li-4: #ffffff;

  --s-conf: #136b94; --s-tent: #3fa5cd; --s-open: #e57431;
  /* Impact@Scale types: validated as a set (light surface #fff; CVD ΔE ≥ 9.3, normal ΔE ≥ 15.8, all ≥ 3:1) */
  --k-home: #136b94; --k-outcome: #139267; --k-network: #a24fc9;
  --ki-home: #ffffff; --ki-outcome: #06161c; --ki-network: #ffffff;

  --good: #287c42; --good-soft: #dff6e2;
  --warn: #8f5a00; --warn-soft: #fcedcd;
  --crit: #c53829; --crit-soft: #ffe9e5; --crit-ink: #ffffff;

  --shadow-1: 0 1px 2px rgb(14 34 42 / 0.06);
  --shadow-2: 0 18px 48px rgb(14 34 42 / 0.22);
  --scrim: rgb(9 20 25 / 0.42);
  --r: 12px;
  --r-sm: 7px;
}
@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) {
    --bg: #091114; --surface: #111b1f; --surface-2: #172227; --hover: #1b282e;
    --line: #263338; --line-strong: #37484f; --grid: #1e2a2f;
    --fg: #e0eaed; --fg-2: #a4b4ba; --fg-3: #84959c;
    --accent: #5fb7dc; --accent-hover: #7dcaeb; --accent-ink: #06222d; --accent-soft: #153443; --accent-text: #6cc0e3; --focus: #7dcaeb;
    --heat-0: #1b272d; --heat-1: #1c3d4a; --heat-2: #1e576f; --heat-3: #307a9d; --heat-4: #58add4;
    --heat-over: #ea6d56; --heat-off: #282c2e;
    --hi-0: #e0eaed; --hi-1: #e0eaed; --hi-2: #e0eaed; --hi-3: #ffffff; --hi-4: #0b1a20;
    --hi-over: #0b1a20; --hi-off: #a4b4ba;
    --lvl-1: #25627d; --lvl-2: #3884a5; --lvl-3: #50a7cd; --lvl-4: #7dcaeb;
    --li-1: #e0eaed; --li-2: #ffffff; --li-3: #0b1a20; --li-4: #0b1a20;
    --s-conf: #3ea1cc; --s-tent: #006c98; --s-open: #da7134;
    --k-home: #1b77a7; --k-outcome: #23ac74; --k-network: #9e6de7;
    --ki-home: #ffffff; --ki-outcome: #06161c; --ki-network: #06161c;
    --good: #68ca80; --good-soft: #1a3520;
    --warn: #e9b452; --warn-soft: #3f2c10;
    --crit: #f47c6b; --crit-soft: #4a241e; --crit-ink: #200b07;
    --shadow-1: 0 1px 2px rgb(0 0 0 / 0.4);
    --shadow-2: 0 18px 56px rgb(0 0 0 / 0.6);
    --scrim: rgb(0 0 0 / 0.6);
    color-scheme: dark;
  }
}
:root[data-theme="dark"] {
  --bg: #091114; --surface: #111b1f; --surface-2: #172227; --hover: #1b282e;
  --line: #263338; --line-strong: #37484f; --grid: #1e2a2f;
  --fg: #e0eaed; --fg-2: #a4b4ba; --fg-3: #84959c;
  --accent: #5fb7dc; --accent-hover: #7dcaeb; --accent-ink: #06222d; --accent-soft: #153443; --accent-text: #6cc0e3; --focus: #7dcaeb;
  --heat-0: #1b272d; --heat-1: #1c3d4a; --heat-2: #1e576f; --heat-3: #307a9d; --heat-4: #58add4;
  --heat-over: #ea6d56; --heat-off: #282c2e;
  --hi-0: #e0eaed; --hi-1: #e0eaed; --hi-2: #e0eaed; --hi-3: #ffffff; --hi-4: #0b1a20;
  --hi-over: #0b1a20; --hi-off: #a4b4ba;
  --lvl-1: #25627d; --lvl-2: #3884a5; --lvl-3: #50a7cd; --lvl-4: #7dcaeb;
  --li-1: #e0eaed; --li-2: #ffffff; --li-3: #0b1a20; --li-4: #0b1a20;
  --s-conf: #3ea1cc; --s-tent: #006c98; --s-open: #da7134;
  --k-home: #1b77a7; --k-outcome: #23ac74; --k-network: #9e6de7;
  --ki-home: #ffffff; --ki-outcome: #06161c; --ki-network: #06161c;
  --good: #68ca80; --good-soft: #1a3520;
  --warn: #e9b452; --warn-soft: #3f2c10;
  --crit: #f47c6b; --crit-soft: #4a241e; --crit-ink: #200b07;
  --shadow-1: 0 1px 2px rgb(0 0 0 / 0.4);
  --shadow-2: 0 18px 56px rgb(0 0 0 / 0.6);
  --scrim: rgb(0 0 0 / 0.6);
  color-scheme: dark;
}

/* ---------- base ---------- */
html, body { height: 100%; }
body {
  background: var(--bg);
  color: var(--fg);
  font-family: var(--font-ui);
  font-size: 14px;
  line-height: 1.45;
  -webkit-font-smoothing: antialiased;
  text-rendering: optimizeLegibility;
}
h1, h2, h3, h4 { margin: 0; text-wrap: balance; }
p { margin: 0; }
button, input, select, textarea { font: inherit; color: inherit; }
button { cursor: pointer; }
a { color: var(--accent-text); }
:focus-visible { outline: 2px solid var(--focus); outline-offset: 2px; }
.ico { width: 18px; height: 18px; fill: none; stroke: currentColor; stroke-width: 1.75; stroke-linecap: round; stroke-linejoin: round; flex: none; }
.muted { color: var(--fg-2); }
.faint { color: var(--fg-3); }
.num { font-variant-numeric: tabular-nums; }
.mono { font-family: var(--font-data); font-size: 0.92em; }
.sr { position: absolute; width: 1px; height: 1px; overflow: hidden; clip: rect(0 0 0 0); white-space: nowrap; }

/* ---------- app shell ---------- */
.app {
  display: grid;
  grid-template-columns: 228px minmax(0, 1fr);
  gap: 24px;
  min-height: 100%;
  padding-left: max(16px, env(safe-area-inset-left, 0px));
  padding-right: max(16px, env(safe-area-inset-right, 0px));
  padding-block: 18px 40px;
  box-sizing: border-box;
}
.rail {
  position: sticky;
  top: calc(18px + env(safe-area-inset-top, 0px));
  align-self: start;
  display: flex;
  flex-direction: column;
  gap: 22px;
  min-width: 0;
}
.brand { display: flex; align-items: center; gap: 12px; padding: 4px 6px; }
.mark { width: 34px; height: 34px; flex: none; }
.brand-name {
  font-family: var(--font-display);
  font-stretch: 125%;
  font-weight: 800;
  font-size: 15.5px;
  line-height: 1.1;
  letter-spacing: -0.01em;
}
.brand-week { font-family: var(--font-data); font-size: 11.5px; color: var(--fg-2); margin-top: 3px; }
.nav { display: grid; gap: 2px; }
.nav a {
  display: flex; align-items: center; gap: 11px;
  padding: 9px 12px;
  border-radius: 9px;
  color: var(--fg-2);
  text-decoration: none;
  font-weight: 600;
  font-size: 14px;
}
.nav a:hover { background: var(--hover); color: var(--fg); }
.nav a[aria-current="page"] { background: var(--surface); color: var(--fg); box-shadow: var(--shadow-1), inset 0 0 0 1px var(--line); }
.nav a[aria-current="page"] .ico { color: var(--accent); }
.rail-foot { display: grid; gap: 10px; padding: 0 6px; }
.conn { display: flex; gap: 8px; align-items: flex-start; font-size: 12.5px; color: var(--fg-2); line-height: 1.35; }
.conn .ico { width: 15px; height: 15px; margin-top: 1px; }
.conn strong { color: var(--fg); font-weight: 600; display: block; }

.main { min-width: 0; display: flex; flex-direction: column; gap: 16px; }
.topbar { display: flex; flex-wrap: wrap; align-items: flex-end; justify-content: space-between; gap: 12px 20px; padding-top: 4px; }
.topbar h1 {
  font-family: var(--font-display);
  font-stretch: 125%;
  font-weight: 800;
  font-size: clamp(24px, 3vw, 32px);
  letter-spacing: -0.02em;
  line-height: 1.05;
}
.topbar .sub { color: var(--fg-2); margin-top: 6px; font-size: 14px; }
.top-actions { display: flex; flex-wrap: wrap; gap: 8px; align-items: center; }
.chip-ro { font-size: 12px; font-weight: 600; color: var(--fg-2); border: 1px solid var(--line-strong); border-radius: 999px; padding: 3px 10px; }

/* ---------- controls ---------- */
.btn {
  display: inline-flex; align-items: center; justify-content: center; gap: 7px;
  height: 36px; padding: 0 14px;
  border-radius: 8px;
  border: 1px solid var(--line-strong);
  background: var(--surface);
  color: var(--fg);
  font-weight: 600; font-size: 13.5px; line-height: 1;
  white-space: nowrap;
  transition: background-color .12s, border-color .12s;
}
.btn:hover { background: var(--hover); }
a.btn { text-decoration: none; }
.btn .ico { width: 16px; height: 16px; }
.btn.primary { background: var(--accent); border-color: var(--accent); color: var(--accent-ink); }
.btn.primary:hover { background: var(--accent-hover); border-color: var(--accent-hover); }
.btn.ghost { background: transparent; border-color: transparent; color: var(--fg-2); }
.btn.ghost:hover { background: var(--hover); color: var(--fg); }
.btn.small { height: 30px; padding: 0 10px; font-size: 12.5px; border-radius: 7px; }
.btn.danger { color: var(--crit); }
.btn.danger.solid { background: var(--crit); border-color: var(--crit); color: var(--crit-ink); }
.btn[disabled] { opacity: .5; cursor: not-allowed; }
.icon-btn { width: 34px; padding: 0; }
.icon-btn.small { width: 30px; }

.filters { display: flex; flex-wrap: wrap; align-items: flex-end; gap: 12px 14px; }
.filters-end { margin-left: auto; display: flex; gap: 8px; flex-wrap: wrap; }
.field { display: grid; gap: 5px; min-width: 0; }
.field > span, .field-label { font-size: 12px; font-weight: 600; color: var(--fg-2); }
.field.grow { flex: 1 1 220px; }
input[type="text"], input[type="search"], input[type="email"], input[type="number"], input[type="date"], select, textarea {
  height: 36px; box-sizing: border-box;
  border: 1px solid var(--line-strong);
  border-radius: 8px;
  background: var(--surface);
  color: var(--fg);
  padding: 0 10px;
  font-size: 14px;
  min-width: 0;
}
select { padding-right: 28px; }
textarea { height: auto; min-height: 84px; padding: 8px 10px; resize: vertical; line-height: 1.45; }
input:hover, select:hover, textarea:hover { border-color: var(--fg-3); }
input[aria-invalid="true"], select[aria-invalid="true"] { border-color: var(--crit); }
.search { position: relative; display: flex; }
.search .ico { position: absolute; left: 10px; top: 9px; width: 17px; height: 17px; color: var(--fg-3); pointer-events: none; }
.search input { padding-left: 34px; width: 100%; }

.seg { display: inline-flex; background: var(--surface-2); border: 1px solid var(--line); border-radius: 9px; padding: 2px; gap: 2px; flex-wrap: wrap; }
.seg button {
  border: 0; background: transparent; color: var(--fg-2);
  height: 30px; padding: 0 11px; border-radius: 7px;
  font-weight: 600; font-size: 12.5px; white-space: nowrap;
}
.seg.nowrap { flex-wrap: nowrap; }
.seg button:hover { color: var(--fg); }
.seg button[aria-pressed="true"] { background: var(--surface); color: var(--fg); box-shadow: var(--shadow-1), inset 0 0 0 1px var(--line); }

.pill {
  display: inline-flex; align-items: center; gap: 5px;
  height: 22px; padding: 0 8px;
  border-radius: 999px;
  font-size: 12px; font-weight: 600; line-height: 1;
  white-space: nowrap;
  background: var(--surface-2); color: var(--fg-2);
  box-shadow: inset 0 0 0 1px var(--line);
}
.pill .ico { width: 13px; height: 13px; stroke-width: 2; }
.pill.accent { background: var(--accent-soft); color: var(--accent-text); box-shadow: none; }
.pill.good { background: var(--good-soft); color: var(--good); box-shadow: none; }
.pill.warn { background: var(--warn-soft); color: var(--warn); box-shadow: none; }
.pill.crit { background: var(--crit-soft); color: var(--crit); box-shadow: none; }
.pill.muted { background: transparent; color: var(--fg-3); }

/* ---------- banners ---------- */
#banners { display: grid; gap: 8px; }
#banners:empty { display: none; }
.banner {
  display: flex; flex-wrap: wrap; align-items: center; gap: 8px 12px;
  padding: 10px 14px;
  border-radius: 10px;
  background: var(--surface);
  border: 1px solid var(--line);
  font-size: 13.5px;
}
.banner > .ico { color: var(--accent); }
.banner.warn > .ico { color: var(--warn); }
.banner p { flex: 1 1 280px; min-width: 0; }
.banner.sample { background: var(--accent-soft); border-color: transparent; }

/* ---------- panels ---------- */
#view { display: grid; gap: 16px; outline: none; }
#vb { display: grid; gap: 16px; min-width: 0; }
.panel {
  background: var(--surface);
  border: 1px solid var(--line);
  border-radius: var(--r);
  padding: 18px 20px 20px;
  min-width: 0;
}
.panel.flush { padding: 0; overflow: hidden; }
.panel-head { display: flex; flex-wrap: wrap; align-items: flex-start; justify-content: space-between; gap: 8px 16px; margin-bottom: 14px; }
.panel-head h2 { font-size: 16px; font-weight: 700; letter-spacing: -0.005em; }
.panel-head p { color: var(--fg-2); font-size: 13px; margin-top: 3px; max-width: 64ch; }
.panel-head .count { font-family: var(--font-data); font-size: 12px; color: var(--fg-2); background: var(--surface-2); border-radius: 999px; padding: 2px 9px; box-shadow: inset 0 0 0 1px var(--line); }
.cols { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 16px; }
.cols > .panel { align-self: start; }

/* ---------- KPIs ---------- */
.kpis { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 12px; }
.kpi { background: var(--surface); border: 1px solid var(--line); border-radius: var(--r); padding: 15px 16px 16px; display: grid; gap: 6px; align-content: start; min-width: 0; }
.kpi-label { display: flex; flex-wrap: wrap; align-items: center; justify-content: space-between; gap: 4px 8px; font-size: 13px; font-weight: 600; color: var(--fg-2); min-height: 22px; }
.kpi-value { font-size: 30px; font-weight: 650; letter-spacing: -0.02em; line-height: 1.05; }
.kpi-value .unit { font-size: 15px; font-weight: 600; color: var(--fg-2); margin-left: 3px; letter-spacing: 0; }
.kpi-sub { font-size: 12.5px; color: var(--fg-2); }
.meter { position: relative; height: 6px; border-radius: 999px; background: var(--heat-0); overflow: hidden; margin-top: 2px; }
.meter > i { position: absolute; inset: 0 auto 0 0; border-radius: 999px; background: var(--accent); }
.meter > i.tent { background: var(--s-tent); }
.meter.over > i { background: var(--heat-over); }

/* ---------- legends & charts ---------- */
.legend { display: flex; flex-wrap: wrap; gap: 6px 16px; font-size: 12.5px; color: var(--fg-2); margin-bottom: 8px; }
.legend span { display: inline-flex; align-items: center; gap: 6px; }
.sw { width: 11px; height: 11px; border-radius: 3px; display: inline-block; flex: none; }
.sw.line { height: 2px; width: 14px; border-radius: 2px; }
.sw.ring { width: 9px; height: 9px; border-radius: 50%; }
.chart { width: 100%; min-height: 230px; position: relative; }
.chart svg { display: block; overflow: visible; }
.chart .gl { stroke: var(--grid); stroke-width: 1; }
.chart .bl { stroke: var(--line-strong); stroke-width: 1; }
.chart .ax { fill: var(--fg-3); font-size: 11px; font-family: var(--font-ui); font-variant-numeric: tabular-nums; }
.chart .axw { fill: var(--fg-2); font-size: 11px; font-family: var(--font-data); }
.chart .capline { fill: none; stroke: var(--fg); stroke-width: 2; stroke-linejoin: round; stroke-linecap: round; }
.chart .capdot { fill: var(--fg); stroke: var(--surface); stroke-width: 2; }
.chart path, .chart rect:not(.hit), .chart circle, .chart text, .chart line { pointer-events: none; }
.chart .hit { fill: transparent; cursor: default; outline: none; }
.chart .hit:hover, .chart .hit:focus-visible { fill: var(--hover); fill-opacity: .55; }
.chart .now { fill: var(--accent-text); font-weight: 700; }
.table-wrap { overflow-x: auto; margin-top: 12px; border: 1px solid var(--line); border-radius: 10px; }
table.data { border-collapse: collapse; width: 100%; font-size: 13px; }
table.data th, table.data td { padding: 7px 12px; text-align: right; border-bottom: 1px solid var(--line); white-space: nowrap; font-variant-numeric: tabular-nums; }
table.data th:first-child, table.data td:first-child { text-align: left; }
table.data thead th { background: var(--surface-2); font-size: 12px; color: var(--fg-2); font-weight: 600; }
table.data tr:last-child td { border-bottom: 0; }

/* horizontal bars */
.bars { display: grid; gap: 10px; }
.bar-row { display: grid; grid-template-columns: minmax(96px, 34%) minmax(0, 1fr) 76px; align-items: center; gap: 12px; font-size: 13px; }
.bar-label { min-width: 0; overflow-wrap: anywhere; }
.bar-label small { display: block; color: var(--fg-3); font-size: 11.5px; }
.bar-track { position: relative; height: 14px; }
.bar-track::before { content: ""; position: absolute; inset: 0; border-radius: 4px; background: var(--surface-2); box-shadow: inset 0 0 0 1px var(--grid); }
.bar-fill { position: absolute; left: 0; top: 0; bottom: 0; border-radius: 0 4px 4px 0; background: var(--s-conf); }
.bar-fill.tent { background: var(--s-tent); }
.bar-fill.over { background: var(--heat-over); }
.bar-ref { position: absolute; top: -4px; bottom: -4px; width: 0; border-left: 1.5px solid var(--fg-2); }
.bar-val { text-align: right; font-weight: 600; font-variant-numeric: tabular-nums; display: flex; justify-content: flex-end; align-items: center; gap: 6px; }
.bar-axis { display: grid; grid-template-columns: minmax(96px, 34%) minmax(0, 1fr) 76px; gap: 12px; font-size: 11px; color: var(--fg-3); }
.bar-axis > div { position: relative; height: 14px; }
.bar-axis > div > span { position: absolute; transform: translateX(-50%); font-variant-numeric: tabular-nums; }

/* ---------- attention list ---------- */
.alerts { list-style: none; margin: 0; padding: 0; display: grid; }
.alert { display: grid; grid-template-columns: 92px minmax(0, 1fr) auto; gap: 12px; align-items: center; padding: 11px 0; border-top: 1px solid var(--line); }
.alert:first-child { border-top: 0; padding-top: 0; }
.alert-title { font-weight: 600; }
.alert-text { color: var(--fg-2); font-size: 13px; }
.empty-note { color: var(--fg-2); font-size: 13.5px; padding: 6px 0; display: flex; gap: 8px; align-items: center; }
.empty-note .ico { color: var(--good); }

/* ---------- people & lists ---------- */
.av {
  width: 34px; height: 34px; border-radius: 50%; flex: none;
  display: grid; place-items: center;
  background: var(--accent-soft); color: var(--accent-text);
  font-family: var(--font-display); font-stretch: 112%; font-weight: 700; font-size: 12.5px;
}
.av.lg { width: 48px; height: 48px; font-size: 16px; }
.list-meta { display: flex; justify-content: space-between; align-items: baseline; gap: 12px; color: var(--fg-2); font-size: 13px; }
.plist { display: grid; background: var(--surface); border: 1px solid var(--line); border-radius: var(--r); overflow: hidden; }
.prow {
  display: grid;
  grid-template-columns: minmax(200px, 1.5fr) minmax(130px, 1fr) minmax(120px, .9fr) 92px minmax(140px, 1.1fr) minmax(170px, 1.4fr);
  gap: 16px; align-items: center;
  width: 100%; text-align: left;
  padding: 12px 18px;
  border: 0; border-top: 1px solid var(--line);
  background: transparent;
  color: inherit;
}
.prow:first-child { border-top: 0; }
.prow:hover { background: var(--hover); }
.prow small, .cell-k { display: block; font-size: 11.5px; color: var(--fg-3); font-weight: 500; }
.prow strong { font-weight: 600; }
.who { display: flex; align-items: center; gap: 11px; min-width: 0; }
.who > span:last-child { min-width: 0; }
.who strong, .who small { overflow-wrap: anywhere; }
.utilmini { display: grid; gap: 5px; }
.utilmini .row { display: flex; justify-content: space-between; font-size: 12.5px; font-variant-numeric: tabular-nums; font-weight: 600; }
.chips { display: flex; flex-wrap: wrap; gap: 5px; min-width: 0; }
.chip {
  display: inline-flex; align-items: center; gap: 6px;
  padding: 3px 8px; border-radius: 6px;
  background: var(--surface-2); box-shadow: inset 0 0 0 1px var(--line);
  font-size: 12px; white-space: nowrap; max-width: 100%;
}
.chip.hit { box-shadow: inset 0 0 0 1.5px var(--accent); }
.pips { display: inline-flex; gap: 2px; }
.pips i { width: 5px; height: 9px; border-radius: 1.5px; background: var(--line); }
.pips i.on { background: var(--lvl-3); }
.projnames { font-size: 13px; overflow-wrap: anywhere; }

/* ---------- projects ---------- */
.ptable { display: grid; background: var(--surface); border: 1px solid var(--line); border-radius: var(--r); overflow: hidden; }
.pjhead, .pjrow {
  display: grid;
  grid-template-columns: minmax(210px, 1.7fr) 128px minmax(120px, .9fr) minmax(170px, 1.1fr) minmax(190px, 1.3fr);
  gap: 16px; align-items: center; padding: 11px 18px;
}
.pjhead { font-size: 12px; font-weight: 600; color: var(--fg-2); background: var(--surface-2); border-bottom: 1px solid var(--line); }
.pjrow { width: 100%; text-align: left; border: 0; border-top: 1px solid var(--line); background: transparent; color: inherit; }
.pjrow:nth-child(2) { border-top: 0; }
.pjrow:hover { background: var(--hover); }
.pjrow small { display: block; color: var(--fg-3); font-size: 11.5px; }
.pj-status { display: flex; flex-direction: column; align-items: flex-start; gap: 4px; }
.prog { height: 4px; border-radius: 999px; background: var(--surface-2); box-shadow: inset 0 0 0 1px var(--grid); margin-top: 6px; position: relative; overflow: hidden; }
.prog i { position: absolute; inset: 0 auto 0 0; background: var(--fg-3); border-radius: 999px; }
.staffbar { display: flex; gap: 2px; height: 8px; margin: 2px 0 6px; }
.staffbar i { border-radius: 999px; background: var(--s-conf); min-width: 4px; }
.staffbar i.open { background: var(--s-open); }
.staffbar i.none { background: var(--surface-2); box-shadow: inset 0 0 0 1px var(--line); flex: 1; }
.staffline { display: flex; flex-wrap: wrap; gap: 4px 8px; align-items: center; font-size: 12.5px; font-variant-numeric: tabular-nums; }

/* timeline */
.tl { --tl-label: 260px; position: relative; font-size: 13px; }
.tl-axis { display: grid; grid-template-columns: var(--tl-label) minmax(0, 1fr); height: 40px; }
.tl-axis-track { position: relative; }
.tl-axis-track span { position: absolute; top: 3px; font-size: 11px; color: var(--fg-3); padding-left: 6px; white-space: nowrap; font-weight: 600; letter-spacing: .02em; }
.tl-body { position: relative; }
.tl-grid { position: absolute; top: 0; bottom: 0; left: var(--tl-label); right: 0; pointer-events: none; }
.tl-grid i { position: absolute; top: -40px; bottom: 0; border-left: 1px solid var(--grid); }
.tl-grid .today { top: -19px; border-left: 2px solid var(--accent); z-index: 1; }
.tl-grid .today b { position: absolute; top: 0; left: 5px; font-size: 10.5px; line-height: 1; color: var(--accent-text); font-weight: 700; letter-spacing: .05em; text-transform: uppercase; }
.tl-row {
  position: relative;
  display: grid; grid-template-columns: var(--tl-label) minmax(0, 1fr);
  align-items: center; min-height: 46px; width: 100%;
  border: 0; border-top: 1px solid var(--line); background: transparent; color: inherit; text-align: left; padding: 0;
}
.tl-row:hover { background: var(--hover); }
.tl-label { padding: 7px 14px 7px 0; min-width: 0; display: grid; gap: 3px; }
.tl-label strong { font-weight: 600; overflow-wrap: anywhere; }
.tl-label .meta { display: flex; gap: 6px; flex-wrap: wrap; align-items: center; color: var(--fg-3); font-size: 11.5px; }
.tl-track { position: relative; height: 100%; min-height: 46px; }
.tl-bar { position: absolute; top: 50%; height: 12px; margin-top: -6px; border-radius: 4px; background: var(--s-conf); }
.tl-bar.planned { background: var(--s-tent); }
.tl-bar.hold, .tl-bar.done { background: var(--line-strong); }
.tl-bar.cut-l { border-top-left-radius: 0; border-bottom-left-radius: 0; }
.tl-bar.cut-r { border-top-right-radius: 0; border-bottom-right-radius: 0; }
.tl-bar .openmark { position: absolute; right: -4px; top: -4px; width: 8px; height: 8px; border-radius: 50%; background: var(--s-open); box-shadow: 0 0 0 2px var(--surface); }

/* ---------- heatmap ---------- */
.hm-wrap { overflow-x: auto; background: var(--surface); border: 1px solid var(--line); border-radius: var(--r); }
table.hm { border-collapse: separate; border-spacing: 0; width: 100%; }
.hm th, .hm td { padding: 0; }
.hm thead th { background: var(--surface-2); border-bottom: 1px solid var(--line); font-weight: 600; text-align: center; padding: 8px 2px 7px; }
.hm thead th.cur { box-shadow: inset 0 -2px 0 var(--accent); }
.hm .wk { display: block; font-family: var(--font-data); font-size: 11.5px; color: var(--fg); }
.hm .wd { display: block; font-size: 10.5px; color: var(--fg-3); font-weight: 500; white-space: nowrap; }
.hm .rowh {
  position: sticky; left: 0; z-index: 2;
  background: var(--surface);
  text-align: left; font-weight: 400;
  padding: 6px 12px 6px 14px;
  border-right: 1px solid var(--line);
  min-width: 168px; max-width: 220px;
}
.hm thead .rowh { background: var(--surface-2); z-index: 3; font-size: 12px; color: var(--fg-2); }
.hm .rowh button { all: unset; cursor: pointer; display: grid; gap: 1px; }
.hm .rowh button:focus-visible { outline: 2px solid var(--focus); outline-offset: 2px; border-radius: 4px; }
.hm .rowh strong { font-weight: 600; font-size: 13px; }
.hm .rowh small { color: var(--fg-3); font-size: 11.5px; }
.hm td { padding: 2px; }
.hm tr.team th, .hm tr.team td { background: var(--surface-2); border-top: 1px solid var(--line); border-bottom: 1px solid var(--line); }
.hm tr.team .rowh { font-size: 12px; font-weight: 700; color: var(--fg-2); text-transform: uppercase; letter-spacing: .06em; }
.hm tr.team .rowh small { text-transform: none; letter-spacing: 0; font-weight: 500; }
.cell {
  display: grid; place-items: center;
  width: 100%; min-width: 46px; height: 32px;
  border: 0; border-radius: 5px;
  font-family: var(--font-data); font-size: 11.5px; font-weight: 500;
  background: var(--heat-0); color: var(--hi-0);
  position: relative;
  font-variant-numeric: tabular-nums;
  padding: 0;
}
.cell.sm { height: 22px; font-size: 10.5px; }
.cell.b1 { background: var(--heat-1); color: var(--hi-1); }
.cell.b2 { background: var(--heat-2); color: var(--hi-2); }
.cell.b3 { background: var(--heat-3); color: var(--hi-3); }
.cell.b4 { background: var(--heat-4); color: var(--hi-4); font-weight: 600; }
.cell.over { background: var(--heat-over); color: var(--hi-over); font-weight: 600; }
.cell.off { background: var(--heat-off); color: var(--hi-off); font-family: var(--font-ui); font-size: 11px; font-weight: 600; }
.cell.na { background: transparent; color: var(--fg-3); box-shadow: inset 0 0 0 1px var(--grid); }
.cell .pl { position: absolute; top: 3px; right: 3px; width: 6px; height: 6px; border-radius: 50%; background: currentColor; opacity: .85; }
button.cell:hover { filter: brightness(1.04); box-shadow: 0 0 0 2px var(--fg-2); }
.heat-legend { display: flex; flex-wrap: wrap; gap: 8px 14px; align-items: center; font-size: 12px; color: var(--fg-2); }
.heat-legend .scale { display: inline-flex; gap: 2px; align-items: center; }
.heat-legend .scale i { width: 24px; height: 14px; border-radius: 3px; display: inline-block; }
.heat-legend .ends { display: inline-flex; gap: 6px; align-items: center; }
.heat-legend .key { display: inline-flex; gap: 6px; align-items: center; }
.heat-legend .key i { width: 16px; height: 14px; border-radius: 3px; display: inline-block; position: relative; }
.heat-legend .pldemo { position: absolute; top: 2px; right: 2px; width: 5px; height: 5px; border-radius: 50%; background: var(--hi-1); }

/* ---------- skills matrix ---------- */
.mx-wrap { overflow: auto; max-height: 75vh; background: var(--surface); border: 1px solid var(--line); border-radius: var(--r); }
table.mx { border-collapse: separate; border-spacing: 0; }
.mx th, .mx td { padding: 0; }
.mx thead th { background: var(--surface-2); position: sticky; z-index: 2; }
.mx thead tr.cat th { top: 0; height: 30px; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: .06em; color: var(--fg-2); text-align: left; padding: 0 8px; border-left: 1px solid var(--line); white-space: nowrap; }
.mx thead tr.sk th { top: 30px; height: 172px; vertical-align: bottom; padding: 6px 2px 8px; border-bottom: 1px solid var(--line); }
.mx thead tr.sk th.first { border-left: 1px solid var(--line); }
.mx .rot { writing-mode: vertical-rl; transform: rotate(180deg); white-space: nowrap; font-size: 12px; font-weight: 600; font-stretch: 87.5%; display: inline-flex; align-items: center; gap: 5px; max-height: 158px; overflow: hidden; text-overflow: ellipsis; }
.mx .rot .ico { width: 12px; height: 12px; color: var(--crit); transform: rotate(180deg); }
.mx .rowh {
  position: sticky; left: 0; z-index: 1;
  background: var(--surface); text-align: left; font-weight: 400;
  padding: 4px 12px 4px 14px; border-right: 1px solid var(--line);
  min-width: 170px; max-width: 220px;
}
.mx thead .rowh { z-index: 3; background: var(--surface-2); vertical-align: bottom; padding-bottom: 10px; font-size: 12px; color: var(--fg-2); font-weight: 600; }
.mx .rowh strong { display: block; font-weight: 600; font-size: 13px; }
.mx .rowh small { display: block; color: var(--fg-3); font-size: 11.5px; }
.mx td { padding: 2px; text-align: center; }
.mx td.gstart { border-left: 1px solid var(--grid); }
.mx tr.team th { background: var(--surface-2); text-align: left; padding: 6px 14px; font-size: 11.5px; font-weight: 700; color: var(--fg-2); letter-spacing: .06em; text-transform: uppercase; border-top: 1px solid var(--line); border-bottom: 1px solid var(--line); position: sticky; left: 0; }
.mx tr.team td { background: var(--surface-2); border-top: 1px solid var(--line); border-bottom: 1px solid var(--line); }
.lvl {
  width: 30px; height: 28px; border-radius: 5px; border: 0;
  display: inline-grid; place-items: center;
  background: transparent; color: var(--fg-3);
  font-family: var(--font-data); font-size: 12px; font-weight: 600;
  padding: 0;
}
.lvl.l0::after { content: ""; width: 4px; height: 4px; border-radius: 50%; background: var(--line-strong); }
.lvl.l1 { background: var(--lvl-1); color: var(--li-1); }
.lvl.l2 { background: var(--lvl-2); color: var(--li-2); }
.lvl.l3 { background: var(--lvl-3); color: var(--li-3); }
.lvl.l4 { background: var(--lvl-4); color: var(--li-4); }
button.lvl:hover { box-shadow: 0 0 0 2px var(--fg-2); }
.mx tfoot th, .mx tfoot td { position: sticky; bottom: 0; background: var(--surface-2); border-top: 1px solid var(--line); }
.mx tfoot th { z-index: 2; left: 0; }
.mx tfoot td { font-family: var(--font-data); font-size: 12px; font-weight: 600; height: 30px; color: var(--fg-2); }
.mx tfoot td.thin { color: var(--crit); }
.lvl-legend { display: flex; flex-wrap: wrap; gap: 8px 14px; font-size: 12px; color: var(--fg-2); align-items: center; }
.lvl-legend span { display: inline-flex; gap: 6px; align-items: center; }
.lvl-legend .lvl { width: 22px; height: 20px; font-size: 11px; }
.pop {
  position: fixed; z-index: 60;
  background: var(--surface); border: 1px solid var(--line-strong); border-radius: 10px;
  box-shadow: var(--shadow-2); padding: 6px; display: grid; gap: 2px; min-width: 176px;
}
.pop .pop-t { font-size: 12px; color: var(--fg-2); padding: 4px 8px 6px; border-bottom: 1px solid var(--line); margin-bottom: 4px; max-width: 220px; }
.pop button { display: flex; align-items: center; gap: 10px; border: 0; background: transparent; padding: 6px 8px; border-radius: 6px; text-align: left; font-size: 13px; }
.pop button:hover, .pop button[aria-checked="true"] { background: var(--hover); }
.pop button[aria-checked="true"] { font-weight: 700; }
.pop .lvl { width: 22px; height: 20px; font-size: 11px; }

/* catalogue */
.sklist { list-style: none; margin: 0; padding: 0; display: grid; }
.skrow { display: grid; grid-template-columns: minmax(180px, 1.3fr) minmax(160px, 1.6fr) 130px auto; gap: 16px; align-items: center; padding: 10px 0; border-top: 1px solid var(--line); }
.skrow:first-child { border-top: 0; }
.dist { display: flex; height: 10px; gap: 2px; }
.dist i { border-radius: 2px; min-width: 3px; }
.dist i.l1 { background: var(--lvl-1); } .dist i.l2 { background: var(--lvl-2); } .dist i.l3 { background: var(--lvl-3); } .dist i.l4 { background: var(--lvl-4); }
.dist i.none { background: var(--surface-2); box-shadow: inset 0 0 0 1px var(--line); flex: 1; }
.dist-n { font-size: 11.5px; color: var(--fg-3); margin-top: 4px; font-variant-numeric: tabular-nums; }
.row-actions { display: flex; gap: 4px; justify-content: flex-end; }

/* ---------- drawer & modal ---------- */
dialog { color: var(--fg); }
dialog::backdrop { background: var(--scrim); }
dialog.drawer {
  margin: 0 0 0 auto; padding: 0; border: 0;
  width: min(680px, 100%); max-width: 100%;
  height: 100%; max-height: 100%;
  background: var(--surface);
  box-shadow: var(--shadow-2);
}
dialog.drawer[open] { display: flex; flex-direction: column; }
.dr-head {
  display: flex; align-items: flex-start; justify-content: space-between; gap: 12px;
  padding: calc(18px + env(safe-area-inset-top, 0px)) max(20px, env(safe-area-inset-right, 0px)) 16px 22px;
  border-bottom: 1px solid var(--line);
}
.dr-title { display: flex; gap: 14px; align-items: center; min-width: 0; }
.dr-title h2 { font-family: var(--font-display); font-stretch: 112%; font-weight: 800; font-size: 21px; letter-spacing: -0.015em; line-height: 1.15; overflow-wrap: anywhere; }
.dr-title p { color: var(--fg-2); margin-top: 3px; }
.dr-actions { display: flex; gap: 6px; flex: none; }
.dr-body { flex: 1; overflow-y: auto; padding: 18px max(20px, env(safe-area-inset-right, 0px)) calc(28px + env(safe-area-inset-bottom, 0px)) 22px; display: grid; gap: 22px; align-content: start; }
.dr-sec { display: grid; gap: 10px; min-width: 0; }
.dr-sec-h { display: flex; justify-content: space-between; align-items: center; gap: 10px; }
.dr-sec h3 { font-size: 13px; font-weight: 700; text-transform: uppercase; letter-spacing: .07em; color: var(--fg-2); }
.facts { display: grid; grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); gap: 12px 18px; }
.facts div { min-width: 0; }
.facts dt { font-size: 11.5px; color: var(--fg-3); font-weight: 600; }
.facts dd { margin: 2px 0 0; overflow-wrap: anywhere; }
dl.facts { margin: 0; }
.strip { display: grid; grid-template-columns: repeat(12, minmax(0, 1fr)); gap: 3px; }
.strip .cell { min-width: 0; height: 30px; }
.strip-labels { display: grid; grid-template-columns: repeat(12, minmax(0, 1fr)); gap: 3px; font-family: var(--font-data); font-size: 10.5px; color: var(--fg-3); text-align: center; }
.rows { display: grid; border: 1px solid var(--line); border-radius: 10px; overflow: hidden; }
.rowi { display: grid; grid-template-columns: minmax(0, 1fr) auto; gap: 10px; align-items: center; padding: 10px 12px; border-top: 1px solid var(--line); }
.rowi:first-child { border-top: 0; }
.rowi .t { font-weight: 600; overflow-wrap: anywhere; }
.rowi .d { color: var(--fg-2); font-size: 12.5px; display: flex; flex-wrap: wrap; gap: 4px 10px; align-items: center; margin-top: 2px; }
.rowi.past { opacity: .62; }
.linkish { all: unset; cursor: pointer; font-weight: 600; color: var(--fg); text-decoration: underline; text-decoration-color: var(--line-strong); text-underline-offset: 3px; }
.linkish:hover { text-decoration-color: currentColor; }
.linkish:focus-visible { outline: 2px solid var(--focus); outline-offset: 2px; border-radius: 3px; }
.skillgroups { display: grid; gap: 10px; }
.skillgroups h4 { font-size: 12px; color: var(--fg-3); font-weight: 600; margin-bottom: 5px; }
.desc { color: var(--fg-2); max-width: 65ch; }

dialog.modal {
  padding: 0; border: 1px solid var(--line); border-radius: 14px;
  width: min(600px, calc(100% - 32px)); max-height: calc(100% - 48px);
  background: var(--surface); box-shadow: var(--shadow-2);
}
dialog.modal.wide { width: min(820px, calc(100% - 32px)); }
dialog.modal[open] { display: flex; flex-direction: column; }
.md-head { display: flex; justify-content: space-between; align-items: flex-start; gap: 12px; padding: 18px 20px 12px; }
.md-head h2 { font-size: 18px; font-weight: 700; letter-spacing: -0.01em; }
.md-head p { color: var(--fg-2); font-size: 13px; margin-top: 4px; }
.md-body { padding: 4px 20px 18px; overflow-y: auto; display: grid; gap: 14px; }
.md-foot { display: flex; justify-content: flex-end; flex-wrap: wrap; gap: 8px; padding: 14px 20px; border-top: 1px solid var(--line); background: var(--surface-2); border-radius: 0 0 14px 14px; }
.md-foot .left { margin-right: auto; }
.form-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 14px 14px; }
.form-grid .full { grid-column: 1 / -1; }
.field .hint { font-size: 12px; color: var(--fg-3); }
.field .err { font-size: 12px; color: var(--crit); font-weight: 600; }
.check { display: flex; gap: 10px; align-items: flex-start; font-size: 13.5px; }
.check input { width: 18px; height: 18px; margin: 1px 0 0; accent-color: var(--accent); flex: none; }
.skills-editor { border: 1px solid var(--line); border-radius: 10px; padding: 12px 14px; display: grid; gap: 12px; }
.skills-editor legend { padding: 0 6px; margin-left: -6px; }
.skills-editor h4 { font-size: 11.5px; font-weight: 700; color: var(--fg-2); text-transform: uppercase; letter-spacing: .06em; }
.se-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(230px, 1fr)); gap: 6px 14px; margin-top: 6px; }
.se-row { display: grid; grid-template-columns: minmax(0, 1fr) 118px; gap: 8px; align-items: center; font-size: 13px; }
.se-row select { height: 30px; font-size: 12.5px; }
.radio-cards { display: grid; gap: 8px; }
.radio-cards label { display: flex; gap: 10px; padding: 10px 12px; border: 1px solid var(--line); border-radius: 10px; align-items: flex-start; }
.radio-cards label:has(input:checked) { border-color: var(--accent); background: var(--accent-soft); }
.radio-cards input { margin-top: 3px; accent-color: var(--accent); }
.radio-cards small { display: block; color: var(--fg-2); font-size: 12.5px; }
.warnlist { margin: 0; padding-left: 18px; color: var(--fg-2); font-size: 13px; display: grid; gap: 3px; }
.progress { height: 8px; border-radius: 999px; background: var(--surface-2); box-shadow: inset 0 0 0 1px var(--line); overflow: hidden; }
.progress i { display: block; height: 100%; background: var(--accent); width: 0; transition: width .2s; }

/* finder */
.finder-form { display: grid; grid-template-columns: minmax(150px, 1.4fr) 120px 1fr 1fr 100px; gap: 10px; align-items: end; }
.cands { display: grid; border: 1px solid var(--line); border-radius: 10px; overflow: hidden; }
.cand { display: grid; grid-template-columns: minmax(170px, 1.3fr) 110px minmax(150px, 1.2fr) auto; gap: 12px; align-items: center; padding: 10px 12px; border-top: 1px solid var(--line); }
.cand:first-child { border-top: 0; }
.fitbar { display: grid; grid-auto-flow: column; grid-auto-columns: minmax(0, 1fr); gap: 2px; height: 12px; }
.fitbar i { border-radius: 2px; background: var(--heat-0); box-shadow: inset 0 0 0 1px var(--grid); }
.fitbar i.ok { background: var(--good); box-shadow: none; }
.fitbar i.part { background: var(--warn); box-shadow: none; opacity: .75; }
.fitbar i.off { background: var(--heat-off); box-shadow: none; }

/* empty / loading states */
.state { background: var(--surface); border: 1px dashed var(--line-strong); border-radius: var(--r); padding: 36px 28px; display: grid; gap: 12px; justify-items: start; }
.state h2 { font-family: var(--font-display); font-stretch: 112%; font-size: 20px; font-weight: 800; letter-spacing: -0.01em; }
.state p { color: var(--fg-2); max-width: 60ch; }
.state .actions { display: flex; gap: 8px; flex-wrap: wrap; margin-top: 4px; }
.steps { margin: 2px 0 0; padding-left: 20px; color: var(--fg-2); display: grid; gap: 4px; }

/* tooltip & toast */
#tip {
  position: fixed; z-index: 1000; pointer-events: none;
  max-width: 300px; min-width: 170px;
  background: var(--fg); color: var(--surface);
  border-radius: 9px; padding: 9px 11px 10px;
  font-size: 12.5px; line-height: 1.35;
  box-shadow: var(--shadow-2);
}
.tip-t { font-weight: 700; margin-bottom: 6px; }
.tip-r { display: grid; grid-template-columns: 12px auto 1fr; gap: 7px; align-items: center; margin-top: 3px; }
.tip-r strong { font-variant-numeric: tabular-nums; font-weight: 700; }
.tip-r span { opacity: .78; }
.tip-k { width: 12px; height: 3px; border-radius: 2px; }
.tip-f { margin-top: 7px; padding-top: 6px; border-top: 1px solid color-mix(in srgb, var(--surface) 25%, transparent); opacity: .85; }
#toast {
  position: fixed; left: 50%; bottom: calc(20px + env(safe-area-inset-bottom, 0px)); transform: translateX(-50%);
  z-index: 1100; max-width: min(520px, calc(100% - 32px));
  background: var(--fg); color: var(--surface);
  padding: 11px 16px; border-radius: 10px; font-size: 13.5px; font-weight: 500;
  box-shadow: var(--shadow-2);
}


/* ---------- Impact@Scale ---------- */
.k-home { --kc: var(--k-home); --kink: var(--ki-home); }
.k-outcome { --kc: var(--k-outcome); --kink: var(--ki-outcome); }
.k-network { --kc: var(--k-network); --kink: var(--ki-network); }
.k-free { --kc: var(--surface-2); --kink: var(--fg-2); }
.kd { width: 10px; height: 10px; border-radius: 3px; display: inline-block; flex: none; background: var(--kc); }
.kd.k-free { box-shadow: inset 0 0 0 1px var(--line-strong); }
.sw.k-home, .sw.k-outcome, .sw.k-network { background: var(--kc); }
.sw.k-free { background: var(--surface-2); box-shadow: inset 0 0 0 1px var(--line-strong); }
.ktag { display: inline-flex; align-items: center; gap: 6px; font-size: 12px; font-weight: 600; color: var(--fg-2); white-space: nowrap; }
table.data .ktag { font-size: 13px; color: var(--fg); font-weight: 500; }
.seg button .kd { margin-right: 6px; vertical-align: -1px; }
abbr[title] { text-decoration: none; cursor: help; }
.small { font-size: 12px; }

.sec-h { display: flex; flex-wrap: wrap; align-items: flex-end; justify-content: space-between; gap: 10px 18px; padding-top: 16px; margin-top: 4px; border-top: 1px solid var(--line); scroll-margin-top: 12px; }
.sec-h h2 { font-family: var(--font-display); font-stretch: 112%; font-weight: 800; font-size: 19px; letter-spacing: -0.01em; }
.sec-h p { color: var(--fg-2); font-size: 13px; margin-top: 3px; max-width: 78ch; }
.sec-h p strong { color: var(--fg); }
.sec-tools { display: flex; flex-wrap: wrap; align-items: flex-end; gap: 8px 10px; }
.sec-tools .field select { min-width: 170px; }

/* horizontal stacked bars: 2px surface gaps between segments, rounded ends */
.hstack { position: relative; display: flex; gap: 2px; height: 12px; width: 100%; min-width: 0; }
.hstack.lg { height: 28px; }
.hstack > .hs { flex: 0 1 auto; min-width: 2px; height: 100%; background: var(--kc); display: grid; place-items: center; overflow: hidden; font-style: normal; }
.hstack > .hs:first-of-type { border-top-left-radius: 4px; border-bottom-left-radius: 4px; }
.hstack > .hs:last-of-type { border-top-right-radius: 4px; border-bottom-right-radius: 4px; }
.hstack > .hs.k-free { background: var(--surface-2); box-shadow: inset 0 0 0 1px var(--line-strong); }
.hstack > .hs b { font-size: 12px; font-weight: 700; color: var(--kink); font-variant-numeric: tabular-nums; line-height: 1; }
.hstack > .ref { position: absolute; top: -4px; bottom: -4px; width: 0; border-left: 2px solid var(--heat-over); z-index: 1; margin-left: -1px; }
.split-bar { margin: 4px 0 2px; }
.table-wrap.tight { margin-top: 12px; }
table.data th[scope="row"] { font-weight: 500; text-align: left; }
table.data tfoot th, table.data tfoot td { font-weight: 650; border-top: 1px solid var(--line-strong); border-bottom: 0; background: var(--surface-2); }
table.data td.delta { color: var(--fg-2); }
table.data td.c-bar { width: 34%; min-width: 150px; text-align: left; }
table.data th.c-bar { text-align: left; }
.l-short { display: none; }
.clamp1 { display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; }
.note { display: flex; gap: 8px; align-items: flex-start; font-size: 12.5px; color: var(--fg-2); margin-top: 10px; }
.note .ico { width: 16px; height: 16px; color: var(--accent); margin-top: 1px; }
.note.warn .ico { color: var(--crit); }

.focus-t th[scope="row"], .focus-t thead th:first-child { white-space: normal; min-width: 230px; }
.focus-t tr.f-area th, .focus-t tr.f-area td { font-weight: 650; background: var(--surface-2); }
.focus-t tr.f-area th .linkish { font-weight: 650; text-decoration-color: transparent; display: inline-flex; align-items: center; text-align: left; }
.focus-t tr.f-area th .linkish:hover { text-decoration-color: currentColor; }
.focus-t tr.f-sub th { padding-left: 42px; font-weight: 400; color: var(--fg-2); }
.focus-t tr.zero th, .focus-t tr.zero td { color: var(--fg-3); }
.focus-t tr.on th, .focus-t tr.on td { background: var(--accent-soft); }
.focus-t tr.none th small { display: block; color: var(--warn); font-weight: 500; font-size: 11.5px; }
.focus-t .fn { display: inline-grid; place-items: center; width: 22px; height: 22px; border-radius: 6px; background: var(--surface); box-shadow: inset 0 0 0 1px var(--line); font-size: 11.5px; font-weight: 700; margin-right: 10px; flex: none; color: var(--fg-2); }
.focus-t tr.on .fn { background: var(--accent); color: var(--accent-ink); box-shadow: none; }

.alloc-t th[scope="row"] { white-space: normal; min-width: 150px; }
.alloc-t th[scope="row"] small, .alloc-t td small { display: block; color: var(--fg-3); font-size: 11.5px; font-weight: 400; }
.alloc-t td.c-avail { font-weight: 600; }
.alloc-t td.c-free.neg { color: var(--crit); font-weight: 700; }
.alloc-t .c-top { text-align: left; white-space: normal; min-width: 190px; max-width: 280px; font-size: 12.5px; }
.alloc-t td.c-sel { font-weight: 700; }

.pjgroup { display: flex; gap: 6px 10px; align-items: center; flex-wrap: wrap; padding: 10px 18px; background: var(--surface-2); border-top: 1px solid var(--line); font-size: 13px; }
.pjhead + .pjgroup { border-top: 0; }
.pjgroup .faint { font-size: 12px; flex: 1 1 300px; }
.flab { display: block; font-size: 11.5px; color: var(--fg-2); margin-top: 3px; }
.flab.none { color: var(--warn); font-weight: 600; }
.pj-status .ktag { margin-bottom: 2px; }
.focus-box { display: grid; gap: 2px; padding: 10px 12px; border-radius: 10px; background: var(--surface-2); box-shadow: inset 0 0 0 1px var(--line); }
.focus-box > .faint:first-child { font-size: 11px; text-transform: uppercase; letter-spacing: .07em; font-weight: 700; }
.register { display: grid; gap: 10px; margin: 0; padding: 12px 14px; border-left: 3px solid var(--k-outcome); background: var(--surface-2); border-radius: 0 10px 10px 0; }
.register dt { font-size: 11.5px; color: var(--fg-3); font-weight: 600; }
.register dd { margin: 2px 0 0; }
.psplit { display: grid; gap: 8px; }
.legend.vals { margin: 2px 0 0; }
.legend.vals strong { font-variant-numeric: tabular-nums; color: var(--fg); }
.flist { list-style: none; margin: 4px 0 0; padding: 0; display: grid; border: 1px solid var(--line); border-radius: 10px; overflow: hidden; }
.flist li { display: grid; grid-template-columns: minmax(0, 1fr) auto 46px; gap: 10px; align-items: center; padding: 7px 12px; border-top: 1px solid var(--line); font-size: 13px; }
.flist li:first-child { border-top: 0; }
.flist li strong { text-align: right; }
.kmini { display: inline-flex; gap: 3px; }

.guide h3 { font-size: 12.5px; text-transform: uppercase; letter-spacing: .07em; color: var(--fg-2); margin: 2px 0 8px; }
.guide-kinds { display: grid; gap: 10px; margin: 0 0 18px; }
.guide-kinds dd { margin: 3px 0 0; color: var(--fg-2); font-size: 13px; }
.guide-areas { margin: 0; padding-left: 22px; display: grid; gap: 14px; }
.guide-areas > li > strong { font-size: 14px; }
.guide-areas p { font-size: 13px; margin-top: 2px; }
.guide-areas ul { margin: 6px 0 0; padding-left: 16px; display: grid; gap: 6px; }
.guide-areas ul li span { font-weight: 600; font-size: 13px; }
.guide-areas ul li small { display: block; color: var(--fg-2); font-size: 12.5px; }

/* ---------- responsive ---------- */
@media (max-width: 1180px) {
  .prow { grid-template-columns: minmax(190px, 1.5fr) minmax(120px, 1fr) minmax(110px, .9fr) 86px minmax(150px, 1.3fr); }
  .prow .c-skills { display: none; }
  .tl { --tl-label: 220px; }
}
@media (max-width: 960px) {
  .app { grid-template-columns: minmax(0, 1fr); gap: 14px; padding-block: 12px 32px; }
  .rail { position: static; gap: 12px; }
  .brand { padding: 0; }
  .nav { grid-template-columns: repeat(5, minmax(0, 1fr)); gap: 4px; background: var(--surface); border: 1px solid var(--line); border-radius: 12px; padding: 4px; }
  .nav a { flex-direction: column; gap: 3px; padding: 7px 2px; font-size: 11.5px; text-align: center; justify-content: center; }
  .nav a[aria-current="page"] { background: var(--accent-soft); box-shadow: none; }
  .rail-foot { display: none; }
  .kpis { grid-template-columns: repeat(2, minmax(0, 1fr)); }
  .cols { grid-template-columns: minmax(0, 1fr); }
  .pjhead { display: none; }
  .pjrow { grid-template-columns: minmax(0, 1fr) minmax(0, 1fr); gap: 10px 16px; }
  .pjrow .pj-name { grid-column: 1 / -1; }
  .prow { grid-template-columns: minmax(0, 1.4fr) minmax(0, 1fr) minmax(0, 1fr); gap: 10px 16px; }
  .prow .c-free, .prow .c-proj { display: none; }
  .finder-form { grid-template-columns: repeat(2, minmax(0, 1fr)); }
  .finder-form .f-skill { grid-column: 1 / -1; }
  .cand { grid-template-columns: minmax(0, 1fr) auto; }
  .cand .c-level, .cand .c-fit { grid-column: 1 / -1; }
  .skrow { grid-template-columns: minmax(0, 1fr) auto; }
  .skrow .c-dist, .skrow .c-adv { grid-column: 1 / -1; }
  .sec-h { align-items: flex-start; }
  .alloc-t .c-top { display: none; }
}
@media (max-width: 640px) {
  .topbar { align-items: flex-start; }
  .top-actions { width: 100%; }
  .top-actions .btn { flex: 1 1 auto; }
  .filters > .field, .filters > .field.grow { flex: 1 1 calc(50% - 8px); }
  .filters > .field select, .filters > .field input { width: 100%; }
  .filters-end { margin-left: 0; width: 100%; }
  .filters-end .btn { flex: 1 1 auto; }
  .panel { padding: 16px 14px 16px; }
  .kpi-value { font-size: 26px; }
  .alert { grid-template-columns: minmax(0, 1fr) auto; }
  .alert .alert-sev { grid-column: 1 / -1; }
  .prow { grid-template-columns: minmax(0, 1fr) 110px; padding: 12px 14px; }
  .prow .c-team { display: none; }
  .tl-axis { grid-template-columns: 0 minmax(0, 1fr); }
  .tl-grid { left: 0; }
  .tl-row { grid-template-columns: minmax(0, 1fr); padding: 8px 0 2px; }
  .tl-label { padding: 0 0 4px; position: relative; z-index: 2; background: var(--surface); }
  .tl-row:hover .tl-label { background: var(--hover); }
  .tl-axis-track span:nth-child(even) { visibility: hidden; }
  .tl-track { min-height: 22px; }
  .form-grid { grid-template-columns: minmax(0, 1fr); }
  .bar-row, .bar-axis { grid-template-columns: minmax(80px, 30%) minmax(0, 1fr) 64px; gap: 8px; }
  dialog.modal { width: calc(100% - 20px); max-height: calc(100% - 20px); }
  .dr-head { padding-left: max(16px, env(safe-area-inset-left, 0px)); }
  .dr-body { padding-left: max(16px, env(safe-area-inset-left, 0px)); }
  .strip .cell { font-size: 9.5px; }
  .sec-tools { width: 100%; }
  .sec-tools .field { flex: 1 1 calc(50% - 8px); }
  .sec-tools .field select { min-width: 0; width: 100%; }
  .alloc-t .c-k, .alloc-t .c-avail { display: none; }
  .alloc-t th[scope="row"] { min-width: 112px; }
  table.data th, table.data td { padding: 7px 8px; }
  table.data td.c-bar { min-width: 96px; }
  .focus-t .c-bar { display: none; }
  .l-long { position: absolute; width: 1px; height: 1px; overflow: hidden; clip: rect(0 0 0 0); white-space: nowrap; }
  .l-short { display: inline; }
  .split-t .ktag { white-space: normal; }
  .focus-t th[scope="row"], .focus-t thead th:first-child { min-width: 170px; }
  .focus-t tr.f-sub th { padding-left: 20px; }
}
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after { transition: none !important; animation: none !important; }
}

</style>
<div class="app">
  <aside class="rail">
    <div class="brand">
      <svg class="mark" viewBox="0 0 34 34" aria-hidden="true">
        <rect x="1" y="1" width="9.5" height="9.5" rx="2.2" style="fill:var(--heat-1)"/>
        <rect x="12.25" y="1" width="9.5" height="9.5" rx="2.2" style="fill:var(--heat-3)"/>
        <rect x="23.5" y="1" width="9.5" height="9.5" rx="2.2" style="fill:var(--heat-4)"/>
        <rect x="1" y="12.25" width="9.5" height="9.5" rx="2.2" style="fill:var(--heat-2)"/>
        <rect x="12.25" y="12.25" width="9.5" height="9.5" rx="2.2" style="fill:var(--heat-4)"/>
        <rect x="23.5" y="12.25" width="9.5" height="9.5" rx="2.2" style="fill:var(--heat-over)"/>
        <rect x="1" y="23.5" width="9.5" height="9.5" rx="2.2" style="fill:var(--heat-0);stroke:var(--line-strong);stroke-width:1"/>
        <rect x="12.25" y="23.5" width="9.5" height="9.5" rx="2.2" style="fill:var(--heat-2)"/>
        <rect x="23.5" y="23.5" width="9.5" height="9.5" rx="2.2" style="fill:var(--heat-3)"/>
      </svg>
      <div>
        <div class="brand-name">Impact@Scale Planner</div>
        <div class="brand-week" id="weekStamp">&nbsp;</div>
      </div>
    </div>
    <nav class="nav" aria-label="Views" id="nav"></nav>
    <div class="rail-foot"><div class="conn" id="conn"></div></div>
  </aside>
  <div class="main">
    <header class="topbar">
      <div>
        <h1 id="viewTitle">Dashboard</h1>
        <p class="sub" id="viewSub">&nbsp;</p>
      </div>
      <div class="top-actions" id="topActions"></div>
    </header>
    <div id="banners" role="status"></div>
    <main id="view" tabindex="-1"></main>
  </div>
</div>
<dialog class="drawer" id="drawer" aria-labelledby="drawerTitle"></dialog>
<dialog class="modal" id="modal" aria-labelledby="modalTitle"></dialog>
<div id="tip" role="tooltip" hidden></div>
<div id="toast" role="status" aria-live="polite" hidden></div>

<script>
(() => {
'use strict';
const SEED_DATA = {"refMonday":"2026-11-23","docs":{"skills":{"sk_etf":{"name":"ETF product structuring","category":"Product & structuring","critical":true},"sk_index":{"name":"Index methodology","category":"Product & structuring","critical":true},"sk_events":{"name":"Fund launch & lifecycle events","category":"Product & structuring","critical":true},"sk_regdoc":{"name":"Regulatory documentation (KID, prospectus)","category":"Product & structuring","critical":true},"sk_ucits":{"name":"UCITS & ICAV framework","category":"Product & structuring","critical":false},"sk_perf":{"name":"Performance & risk analytics","category":"Analytics & data","critical":false},"sk_backtest":{"name":"Backtesting & quant research","category":"Analytics & data","critical":false},"sk_python":{"name":"Python","category":"Analytics & data","critical":false},"sk_sql":{"name":"SQL & data modelling","category":"Analytics & data","critical":false},"sk_powerbi":{"name":"Power BI","category":"Analytics & data","critical":false},"sk_automation":{"name":"Process automation & AI tools","category":"Analytics & data","critical":false},"sk_client":{"name":"Client presentations","category":"Client & market","critical":false},"sk_content":{"name":"Product content & marketing","category":"Client & market","critical":false},"sk_compintel":{"name":"Competitor & market intelligence","category":"Client & market","critical":false},"sk_rfp":{"name":"RfP / RFI responses","category":"Client & market","critical":false},"sk_esg":{"name":"ESG methodology","category":"Sustainability","critical":true},"sk_sfdr":{"name":"SFDR & sustainability reporting","category":"Sustainability","critical":false},"sk_pm":{"name":"Project management","category":"Delivery & governance","critical":false},"sk_stake":{"name":"Stakeholder management","category":"Delivery & governance","critical":false}},"people":{"p01":{"name":"Claire Fontaine","role":"Head of Strategy & Governance","home":"spg","team":"Strategy & Governance","location":"Luxembourg","email":"claire.fontaine@example.com","type":"Employee","fte":100,"startDate":"2016-04-01","endDate":"","skills":{"sk_stake":4,"sk_pm":3,"sk_etf":3,"sk_compintel":3},"notes":"","sample":true},"p02":{"name":"Matteo Ricci","role":"Governance & Controls Manager","home":"spg","team":"Strategy & Governance","location":"Luxembourg","email":"matteo.ricci@example.com","type":"Employee","fte":80,"startDate":"2019-09-02","endDate":"","skills":{"sk_ucits":4,"sk_regdoc":3,"sk_stake":3,"sk_pm":2},"notes":"","sample":true},"p03":{"name":"Hannah Krüger","role":"Index Strategist","home":"isa","team":"Index & Investment Strategy","location":"Frankfurt","email":"hannah.kruger@example.com","type":"Employee","fte":100,"startDate":"2018-02-01","endDate":"","skills":{"sk_index":4,"sk_backtest":4,"sk_python":3,"sk_etf":3},"notes":"","sample":true},"p04":{"name":"Rahul Mehta","role":"Quantitative Analyst","home":"isa","team":"Index & Investment Strategy","location":"London","email":"rahul.mehta@example.com","type":"Employee","fte":100,"startDate":"2021-06-14","endDate":"","skills":{"sk_backtest":4,"sk_python":4,"sk_perf":3,"sk_sql":3,"sk_index":2},"notes":"","sample":true},"p05":{"name":"Sophie Lambert","role":"Performance Analyst","home":"isa","team":"Performance & Lifecycle Analytics","location":"Luxembourg","email":"sophie.lambert@example.com","type":"Employee","fte":60,"startDate":"2017-10-02","endDate":"","skills":{"sk_perf":4,"sk_powerbi":3,"sk_sql":2,"sk_index":2},"notes":"","sample":true},"p06":{"name":"Jonas Weber","role":"Product Events Lead","home":"arp","team":"Product Events","location":"Luxembourg","email":"jonas.weber@example.com","type":"Employee","fte":100,"startDate":"2015-03-02","endDate":"","skills":{"sk_events":4,"sk_etf":4,"sk_ucits":3,"sk_pm":3,"sk_regdoc":3},"notes":"","sample":true},"p07":{"name":"Laura Pereira","role":"Product Events Specialist","home":"arp","team":"Product Events","location":"Luxembourg","email":"laura.pereira@example.com","type":"Employee","fte":100,"startDate":"2022-01-10","endDate":"","skills":{"sk_events":3,"sk_regdoc":3,"sk_etf":2,"sk_automation":2},"notes":"","sample":true},"p08":{"name":"Tom Reinert","role":"Product Data Analyst","home":"arp","team":"Product Maintenance & Data","location":"Luxembourg","email":"tom.reinert@example.com","type":"Employee","fte":100,"startDate":"2020-05-04","endDate":"","skills":{"sk_sql":3,"sk_regdoc":3,"sk_events":2,"sk_automation":2},"notes":"","sample":true},"p09":{"name":"Aoife Byrne","role":"Platform Architect","home":"arp","team":"Platform Development","location":"Dublin","email":"aoife.byrne@example.com","type":"Employee","fte":100,"startDate":"2019-01-07","endDate":"","skills":{"sk_etf":4,"sk_ucits":4,"sk_events":3,"sk_pm":3},"notes":"","sample":true},"p10":{"name":"Felix Hartmann","role":"Product Intelligence Manager","home":"pic","team":"Product Intelligence","location":"Frankfurt","email":"felix.hartmann@example.com","type":"Employee","fte":100,"startDate":"2018-11-01","endDate":"","skills":{"sk_compintel":4,"sk_powerbi":3,"sk_content":3,"sk_stake":3},"notes":"","sample":true},"p11":{"name":"Marta Nowak","role":"Market Intelligence Analyst","home":"pic","team":"Product Intelligence","location":"Frankfurt","email":"marta.nowak@example.com","type":"Contractor","fte":100,"startDate":"2026-03-02","endDate":"2027-03-31","skills":{"sk_compintel":3,"sk_powerbi":3,"sk_python":2},"notes":"","sample":true},"p12":{"name":"Daniel Costa","role":"Data Engineer","home":"dwe","team":"Data & Workflow Engineering","location":"Luxembourg","email":"daniel.costa@example.com","type":"Employee","fte":100,"startDate":"2021-02-01","endDate":"","skills":{"sk_python":4,"sk_sql":4,"sk_powerbi":3,"sk_automation":3},"notes":"","sample":true},"p13":{"name":"Mei Lin","role":"Automation Developer","home":"dwe","team":"Data & Workflow Engineering","location":"London","email":"mei.lin@example.com","type":"Employee","fte":100,"startDate":"2023-04-03","endDate":"","skills":{"sk_automation":4,"sk_python":3,"sk_sql":2},"notes":"","sample":true},"p14":{"name":"Oliver Grant","role":"Equity Product Specialist","home":"psp","team":"Equity Product Specialists","location":"London","email":"oliver.grant@example.com","type":"Employee","fte":100,"startDate":"2016-07-01","endDate":"","skills":{"sk_client":4,"sk_content":4,"sk_rfp":3,"sk_etf":3},"notes":"","sample":true},"p15":{"name":"Isabel Moreau","role":"Equity Product Specialist","home":"psp","team":"Equity Product Specialists","location":"Luxembourg","email":"isabel.moreau@example.com","type":"Employee","fte":80,"startDate":"2020-09-01","endDate":"","skills":{"sk_client":3,"sk_content":3,"sk_rfp":3,"sk_esg":2},"notes":"","sample":true},"p16":{"name":"Niklas Bauer","role":"Fixed Income Product Specialist","home":"psp","team":"Fixed Income Product Specialists","location":"Frankfurt","email":"niklas.bauer@example.com","type":"Employee","fte":100,"startDate":"2017-05-15","endDate":"","skills":{"sk_client":4,"sk_rfp":4,"sk_etf":3,"sk_index":2},"notes":"","sample":true},"p17":{"name":"Chiara Esposito","role":"Fixed Income Product Specialist","home":"psp","team":"Fixed Income Product Specialists","location":"Milan","email":"chiara.esposito@example.com","type":"Employee","fte":100,"startDate":"2022-03-01","endDate":"","skills":{"sk_client":3,"sk_rfp":3,"sk_content":2},"notes":"","sample":true},"p18":{"name":"Emma Lindqvist","role":"ESG Product Specialist","home":"pss","team":"Product Sustainability","location":"Luxembourg","email":"emma.lindqvist@example.com","type":"Employee","fte":100,"startDate":"2019-08-19","endDate":"","skills":{"sk_esg":4,"sk_sfdr":4,"sk_client":3,"sk_regdoc":2},"notes":"","sample":true}},"projects":{"h01":{"kind":"home","name":"Strategy, governance & senior management reporting","focus":"spg-core","leadId":"p01","status":"Active","priority":"Medium","startDate":"2026-01-05","endDate":"","code":"","sponsor":"","purpose":"Business-line strategy, product governance fora and reporting to senior management.","why":"","deprio":"","reviewDate":"","decision":"","description":"","sample":true},"h02":{"kind":"home","name":"PPWS operating model & Impact@Scale","focus":"spg-init","leadId":"p01","status":"Active","priority":"Medium","startDate":"2026-09-01","endDate":"","code":"","sponsor":"","purpose":"Run the Impact@Scale Forum, registers and monthly allocation check-in.","why":"","deprio":"","reviewDate":"","decision":"","description":"","sample":true},"h03":{"kind":"home","name":"Index & investment strategy development","focus":"isa-idea","leadId":"p03","status":"Active","priority":"Medium","startDate":"2026-01-05","endDate":"","code":"","sponsor":"","purpose":"","why":"","deprio":"","reviewDate":"","decision":"","description":"","sample":true},"h04":{"kind":"home","name":"Performance & lifecycle analytics","focus":"isa-life","leadId":"p04","status":"Active","priority":"Medium","startDate":"2026-01-05","endDate":"","code":"","sponsor":"","purpose":"","why":"","deprio":"","reviewDate":"","decision":"","description":"","sample":true},"h05":{"kind":"home","name":"Product events: launches, listings & changes","focus":"arp-events","leadId":"p06","status":"Active","priority":"Medium","startDate":"2026-01-05","endDate":"","code":"","sponsor":"","purpose":"","why":"","deprio":"","reviewDate":"","decision":"","description":"","sample":true},"h06":{"kind":"home","name":"Product maintenance & data quality","focus":"arp-maint","leadId":"p08","status":"Active","priority":"Medium","startDate":"2026-01-05","endDate":"","code":"","sponsor":"","purpose":"","why":"","deprio":"","reviewDate":"","decision":"","description":"","sample":true},"h07":{"kind":"home","name":"Platform development & wrapper architecture","focus":"arp-dev","leadId":"p09","status":"Active","priority":"Medium","startDate":"2026-01-05","endDate":"","code":"","sponsor":"","purpose":"","why":"","deprio":"","reviewDate":"","decision":"","description":"","sample":true},"h08":{"kind":"home","name":"Product-event process optimisation","focus":"arp-proc","leadId":"p06","status":"Active","priority":"Medium","startDate":"2026-01-05","endDate":"","code":"","sponsor":"","purpose":"","why":"","deprio":"","reviewDate":"","decision":"","description":"","sample":true},"h09":{"kind":"home","name":"Product knowledge base","focus":"pic-know","leadId":"p10","status":"Active","priority":"Medium","startDate":"2026-01-05","endDate":"","code":"","sponsor":"","purpose":"","why":"","deprio":"","reviewDate":"","decision":"","description":"","sample":true},"h10":{"kind":"home","name":"Market & opportunity intelligence","focus":"pic-comm","leadId":"p10","status":"Active","priority":"Medium","startDate":"2026-01-05","endDate":"","code":"","sponsor":"","purpose":"","why":"","deprio":"","reviewDate":"","decision":"","description":"","sample":true},"h11":{"kind":"home","name":"Data, automation & tools","focus":"dwe-tools","leadId":"p12","status":"Active","priority":"Medium","startDate":"2026-01-05","endDate":"","code":"","sponsor":"","purpose":"","why":"","deprio":"","reviewDate":"","decision":"","description":"","sample":true},"h12":{"kind":"home","name":"Client, RfP & content work","focus":"psp-client","leadId":"p14","status":"Active","priority":"Medium","startDate":"2026-01-05","endDate":"","code":"","sponsor":"","purpose":"","why":"","deprio":"","reviewDate":"","decision":"","description":"","sample":true},"h13":{"kind":"home","name":"Sustainability methodology & SFDR","focus":"pss-esg","leadId":"p18","status":"Active","priority":"Medium","startDate":"2026-01-05","endDate":"","code":"","sponsor":"","purpose":"","why":"","deprio":"","reviewDate":"","decision":"","description":"","sample":true},"h14":{"kind":"home","name":"Training, people management & administration","focus":"pdm-admin","leadId":"p01","status":"Active","priority":"Medium","startDate":"2026-01-05","endDate":"","code":"","sponsor":"","purpose":"","why":"","deprio":"","reviewDate":"","decision":"","description":"","sample":true},"h15":{"kind":"home","name":"Legacy data extracts for Distribution","focus":"oos-handover","leadId":"p08","status":"Active","priority":"Medium","startDate":"2026-01-05","endDate":"","code":"","sponsor":"","purpose":"","why":"","deprio":"","reviewDate":"","decision":"","description":"Monthly extracts still produced for another team. To document, automate and hand over.","sample":true},"o01":{"kind":"outcome","name":"Active ETF range launch","focus":"arp-events","leadId":"p06","status":"Active","priority":"High","startDate":"2026-09-07","endDate":"2027-03-31","code":"OUT-2026-004","sponsor":"Head of PP&WS","purpose":"Launch four active ETFs on the existing ICAV by the end of Q1 2027.","why":"Needs legal, operational, index and client readiness across five teams: more than a routine product event.","deprio":"Non-urgent listing extensions paused until February; quarterly peer review moved to the lifecycle team.","reviewDate":"","decision":"","description":"Decision gates: product approval (done), legal readiness (January), go-live (March).","sample":true},"o02":{"kind":"outcome","name":"ICAV intake & prospectus overhaul","focus":"arp-dev","leadId":"p09","status":"Active","priority":"High","startDate":"2026-10-05","endDate":"2027-06-30","code":"OUT-2026-006","sponsor":"COO PP&WS","purpose":"Move the remaining funds onto the ICAV and simplify the prospectus.","why":"One-off platform change with a clear end state and a hand-over to BAU maintenance.","deprio":"Platform clean-up backlog paused until the intake is done.","reviewDate":"","decision":"","description":"","sample":true},"o03":{"kind":"outcome","name":"Securities lending for ESG funds","focus":"arp-dev","leadId":"p18","status":"Planned","priority":"Medium","startDate":"2026-12-07","endDate":"2027-05-28","code":"OUT-2026-008","sponsor":"Head of PP&WS","purpose":"Introduce an ESG-compliant securities lending programme for sustainable ETFs.","why":"New capability that needs sustainability, platform and client expertise together.","deprio":"","reviewDate":"","decision":"","description":"","sample":true},"o04":{"kind":"outcome","name":"Tokenised share class pilot","focus":"arp-dev","leadId":"","status":"Planned","priority":"Medium","startDate":"2027-01-11","endDate":"2027-06-30","code":"OUT-2026-009","sponsor":"Head of PP&WS","purpose":"Test a tokenised share class for one fund with a partner platform.","why":"Experimental structure with no BAU owner yet.","deprio":"","reviewDate":"","decision":"","description":"","sample":true},"o05":{"kind":"outcome","name":"Product data model clean-up","focus":"arp-maint","leadId":"p08","status":"On hold","priority":"Low","startDate":"2026-08-03","endDate":"2026-12-18","code":"OUT-2026-003","sponsor":"COO PP&WS","purpose":"Retire duplicate product attributes in the product master.","why":"","deprio":"","reviewDate":"","decision":"","description":"Paused: waiting for the new data platform.","sample":true},"o06":{"kind":"outcome","name":"Fixed income ladder ETFs","focus":"arp-events","leadId":"p16","status":"Completed","priority":"Medium","startDate":"2026-03-02","endDate":"2026-10-30","code":"OUT-2026-001","sponsor":"Head of PP&WS","purpose":"Launch a range of target-maturity bond ETFs.","why":"","deprio":"","reviewDate":"","decision":"","description":"Handed over to Product Events and the Fixed Income Product Domain.","sample":true},"o07":{"kind":"outcome","name":"Client intelligence dashboard","focus":"dwe-tools","leadId":"p12","status":"Active","priority":"Medium","startDate":"2026-11-02","endDate":"2027-02-26","code":"OUT-2026-007","sponsor":"Head of Product Specialists","purpose":"One dashboard of client feedback, flows and opportunities for Product Specialists.","why":"Cross-team build with a defined end; afterwards owned by Product Intelligence.","deprio":"","reviewDate":"","decision":"","description":"","sample":true},"n01":{"kind":"network","name":"Product Domain: Fixed Income","focus":"psp-domain","leadId":"p16","status":"Active","priority":"Medium","startDate":"2026-01-05","endDate":"","code":"","sponsor":"","purpose":"Connect fixed income product, index and client expertise across teams.","why":"","deprio":"","reviewDate":"2026-12-15","decision":"Continue","description":"Products: bond ETFs and target-maturity range. Regions: Europe, UK.","sample":true},"n02":{"kind":"network","name":"Product Domain: Thematic & Sustainable Equity","focus":"psp-domain","leadId":"p15","status":"Active","priority":"Medium","startDate":"2026-04-01","endDate":"","code":"","sponsor":"","purpose":"Shared view of thematic and ESG equity products, positioning and opportunities.","why":"","deprio":"","reviewDate":"2026-11-13","decision":"","description":"","sample":true},"n03":{"kind":"network","name":"Data & AI automation network","focus":"dwe-tools","leadId":"p13","status":"Active","priority":"Medium","startDate":"2026-06-01","endDate":"","code":"","sponsor":"","purpose":"Spread automation and AI practices across Capability Homes.","why":"","deprio":"","reviewDate":"2027-03-01","decision":"Expand","description":"","sample":true}},"assignments":{"a01":{"projectId":"h01","personId":"p01","role":"Head of Strategy & Governance","allocation":50,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a02":{"projectId":"h02","personId":"p01","role":"Impact@Scale lead","allocation":15,"startDate":"2026-09-01","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a03":{"projectId":"h14","personId":"p01","role":"People management","allocation":15,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a04":{"projectId":"o01","personId":"p01","role":"Outcome sponsor support","allocation":5,"startDate":"2026-09-07","endDate":"","booking":"Confirmed","focus":"spg-core","skillId":"","minLevel":0,"sample":true},"a05":{"projectId":"h01","personId":"p02","role":"Governance & controls","allocation":45,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a06":{"projectId":"h02","personId":"p02","role":"Forum secretariat","allocation":15,"startDate":"2026-10-01","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a07":{"projectId":"h14","personId":"p02","role":"Training & admin","allocation":5,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a08":{"projectId":"h03","personId":"p03","role":"Index strategist","allocation":45,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a09":{"projectId":"o01","personId":"p03","role":"Index design for active ETFs","allocation":30,"startDate":"2026-09-07","endDate":"2027-01-29","booking":"Confirmed","focus":"isa-idea","skillId":"sk_index","minLevel":3,"sample":true},"a10":{"projectId":"n02","personId":"p03","role":"Thematic index expertise","allocation":20,"startDate":"2026-04-01","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a11":{"projectId":"h14","personId":"p03","role":"Training & admin","allocation":10,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a12":{"projectId":"h04","personId":"p04","role":"Performance analytics","allocation":55,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a13":{"projectId":"h03","personId":"p04","role":"Backtesting","allocation":20,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a14":{"projectId":"n01","personId":"p04","role":"Fixed income index input","allocation":10,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a15":{"projectId":"h14","personId":"p04","role":"Training & admin","allocation":5,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a16":{"projectId":"h04","personId":"p05","role":"Performance reporting","allocation":50,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a17":{"projectId":"h14","personId":"p05","role":"Administration","allocation":5,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a18":{"projectId":"h05","personId":"p06","role":"Product events lead","allocation":35,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a19":{"projectId":"o01","personId":"p06","role":"Outcome Lead","allocation":40,"startDate":"2026-09-07","endDate":"","booking":"Confirmed","focus":"","skillId":"sk_events","minLevel":3,"sample":true},"a20":{"projectId":"h08","personId":"p06","role":"Process improvement","allocation":10,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a21":{"projectId":"h14","personId":"p06","role":"People management","allocation":10,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a22":{"projectId":"o03","personId":"p06","role":"Launch process design","allocation":15,"startDate":"2026-12-07","endDate":"2027-02-26","booking":"Tentative","focus":"","skillId":"","minLevel":0,"sample":true},"a23":{"projectId":"h05","personId":"p07","role":"Product events specialist","allocation":55,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a24":{"projectId":"o06","personId":"p07","role":"Launch coordinator","allocation":30,"startDate":"2026-03-02","endDate":"2026-10-30","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a25":{"projectId":"o01","personId":"p07","role":"Launch readiness","allocation":30,"startDate":"2026-11-02","endDate":"","booking":"Confirmed","focus":"","skillId":"sk_events","minLevel":2,"sample":true},"a26":{"projectId":"h14","personId":"p07","role":"Training & admin","allocation":10,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a27":{"projectId":"h06","personId":"p08","role":"Product data analyst","allocation":45,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a28":{"projectId":"h15","personId":"p08","role":"Legacy extracts","allocation":20,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a29":{"projectId":"o05","personId":"p08","role":"Data model clean-up","allocation":25,"startDate":"2026-08-03","endDate":"2026-12-18","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a30":{"projectId":"h14","personId":"p08","role":"Training & admin","allocation":5,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a31":{"projectId":"o02","personId":"p09","role":"Outcome Lead, platform architect","allocation":55,"startDate":"2026-10-05","endDate":"","booking":"Confirmed","focus":"","skillId":"sk_ucits","minLevel":3,"sample":true},"a32":{"projectId":"h07","personId":"p09","role":"Wrapper architecture","allocation":30,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a33":{"projectId":"h07","personId":"p09","role":"Platform development","allocation":25,"startDate":"2026-01-05","endDate":"2026-10-02","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a34":{"projectId":"h14","personId":"p09","role":"Training & admin","allocation":5,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a35":{"projectId":"h09","personId":"p10","role":"Knowledge base owner","allocation":40,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a36":{"projectId":"h10","personId":"p10","role":"Market intelligence","allocation":30,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a37":{"projectId":"n02","personId":"p10","role":"Competitor intelligence","allocation":10,"startDate":"2026-04-01","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a38":{"projectId":"h14","personId":"p10","role":"People management","allocation":10,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a39":{"projectId":"h10","personId":"p11","role":"Market intelligence analyst","allocation":60,"startDate":"2026-03-02","endDate":"2027-03-31","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a40":{"projectId":"o07","personId":"p11","role":"Client data analysis","allocation":30,"startDate":"2026-11-02","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a41":{"projectId":"h11","personId":"p12","role":"Data engineer","allocation":40,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a42":{"projectId":"o07","personId":"p12","role":"Outcome Lead, data engineering","allocation":40,"startDate":"2026-11-02","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a43":{"projectId":"n03","personId":"p12","role":"Network member","allocation":10,"startDate":"2026-06-01","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a44":{"projectId":"h14","personId":"p12","role":"Training & admin","allocation":10,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a45":{"projectId":"h11","personId":"p13","role":"Automation developer","allocation":45,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a46":{"projectId":"n03","personId":"p13","role":"Steward","allocation":20,"startDate":"2026-06-01","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a47":{"projectId":"o02","personId":"p13","role":"Prospectus automation","allocation":25,"startDate":"2026-10-05","endDate":"2027-03-31","booking":"Confirmed","focus":"arp-proc","skillId":"sk_automation","minLevel":3,"sample":true},"a48":{"projectId":"h14","personId":"p13","role":"Training & admin","allocation":5,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a49":{"projectId":"h12","personId":"p14","role":"Equity product specialist","allocation":60,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a50":{"projectId":"n02","personId":"p14","role":"Domain member","allocation":10,"startDate":"2026-04-01","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a51":{"projectId":"o01","personId":"p14","role":"Client readiness","allocation":20,"startDate":"2027-01-04","endDate":"","booking":"Confirmed","focus":"psp-client","skillId":"sk_client","minLevel":3,"sample":true},"a52":{"projectId":"h14","personId":"p14","role":"Training & admin","allocation":10,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a53":{"projectId":"h12","personId":"p15","role":"Equity product specialist","allocation":40,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a54":{"projectId":"n02","personId":"p15","role":"Steward","allocation":25,"startDate":"2026-04-01","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a55":{"projectId":"h14","personId":"p15","role":"Administration","allocation":5,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a56":{"projectId":"h12","personId":"p16","role":"Fixed income product specialist","allocation":50,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a57":{"projectId":"n01","personId":"p16","role":"Steward","allocation":30,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a58":{"projectId":"o06","personId":"p16","role":"Client readiness","allocation":20,"startDate":"2026-03-02","endDate":"2026-10-30","booking":"Confirmed","focus":"psp-client","skillId":"","minLevel":0,"sample":true},"a59":{"projectId":"h14","personId":"p16","role":"Training & admin","allocation":10,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a60":{"projectId":"h12","personId":"p17","role":"Fixed income product specialist","allocation":60,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a61":{"projectId":"n01","personId":"p17","role":"Domain member","allocation":20,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a62":{"projectId":"h14","personId":"p17","role":"Training & admin","allocation":10,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a63":{"projectId":"h13","personId":"p18","role":"ESG product specialist","allocation":50,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a64":{"projectId":"o03","personId":"p18","role":"Outcome Lead","allocation":30,"startDate":"2026-12-07","endDate":"","booking":"Confirmed","focus":"","skillId":"sk_esg","minLevel":3,"sample":true},"a65":{"projectId":"n02","personId":"p18","role":"Sustainable equity input","allocation":10,"startDate":"2026-04-01","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a66":{"projectId":"h14","personId":"p18","role":"Training & admin","allocation":10,"startDate":"2026-01-05","endDate":"","booking":"Confirmed","focus":"","skillId":"","minLevel":0,"sample":true},"a67":{"projectId":"o01","personId":"","role":"Legal & documentation coordinator","allocation":50,"startDate":"2026-11-16","endDate":"","booking":"Confirmed","focus":"","skillId":"sk_regdoc","minLevel":3,"sample":true},"a68":{"projectId":"o03","personId":"","role":"Securities lending specialist","allocation":50,"startDate":"2026-12-07","endDate":"","booking":"Confirmed","focus":"","skillId":"sk_ucits","minLevel":2,"sample":true},"a69":{"projectId":"o04","personId":"","role":"Tokenisation analyst","allocation":40,"startDate":"2027-01-11","endDate":"","booking":"Confirmed","focus":"","skillId":"sk_etf","minLevel":3,"sample":true},"a70":{"projectId":"o04","personId":"","role":"Product events specialist","allocation":30,"startDate":"2027-01-11","endDate":"","booking":"Tentative","focus":"","skillId":"sk_events","minLevel":2,"sample":true},"a71":{"projectId":"o07","personId":"","role":"Power BI developer","allocation":30,"startDate":"2026-12-01","endDate":"","booking":"Confirmed","focus":"","skillId":"sk_powerbi","minLevel":3,"sample":true}},"timeoff":{"t01":{"personId":"p02","type":"Vacation","startDate":"2026-12-21","endDate":"2027-01-01","note":"","sample":true},"t02":{"personId":"p06","type":"Vacation","startDate":"2026-12-23","endDate":"2027-01-05","note":"","sample":true},"t03":{"personId":"p03","type":"Training","startDate":"2026-11-25","endDate":"2026-11-27","note":"Index governance seminar","sample":true},"t04":{"personId":"p14","type":"Vacation","startDate":"2026-12-21","endDate":"2026-12-31","note":"","sample":true},"t05":{"personId":"p12","type":"Parental leave","startDate":"2027-02-01","endDate":"2027-03-12","note":"","sample":true},"t06":{"personId":"p09","type":"Vacation","startDate":"2026-11-16","endDate":"2026-11-20","note":"","sample":true},"t07":{"personId":"p07","type":"Sick leave","startDate":"2026-11-09","endDate":"2026-11-10","note":"","sample":true},"t08":{"personId":"p16","type":"Vacation","startDate":"2026-12-28","endDate":"2027-01-08","note":"","sample":true},"t09":{"personId":"p18","type":"Vacation","startDate":"2026-12-21","endDate":"2026-12-24","note":"","sample":true},"t10":{"personId":"p13","type":"Training","startDate":"2026-12-01","endDate":"2026-12-03","note":"AI engineering course","sample":true},"t11":{"personId":"p11","type":"Vacation","startDate":"2026-12-21","endDate":"2027-01-01","note":"","sample":true},"t12":{"personId":"all","type":"Public holiday","startDate":"2026-12-25","endDate":"2026-12-25","note":"Christmas Day","sample":true},"t13":{"personId":"all","type":"Public holiday","startDate":"2027-01-01","endDate":"2027-01-01","note":"New Year's Day","sample":true}}}};
// ===================================================================
// Utilities
// ===================================================================
const $ = (s, r = document) => r.querySelector(s);
const $$ = (s, r = document) => Array.from(r.querySelectorAll(s));
const ESC = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' };
const esc = v => String(v ?? '').replace(/[&<>"']/g, c => ESC[c]);
const sleep = ms => new Promise(r => setTimeout(r, ms));
const clamp = (v, a, b) => Math.min(b, Math.max(a, v));
const str = v => (v == null ? '' : String(v)).trim();
const num = (v, d) => { const n = typeof v === 'number' ? v : parseFloat(v); return Number.isFinite(n) ? n : d; };
const push = (map, k, v) => { const l = map.get(k); if (l) l.push(v); else map.set(k, [v]); };
const plural = (n, one, many) => n + ' ' + (n === 1 ? one : (many || one + 's'));
const debounce = (fn, ms) => { let t; return (...a) => { clearTimeout(t); t = setTimeout(() => fn(...a), ms); }; };

const DAY = 86400000;
const MON = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
const MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
function pd(s) {
  if (typeof s !== 'string') return null;
  const m = /^(\d{4})-(\d{1,2})-(\d{1,2})/.exec(s.trim());
  if (!m) return null;
  const t = Date.UTC(+m[1], +m[2] - 1, +m[3]);
  return Number.isNaN(t) ? null : t;
}
const iso = ms => new Date(ms).toISOString().slice(0, 10);
function todayMs() { const n = new Date(); return Date.UTC(n.getFullYear(), n.getMonth(), n.getDate()); }
const dow = ms => (new Date(ms).getUTCDay() + 6) % 7; // Monday = 0
const monday = ms => ms - dow(ms) * DAY;
function isoWeek(ms) {
  const thu = ms + (3 - dow(ms)) * DAY;
  const y = new Date(thu).getUTCFullYear();
  const jan4 = Date.UTC(y, 0, 4);
  const w1 = jan4 - dow(jan4) * DAY;
  return { w: Math.floor((thu - w1) / (7 * DAY)) + 1, y };
}
const wkCode = wk => 'W' + String(isoWeek(wk).w).padStart(2, '0');
function fd(ms, withYear = true) {
  if (ms == null) return '—';
  const d = new Date(ms);
  return d.getUTCDate() + ' ' + MON[d.getUTCMonth()] + (withYear ? ' ' + d.getUTCFullYear() : '');
}
function fdr(a, b) {
  if (a == null || b == null) return '—';
  if (a === b) return fd(a);
  const A = new Date(a), B = new Date(b);
  if (A.getUTCFullYear() === B.getUTCFullYear()) {
    if (A.getUTCMonth() === B.getUTCMonth()) return A.getUTCDate() + '–' + fd(b);
    return fd(a, false) + ' – ' + fd(b);
  }
  return fd(a) + ' – ' + fd(b);
}
function workdays(s, e) { let n = 0; for (let d = s; d <= e; d += DAY) if (dow(d) < 5) n++; return n; }
const fmtInt = v => Math.round(v).toLocaleString('en-GB');
const fmt1 = v => (Math.round(v * 10) / 10).toLocaleString('en-GB', { maximumFractionDigits: 1 });
const fx1 = v => (Math.round(v * 10) / 10).toFixed(1); // fixed one decimal for table columns
const fmtPct = v => (v == null || !Number.isFinite(v)) ? '—' : Math.round(v * 100) + '%';
// Capacity is never shown in hours: teams in FTE, people in % of one FTE.
const fmtFte = v => fmt1(Math.abs(v) < 0.05 ? 0 : v) + ' FTE';
const pctNum = v => { const n = Math.round(v * 100); return n < 0 ? '−' + Math.abs(n) : String(n); };
const pctFte = v => pctNum(v) + '% FTE';
function fmtPp(d) {
  if (d == null || !Number.isFinite(d)) return '—';
  const n = Math.round(d * 100);
  return n === 0 ? '±0 pp' : (n > 0 ? '+' : '−') + Math.abs(n) + ' pp';
}
function uid(prefix) {
  const a = new Uint8Array(9);
  crypto.getRandomValues(a);
  return prefix + Array.from(a, b => (b % 36).toString(36)).join('');
}
const cleanId = v => {
  const s = str(v).replace(/[^A-Za-z0-9_\-.~:@+]/g, '-').slice(0, 120);
  return (s === '.' || s === '..') ? '' : s;
};

const ICONS = {
  plus: '<path d="M12 5v14M5 12h14"/>',
  download: '<path d="M12 4v11m0 0-4.5-4.5M12 15l4.5-4.5M5 19.5h14"/>',
  upload: '<path d="M12 19V8m0 0-4.5 4.5M12 8l4.5 4.5M5 4.5h14"/>',
  search: '<circle cx="11" cy="11" r="6.5"/><path d="m16 16 4 4"/>',
  x: '<path d="M6 6l12 12M18 6 6 18"/>',
  left: '<path d="M14.5 6l-6 6 6 6"/>',
  right: '<path d="M9.5 6l6 6-6 6"/>',
  edit: '<path d="M4 20h4L19 9l-4-4L4 16v4z"/><path d="m13.5 6.5 4 4"/>',
  trash: '<path d="M4.5 7h15M10 7V4.5h4V7M6.5 7l1 13h9l1-13"/>',
  gauge: '<path d="M4.5 16.5a7.5 7.5 0 1 1 15 0"/><path d="m12 16.5 3.5-4.5"/><path d="M4 20h16"/>',
  people: '<circle cx="9" cy="8" r="3.2"/><path d="M3.5 19.5c.7-3.3 2.9-5.2 5.5-5.2s4.8 1.9 5.5 5.2"/><circle cx="17" cy="9" r="2.4"/><path d="M15.6 13.7c2.3.2 4.1 1.9 4.9 4.8"/>',
  folder: '<rect x="3.5" y="7" width="17" height="12.5" rx="2"/><path d="M9 7V4.8h6V7M3.5 12.5h17"/>',
  grid: '<rect x="4" y="4" width="6.5" height="6.5" rx="1"/><rect x="13.5" y="4" width="6.5" height="6.5" rx="1"/><rect x="4" y="13.5" width="6.5" height="6.5" rx="1"/><rect x="13.5" y="13.5" width="6.5" height="6.5" rx="1"/>',
  calendar: '<rect x="3.5" y="5" width="17" height="15" rx="2"/><path d="M3.5 10h17M8 3v4M16 3v4"/>',
  alert: '<path d="M12 4.5 21 19.5H3z"/><path d="M12 10v4.5M12 17.2v.1"/>',
  check: '<path d="m5 12.5 4.5 4.5L19 7"/>',
  info: '<circle cx="12" cy="12" r="8.5"/><path d="M12 11v5.5M12 7.8v.1"/>',
  diamond: '<path d="M12 4 20 12 12 20 4 12z"/>',
  cloud: '<path d="M7 18.5h10a4 4 0 0 0 .6-8 5.5 5.5 0 0 0-10.7 1.3A3.4 3.4 0 0 0 7 18.5z"/>',
  device: '<rect x="4" y="5" width="16" height="11" rx="1.5"/><path d="M8.5 19.5h7M12 16v3.5"/>',
  eye: '<path d="M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12z"/><circle cx="12" cy="12" r="2.8"/>',
  userplus: '<circle cx="10" cy="8" r="3.5"/><path d="M3.5 20c.9-3.8 3.4-6 6.5-6 1.6 0 3 .5 4.1 1.5M18 13v6M15 16h6"/>',
  book: '<path d="M5 4.5h9.5a3 3 0 0 1 3 3v12H8a3 3 0 0 1-3-3z"/><path d="M5 16.5a3 3 0 0 1 3-3h9.5"/>',
  filter: '<path d="M4 5.5h16l-6.2 7.3v5.7l-3.6 1.5v-7.2z"/>',
};
const icon = (n, cls = '') => `<svg class="ico ${cls}" viewBox="0 0 24 24" aria-hidden="true" focusable="false">${ICONS[n] || ''}</svg>`;

// ===================================================================
// Domain constants
// ===================================================================
const APP_NAME = 'Impact@Scale Planner';
const COLLS = ['people', 'skills', 'projects', 'assignments', 'timeoff'];
const LEVELS = ['None', 'Basic', 'Working', 'Advanced', 'Expert'];
const STATUSES = ['Planned', 'Active', 'On hold', 'Completed'];
const COUNTS = new Set(['Planned', 'Active']);
const PRIORITIES = ['High', 'Medium', 'Low'];
const BOOKINGS = ['Confirmed', 'Tentative'];
const PTYPES = ['Employee', 'Contractor'];
const OFFTYPES = ['Vacation', 'Sick leave', 'Training', 'Parental leave', 'Public holiday', 'Other'];
const DECISIONS = ['Continue', 'Change', 'Expand', 'Merge', 'Close'];
const ALL = 'all';
const STD = 40;                          // only used to convert old "hours per week" records into FTE
const OPEN_END = Date.UTC(2100, 0, 1);   // stands in for "ongoing, no end date"
const LS_KEY = 'it-resource-planner:v1';

// Impact@Scale operating model: every activity is one of these three.
const KINDS = [
  { id: 'home', label: 'Capability Home', plural: 'Capability Homes', short: 'Home', cssv: '--k-home',
    desc: 'Enduring work in a stable professional home: recurring responsibilities, specialist expertise, product and platform stewardship, controls, maintenance and capability development.' },
  { id: 'outcome', label: 'Outcome Team', plural: 'Outcome Teams', short: 'Outcome', cssv: '--k-outcome',
    desc: 'Temporary capacity deployed to a material client, growth or transformation outcome that needs collaboration across capabilities. Your projects.' },
  { id: 'network', label: 'Franchise Network', plural: 'Franchise Networks', short: 'Network', cssv: '--k-network',
    desc: 'Ongoing virtual collaboration across organisational and capability boundaries, for example around Product Domains, markets or themes.' },
];
const KIND = Object.fromEntries(KINDS.map(k => [k.id, k]));

// Capability Home focus: the types of work from the PPWS resource allocation paper.
// Areas 1–7 are Capability Homes people belong to; 8 and 9 are cross-cutting categories.
const FOCUS = [
  { id: 'spg', n: 1, home: true, name: 'Strategy, Planning & Governance', desc: 'Defining and tracking strategy, senior management reporting, team governance and controls.', subs: [
    { id: 'spg-core', name: 'Strategy, Planning & Governance', desc: 'Market and competitor screening, business-line and product strategy, senior management fora, budgeting, 1st-line controls, product governance fora, legal-entity and DWS/PD governance, PPWS resource planning and operating model.' },
    { id: 'spg-init', name: 'Strategic projects & PPWS-wide initiatives', desc: 'Strategic projects and initiatives that span the whole of PPWS.' },
  ] },
  { id: 'isa', n: 2, home: true, name: 'Investment Strategy & Performance Analytics', desc: 'Investment and index design, benchmark architecture, portfolio analytics, performance review, profitability and index oversight.', subs: [
    { id: 'isa-idea', name: 'Analytics, idea generation & investment/product strategy', desc: 'IDEA and DESIGN: market and wallet analytics, product comparisons, index and investment-strategy development, backtesting, benchmark selection, analytical challenge of product design, product-level profitability.' },
    { id: 'isa-life', name: 'Lifecycle & performance analytics', desc: 'Oversight of existing products: performance reviews, portfolio and exposure analytics, peer-group positioning, lifecycle forecasts, index oversight and Index Watch, GIPS.' },
  ] },
  { id: 'arp', n: 3, home: true, name: 'Architecture & Platforms', desc: 'Wrappers, product-event architecture, platform ownership, jurisdictional expertise, maintenance and event automation.', subs: [
    { id: 'arp-events', name: 'Product Events Implementation', desc: 'Launches, seeding, listings, registrations, changes, maintenance events, de-listings and terminations, with their operational, legal and client readiness.' },
    { id: 'arp-maint', name: 'Product Maintenance & Data Quality', desc: 'EMT/EPT, KIID and prospectus updates, audits and TPRM, index provider agreements, data and vendor issues, Product Master and Storefront data, data-quality checks, regulatory maintenance.' },
    { id: 'arp-dev', name: 'Platform Development', desc: 'New wrappers and platforms, platform-wide events, development projects such as ICAV intake, jurisdictional platform development, platform clean-up and reusable propositions.' },
    { id: 'arp-proc', name: 'Process Optimization of product/platform processes', desc: 'Process documentation, workflow simplification and automation, first-line-of-defence improvements, standardising product-event processes.' },
  ] },
  { id: 'pic', n: 4, home: true, name: 'Product Intelligence & Commercialization', desc: 'Product, market, competitor, client and commercial intelligence, made reusable for people, processes, tools and AI.', subs: [
    { id: 'pic-know', name: 'Product Intelligence & Knowledge Management', desc: 'Knowledge databases, the Product Knowledge Stack, knowledge ownership and review cycles, documenting team knowledge, sharing across PPWS.' },
    { id: 'pic-comm', name: 'Commercialization, market & opportunity intelligence', desc: 'Client feedback and market signals, opportunity assessment, profitability and attractiveness analytics, commercialization readiness, campaign effectiveness.' },
  ] },
  { id: 'dwe', n: 5, home: true, name: 'Data & Workflow Engineering', desc: 'Reusable technology, data, automation and AI capabilities that improve how PPWS operates.', subs: [
    { id: 'dwe-tools', name: 'Data, Automation, AI & Tools Development', desc: 'Data architecture and connectivity, self-service tools, reusable analytics, automation and AI-enabled workflows, APIs, technical support for Outcome Teams and Capability Homes.' },
  ] },
  { id: 'psp', n: 6, home: true, name: 'Product Specialists', desc: 'Product, market and client work, including preparing client interactions with CCD, product curatorship and lifecycle LIVE activities.', subs: [
    { id: 'psp-client', name: 'Product Specialist Activities, Clients & Content', desc: 'Product narrative and content, pre-launch and pipeline building, RfP/RFI and CCD requests, client meetings and roadshows, partner interaction, PR and conferences.' },
    { id: 'psp-domain', name: 'Product Domain / Franchise Stewardship', desc: 'Product curatorship and positioning, Product Domain collaboration across Active, Passive and regional experts, client feedback capture, product defence and opportunity identification.' },
  ] },
  { id: 'pss', n: 7, home: true, name: 'Product Sustainability', desc: 'Work that needs Product Sustainability expertise across Active, Passive and Alternatives.', subs: [
    { id: 'pss-esg', name: 'Sustainability Methodology, Governance & Product Activities', desc: 'ESG methodologies and classifications, sustainability governance and controls, SFDR reporting, ESG regulatory projects, sustainability documentation, ESG analytics and product development.' },
  ] },
  { id: 'pdm', n: 8, home: false, name: 'Personal Development, People Management & Administration', desc: 'Learning, teaching others, people management and administration, unless it fits one of the areas above.', subs: [
    { id: 'pdm-admin', name: 'Personal Development, People Management & Administration', desc: 'Mandatory and selected trainings, target setting and performance reviews, managing people, Workday, expenses, time recording, re-certifications and other administration.' },
  ] },
  { id: 'oos', n: 9, home: false, name: 'Tasks that should not be covered by PPWS', desc: 'Work to document, optimise and then hand over to other teams. If in doubt, allocate to one of the areas above instead.', subs: [
    { id: 'oos-handover', name: 'Tasks that should not be covered by PPWS', desc: 'Work that could move to another team once it is documented and optimised.' },
  ] },
];
const AREA = new Map(FOCUS.map(a => [a.id, a]));
const SUB = new Map();
for (const a of FOCUS) for (const s of a.subs) { s.area = a; s.solo = a.subs.length === 1 && s.name === a.name; SUB.set(s.id, s); }
const HOMES = FOCUS.filter(a => a.home);
const VIEW_LIST = [
  ['dashboard', 'Dashboard', 'gauge'],
  ['people', 'People', 'people'],
  ['activities', 'Activities', 'folder'],
  ['skills', 'Skills', 'grid'],
  ['availability', 'Availability', 'calendar'],
];

// ===================================================================
// State
// ===================================================================
const S = Object.fromEntries(COLLS.map(c => [c, new Map()]));
const app = {
  mode: 'connecting',   // connecting | shared | local
  ready: false,
  stale: false,
  canWrite: null,       // true | false | null (unknown)
  version: 0,
  seen: new Set(),
  live: new Set(),
  view: 'dashboard',
  f: {
    dash: { period: 'm0', home: '', team: '', kind: '', area: '', allAlerts: false, psort: 'team' },
    people: { q: '', home: '', team: '', skill: '', min: 1, type: '', sort: 'name' },
    activities: { q: '', status: 'open', kind: '', area: '' },
    skills: { tab: 'matrix', team: '', cat: '', q: '' },
    avail: { offset: 0, weeks: 12, home: '', team: '', skill: '', min: 1, q: '', metric: 'util' },
  },
  drawer: null,
  db: null,
};
const canEdit = () => app.mode === 'local' || (app.mode === 'shared' && app.canWrite !== false);

// ===================================================================
// Storage: shared db capability, or this browser only
// ===================================================================
const Local = {
  read() { try { const raw = localStorage.getItem(LS_KEY); return raw ? JSON.parse(raw) : null; } catch (e) { return null; } },
  write() {
    try {
      const out = {};
      for (const c of COLLS) out[c] = Object.fromEntries(S[c]);
      localStorage.setItem(LS_KEY, JSON.stringify(out));
    } catch (e) { /* storage unavailable: keep working in memory */ }
  },
};

let renderTimer = 0;
function changed() {
  app.version++;
  if (!renderTimer) renderTimer = setTimeout(() => { renderTimer = 0; renderAll(); }, 0);
}

function startLocal() {
  app.mode = 'local';
  const saved = Local.read();
  if (saved && typeof saved === 'object') {
    for (const c of COLLS) {
      const m = new Map();
      const src = saved[c];
      if (src && typeof src === 'object') for (const [id, d] of Object.entries(src)) if (d && typeof d === 'object') m.set(id, d);
      S[c] = m;
    }
  }
  app.ready = true;
  changed();
}

function startShared(db) {
  app.mode = 'shared';
  app.db = db;
  const timer = setTimeout(() => {
    if (app.live.size < COLLS.length) { app.stale = true; changed(); }
  }, 10000);
  for (const c of COLLS) {
    db.collection(c).onSnapshot(snap => {
      const m = new Map();
      for (const d of snap.docs) { const v = d.data(); if (v && typeof v === 'object') m.set(d.id, v); }
      S[c] = m;
      app.seen.add(c);
      if (!snap.metadata.fromCache) app.live.add(c);
      if (app.seen.size === COLLS.length) app.ready = true;
      if (app.live.size === COLLS.length) { clearTimeout(timer); app.stale = false; }
      changed();
    }, err => {
      app.seen.add(c);
      if (app.seen.size === COLLS.length) app.ready = true;
      app.stale = true;
      if (err && err.code === 'revoked') app.canWrite = false;
      changed();
    });
  }
}

const chains = new Map();
function serial(key, fn) {
  const prev = chains.get(key) || Promise.resolve();
  const next = prev.catch(() => {}).then(fn);
  chains.set(key, next);
  next.catch(() => {}).then(() => { if (chains.get(key) === next) chains.delete(key); });
  return next;
}
async function retry(fn, tries = 2) {
  let wait = 400;
  for (let i = 0; ; i++) {
    try { return await fn(); } catch (e) {
      const code = e && e.code;
      if (i < tries - 1 && (code === 'unavailable' || code === 'resource_exhausted')) {
        await sleep(wait + Math.random() * 300);
        wait *= 2.2;
        continue;
      }
      throw e;
    }
  }
}
const stamp = body => Object.assign({}, body, { updatedAt: new Date().toISOString() });
function deepMerge(a, b) {
  const o = Object.assign({}, a);
  for (const [k, v] of Object.entries(b)) {
    const isObj = x => x && typeof x === 'object' && !Array.isArray(x);
    o[k] = isObj(v) && isObj(a[k]) ? deepMerge(a[k], v) : v;
  }
  return o;
}
async function putDoc(coll, id, body) {
  body = stamp(body);
  if (app.mode === 'shared') return serial(coll + '/' + id, () => retry(() => app.db.collection(coll).doc(id).set(body)));
  S[coll].set(id, body); Local.write(); changed();
}
async function delDoc(coll, id) {
  if (app.mode === 'shared') return serial(coll + '/' + id, () => retry(() => app.db.collection(coll).doc(id).delete()));
  S[coll].delete(id); Local.write(); changed();
}
async function mergeDoc(coll, id, patch) {
  if (app.mode === 'shared') return serial(coll + '/' + id, () => retry(() => app.db.collection(coll).doc(id).update(stamp(patch))));
  const cur = S[coll].get(id);
  if (!cur) return;
  S[coll].set(id, deepMerge(cur, stamp(patch))); Local.write(); changed();
}
async function bulk(ops, progress) {
  if (app.mode !== 'shared') {
    for (const op of ops) { if (op.del) S[op.coll].delete(op.id); else S[op.coll].set(op.id, stamp(op.body)); }
    Local.write(); changed();
    if (progress) progress(ops.length, ops.length);
    return { ok: ops.length, failed: [] };
  }
  let i = 0, done = 0;
  const failed = [];
  const worker = async () => {
    while (i < ops.length) {
      const op = ops[i++];
      try {
        const ref = app.db.collection(op.coll).doc(op.id);
        await serial(op.coll + '/' + op.id, () => retry(() => (op.del ? ref.delete() : ref.set(stamp(op.body))), 5));
      } catch (e) {
        failed.push({ op, e });
        const code = e && e.code;
        if (code === 'invalid_argument' || code === 'revoked' || code === 'quota_exceeded' || code === 'not_granted') i = ops.length;
      }
      done++;
      if (progress) progress(done, ops.length);
    }
  };
  await Promise.all([worker(), worker(), worker(), worker()]);
  return { ok: done - failed.length, failed };
}
async function run(task, okMsg) {
  try { await task(); if (okMsg) toast(okMsg); return true; } catch (e) { failWrite(e); return false; }
}
function failWrite(e) {
  const code = e && e.code;
  console.warn('Write failed', e);
  if (code === 'invalid_argument' || code === 'not_granted') {
    app.canWrite = false; renderAll();
    toast('Your access to this planner is view-only, so the change wasn’t saved.');
  } else if (code === 'quota_exceeded') {
    toast('The planner’s storage is full. Delete old activities or bookings, then try again.');
  } else if (code === 'revoked') {
    app.canWrite = false; renderAll();
    toast('Editing isn’t available in this view any more.');
  } else {
    toast('The change wasn’t saved. Check your connection and try again.');
  }
}

// ===================================================================
// Normalised, indexed view of the data
// ===================================================================
function fteOf(d) {
  if (d.fte != null && d.fte !== '' && Number.isFinite(num(d.fte, NaN))) return clamp(Math.round(num(d.fte, 100)), 5, 100);
  if (d.hoursPerWeek != null && d.hoursPerWeek !== '') return clamp(Math.round(num(d.hoursPerWeek, STD) / STD * 100), 5, 100);
  return 100;
}
function normPerson(id, d) {
  const skills = {};
  if (d.skills && typeof d.skills === 'object') {
    for (const [k, v] of Object.entries(d.skills)) { const l = Math.round(num(v, 0)); if (l > 0) skills[k] = clamp(l, 1, 4); }
  }
  const home = AREA.has(d.home) && AREA.get(d.home).home ? d.home : '';
  return {
    id, name: str(d.name) || 'Unnamed person', role: str(d.role), team: str(d.team), home, location: str(d.location), email: str(d.email),
    type: PTYPES.includes(d.type) ? d.type : 'Employee', fte: fteOf(d),
    start: pd(d.startDate), end: pd(d.endDate), skills, notes: str(d.notes), sample: !!d.sample,
  };
}
function normSkill(id, d) { return { id, name: str(d.name) || 'Unnamed skill', cat: str(d.category) || 'Other', critical: !!d.critical }; }
function normProject(id, d) {
  return {
    id, name: str(d.name) || 'Untitled activity', code: str(d.code), sponsor: str(d.sponsor),
    kind: KIND[d.kind] ? d.kind : 'outcome', focus: SUB.has(d.focus) ? d.focus : '',
    status: STATUSES.includes(d.status) ? d.status : 'Planned', priority: PRIORITIES.includes(d.priority) ? d.priority : 'Medium',
    leadId: str(d.leadId), start: pd(d.startDate), end: pd(d.endDate), description: str(d.description),
    purpose: str(d.purpose), why: str(d.why), deprio: str(d.deprio), review: pd(d.reviewDate), decision: DECISIONS.includes(d.decision) ? d.decision : '',
    sample: !!d.sample,
  };
}
function normAsg(id, d) {
  return {
    id, projectId: str(d.projectId), personId: str(d.personId), role: str(d.role) || 'Role', skillId: str(d.skillId),
    minLevel: clamp(Math.round(num(d.minLevel, 0)), 0, 4), alloc: clamp(num(d.allocation, 50), 1, 100),
    ownFocus: SUB.has(d.focus) ? d.focus : '',
    s: pd(d.startDate), e: pd(d.endDate), booking: d.booking === 'Tentative' ? 'Tentative' : 'Confirmed', sample: !!d.sample,
  };
}
function normOff(id, d) {
  return { id, personId: str(d.personId), type: OFFTYPES.includes(d.type) ? d.type : 'Other', s: pd(d.startDate), e: pd(d.endDate) ?? pd(d.startDate), note: str(d.note), sample: !!d.sample };
}
const KORDER = { home: 0, outcome: 1, network: 2 };

let IX = null;
function ix() {
  if (IX && IX.v === app.version) return IX;
  const T = todayMs();
  const people = [...S.people].map(([id, d]) => normPerson(id, d)).sort((a, b) => a.name.localeCompare(b.name));
  const skills = [...S.skills].map(([id, d]) => normSkill(id, d)).sort((a, b) => a.cat.localeCompare(b.cat) || a.name.localeCompare(b.name));
  const projects = [...S.projects].map(([id, d]) => normProject(id, d)).sort((a, b) => KORDER[a.kind] - KORDER[b.kind] || (a.start ?? 9e15) - (b.start ?? 9e15) || a.name.localeCompare(b.name));
  const P = new Map(people.map(p => [p.id, p]));
  const K = new Map(skills.map(s => [s.id, s]));
  const J = new Map(projects.map(p => [p.id, p]));
  const asg = [];
  const byPerson = new Map(), byProject = new Map(), countByPerson = new Map();
  const openRoles = [];
  for (const [id, d] of S.assignments) {
    const a = normAsg(id, d);
    const pr = J.get(a.projectId);
    if (!pr) continue;
    a.project = pr;
    a.focus = a.ownFocus || pr.focus;
    if (a.personId && !P.has(a.personId)) a.personId = '';
    if (a.skillId && !K.has(a.skillId)) a.skillId = '';
    // No end date: runs until the activity ends, or stays ongoing.
    if (a.e == null && a.s != null) { a.noEnd = true; a.e = pr.end != null && pr.end >= a.s ? pr.end : OPEN_END; }
    a.ongoing = a.e === OPEN_END;
    // Time on paused or completed activities only counts up to yesterday: it happened, but nothing more is planned.
    a.ce = COUNTS.has(pr.status) ? a.e : (a.e == null ? null : Math.min(a.e, T - DAY));
    a.counts = a.s != null && a.ce != null && a.ce >= a.s;
    a.live = COUNTS.has(pr.status) && a.counts;
    asg.push(a);
    push(byProject, a.projectId, a);
    if (a.personId) { push(byPerson, a.personId, a); if (a.counts) push(countByPerson, a.personId, a); }
    else if (a.live) openRoles.push(a);
  }
  const sortAsg = l => l.sort((a, b) => (a.s ?? 0) - (b.s ?? 0));
  byProject.forEach(sortAsg); byPerson.forEach(sortAsg); openRoles.sort((a, b) => a.s - b.s);
  const offs = [], offBy = new Map(), globalOffs = [];
  for (const [id, d] of S.timeoff) {
    const t = normOff(id, d);
    if (t.s == null || t.e == null || t.e < t.s) continue;
    if (t.personId === ALL) { globalOffs.push(t); offs.push(t); }
    else if (P.has(t.personId)) { push(offBy, t.personId, t); offs.push(t); }
  }
  offs.sort((a, b) => a.s - b.s);
  const teams = [...new Set(people.map(p => p.team).filter(Boolean))].sort((a, b) => a.localeCompare(b));
  const cats = [...new Set(skills.map(s => s.cat))];
  IX = { v: app.version, T, W0: monday(T), people, skills, projects, asg, offs, P, K, J, byPerson, byProject, countByPerson, openRoles, offBy, globalOffs, teams, cats, pw: new Map(), memo: new Map() };
  return IX;
}
function memo(key, fn) { const X = ix(); if (!X.memo.has(key)) X.memo.set(key, fn()); return X.memo.get(key); }
const pplFor = (home, team) => ix().people.filter(p => (!home || p.home === home) && (!team || p.team === team));
const teamsFor = home => { const X = ix(); return home ? [...new Set(X.people.filter(p => p.home === home).map(p => p.team).filter(Boolean))].sort((a, b) => a.localeCompare(b)) : X.teams; };

// ===================================================================
// Periods (months match the monthly Impact@Scale check-in)
// ===================================================================
const mStart = (y, m) => Date.UTC(y, m, 1);
const mEnd = (y, m) => Date.UTC(y, m + 1, 0);
const monthName = (ms, long) => { const d = new Date(ms); return (long ? MONTHS : MON)[d.getUTCMonth()] + ' ' + d.getUTCFullYear(); };
function spanLabel(a, b) {
  const A = new Date(a), B = new Date(b);
  if (A.getUTCFullYear() === B.getUTCFullYear()) return MON[A.getUTCMonth()] + ' – ' + MON[B.getUTCMonth()] + ' ' + B.getUTCFullYear();
  return monthName(a) + ' – ' + monthName(b);
}
function periods() {
  return memo('periods', () => {
    const X = ix();
    const t = new Date(X.T);
    const y = t.getUTCFullYear(), m = t.getUTCMonth();
    const out = [];
    for (let k = -6; k <= 6; k++) {
      const from = mStart(y, m + k), to = mEnd(y, m + k);
      const rel = k === 0 ? 'this month' : k === -1 ? 'last month' : k === 1 ? 'next month' : '';
      out.push({ id: 'm' + k, group: 'Months', label: monthName(from, true) + (rel ? ` (${rel})` : ''), name: monthName(from, true), short: monthName(from), from, to,
        prev: { from: mStart(y, m + k - 1), to: mEnd(y, m + k - 1), short: monthName(mStart(y, m + k - 1)) } });
    }
    const range = (id, label, a, n) => {
      const from = mStart(y, m + a), to = mEnd(y, m + a + n - 1);
      return { id, group: 'Ranges', label: `${label} (${spanLabel(from, to)})`, name: label.toLowerCase(), short: spanLabel(from, to), from, to,
        prev: { from: mStart(y, m + a - n), to: mEnd(y, m + a - 1), short: spanLabel(mStart(y, m + a - n), mEnd(y, m + a - 1)) } };
    };
    out.push(range('n3', 'Next 3 months', 1, 3), range('n6', 'Next 6 months', 1, 6), range('l3', 'Last 3 months', -3, 3));
    const w0 = X.W0;
    out.push({ id: 'w12', group: 'Ranges', label: `Next 12 weeks (${wkCode(w0)}–${wkCode(w0 + 77 * DAY)})`, name: 'the next 12 weeks', short: `${wkCode(w0)}–${wkCode(w0 + 77 * DAY)}`, from: w0, to: w0 + 81 * DAY,
      prev: { from: w0 - 84 * DAY, to: w0 - 3 * DAY, short: 'previous 12 weeks' } });
    return out;
  });
}
const periodById = id => { const l = periods(); return l.find(p => p.id === id) || l.find(p => p.id === 'm0'); };
function weeksIn(from, to) { const out = []; for (let wk = monday(from); wk <= to; wk += 7 * DAY) if (wk + 4 * DAY >= from) out.push(wk); return out; }

// ===================================================================
// Availability engine (weekly, Mon–Fri), measured in FTE
// ===================================================================
const employed = (p, d) => (p.start == null || d >= p.start) && (p.end == null || d <= p.end);
function offOn(p, d, X) {
  for (const t of X.globalOffs) if (d >= t.s && d <= t.e) return t;
  const l = X.offBy.get(p.id);
  if (l) for (const t of l) if (d >= t.s && d <= t.e) return t;
  return null;
}
// One person, one week. cap/conf/tent/alloc/free are in FTE for that week (1 = a full-time person, all week).
function week(p, wk) {
  const X = ix();
  const key = p.id + '|' + wk;
  const hit = X.pw.get(key);
  if (hit) return hit;
  const capDay = p.fte / 100 / 5;
  const list = X.countByPerson.get(p.id) || [];
  let work = 0, off = 0, avail = 0, conf = 0, tent = 0, outside = 0;
  const proj = new Map();
  const offTypes = new Set();
  for (let i = 0; i < 5; i++) {
    const d = wk + i * DAY;
    if (!employed(p, d)) { for (const a of list) if (d >= a.s && d <= a.ce) outside++; continue; }
    work++;
    const t = offOn(p, d, X);
    if (t) { off++; offTypes.add(t.type); continue; }
    avail++;
    for (const a of list) {
      if (d < a.s || d > a.ce) continue;
      const v = a.alloc / 100 / 5;
      if (a.booking === 'Tentative') tent += v; else conf += v;
      const e = proj.get(a.id) || { a, v: 0 };
      e.v += v;
      proj.set(a.id, e);
    }
  }
  const cap = capDay * avail, alloc = conf + tent;
  const r = { wk, work, off, avail, cap, conf, tent, alloc, free: cap - alloc, util: cap > 0 ? alloc / cap : null, proj: [...proj.values()], offTypes: [...offTypes], outside };
  X.pw.set(key, r);
  return r;
}
const bin = u => (u < 0.25 ? 0 : u < 0.5 ? 1 : u < 0.75 ? 2 : u < 0.9 ? 3 : 4);
function cellClass(r) {
  if (r.work === 0) return 'na';
  if (r.avail === 0) return 'off';
  if (r.util > 1.005) return 'over';
  return 'b' + bin(r.util);
}
const weeksFrom = (start, n) => Array.from({ length: n }, (_, i) => start + i * 7 * DAY);
// FTE an open role asks for in a week (its allocation is a share of one full-time person).
function roleFte(a, wk) {
  let d = 0;
  for (let i = 0; i < 5; i++) { const x = wk + i * DAY; if (x >= a.s && x <= a.ce) d++; }
  return a.alloc / 100 * d / 5;
}
// Average FTE per week across the given weeks.
function summarize(ppl, weeks) {
  let cap = 0, conf = 0, tent = 0, free = 0;
  for (const p of ppl) for (const wk of weeks) { const r = week(p, wk); cap += r.cap; conf += r.conf; tent += r.tent; free += Math.max(0, r.free); }
  const n = Math.max(1, weeks.length);
  return { cap: cap / n, conf: conf / n, tent: tent / n, alloc: (conf + tent) / n, free: free / n, util: cap > 0 ? (conf + tent) / cap : null, confUtil: cap > 0 ? conf / cap : null };
}

// ===================================================================
// Impact@Scale allocation over an exact date range (daily, Mon–Fri)
// Results are average FTE over the range's working days.
// ===================================================================
const zeroK = () => ({ home: 0, outcome: 0, network: 0 });
function allocCalc(from, to, ppl, key) {
  return memo('ac|' + from + '|' + to + '|' + key, () => {
    const X = ix();
    const days = workdays(from, to) || 1;
    const tot = { cap: 0, conf: 0, tent: 0, ...zeroK() };
    const subs = new Map(), acts = new Map(), per = new Map();
    for (const p of ppl) {
      const r = { p, cap: 0, conf: 0, tent: 0, ...zeroK(), subs: new Map(), acts: new Map() };
      const list = (X.countByPerson.get(p.id) || []).filter(a => a.ce >= from && a.s <= to);
      const capDay = p.fte / 100;
      for (let d = from; d <= to; d += DAY) {
        if (dow(d) >= 5 || !employed(p, d) || offOn(p, d, X)) continue;
        r.cap += capDay;
        for (const a of list) {
          if (d < a.s || d > a.ce) continue;
          const v = a.alloc / 100;
          const k = a.project.kind;
          r[k] += v;
          if (a.booking === 'Tentative') r.tent += v; else r.conf += v;
          let sv = r.subs.get(a.focus);
          if (!sv) { sv = zeroK(); r.subs.set(a.focus, sv); }
          sv[k] += v;
          r.acts.set(a.projectId, (r.acts.get(a.projectId) || 0) + v);
        }
      }
      for (const f of ['cap', 'conf', 'tent', 'home', 'outcome', 'network']) { r[f] /= days; tot[f] += r[f]; }
      for (const [sid, sv] of r.subs) {
        for (const k of Object.keys(sv)) sv[k] /= days;
        let t = subs.get(sid);
        if (!t) { t = zeroK(); subs.set(sid, t); }
        for (const k of Object.keys(sv)) t[k] += sv[k];
      }
      for (const [aid, v] of r.acts) { r.acts.set(aid, v / days); acts.set(aid, (acts.get(aid) || 0) + v / days); }
      finishK(r);
      per.set(p.id, r);
    }
    // Team level: free and over-allocation are summed person by person, so one person's overbooking
    // never hides another person's free time. booked + free = capacity + over.
    tot.booked = tot.home + tot.outcome + tot.network;
    tot.free = 0; tot.over = 0;
    for (const r of per.values()) { tot.free += r.free; tot.over += r.over; }
    tot.util = tot.cap > 0 ? tot.booked / tot.cap : null;
    // Demand from open roles nobody is booked for yet, by type.
    const open = zeroK();
    for (const a of X.openRoles) {
      if (a.ce < from || a.s > to) continue;
      let n = 0;
      for (let d = Math.max(from, a.s); d <= Math.min(to, a.ce); d += DAY) if (dow(d) < 5) n++;
      open[a.project.kind] += a.alloc / 100 * n / days;
    }
    open.total = open.home + open.outcome + open.network;
    return { from, to, days, tot, subs, acts, per, open };
  });
}
function finishK(r) {
  r.booked = r.home + r.outcome + r.network;
  r.free = Math.max(0, r.cap - r.booked);
  r.over = Math.max(0, r.booked - r.cap);
  r.util = r.cap > 0 ? r.booked / r.cap : null;
}
// Booked FTE by type, optionally limited to one focus area (or to unclassified time with '-').
function kindTotals(subs, area) {
  const out = zeroK();
  for (const [sid, sv] of subs) {
    if (area && !(area === '-' ? !sid : SUB.has(sid) && SUB.get(sid).area.id === area)) continue;
    for (const k of Object.keys(out)) out[k] += sv[k];
  }
  out.total = out.home + out.outcome + out.network;
  return out;
}
// FTE on one focus sub-category (or a whole area), optionally for one type only.
function subValue(subs, ids, kind) {
  let v = 0;
  for (const id of ids) { const sv = subs.get(id); if (sv) v += kind ? sv[kind] : sv.home + sv.outcome + sv.network; }
  return v;
}
const areaSubIds = a => a.subs.map(s => s.id);

function dashData(pid, home, team) {
  return memo('dash|' + pid + '|' + home + '|' + team, () => {
    const X = ix();
    const P = periodById(pid);
    const weeks = weeksIn(P.from, P.to);
    const ppl = pplFor(home, team);
    const filtered = !!(home || team);
    const series = weeks.map(wk => {
      let cap = 0, conf = 0, tent = 0;
      for (const p of ppl) { const r = week(p, wk); cap += r.cap; conf += r.conf; tent += r.tent; }
      const open = filtered ? 0 : X.openRoles.reduce((s, a) => s + roleFte(a, wk), 0);
      return { wk, cap, conf, tent, open };
    });
    const A = allocCalc(P.from, P.to, ppl, home + '|' + team);
    const B = allocCalc(P.prev.from, P.prev.to, ppl, home + '|' + team);
    const per = ppl.map(p => {
      let peak = 0, offW = 0;
      const overW = [];
      for (const wk of weeks) {
        const r = week(p, wk);
        if (r.util != null && r.util > 1.005) { overW.push(wk); peak = Math.max(peak, r.util); }
        if (r.work > 0 && r.avail === 0) offW++;
      }
      return { p, a: A.per.get(p.id), peak, overW, offW };
    });
    const open = X.openRoles.filter(a => a.ce >= P.from && a.s <= P.to);
    const groupRows = [];
    if (!team) {
      const keys = home ? teamsFor(home).concat(ppl.some(p => !p.team) ? [''] : []) : X.teams.concat(ppl.some(p => !p.team) ? [''] : []);
      for (const t of keys) {
        const members = ppl.filter(p => p.team === t);
        if (!members.length) continue;
        const R = allocCalc(P.from, P.to, members, 'team:' + home + '|' + t);
        groupRows.push({ team: t, n: members.length, ...R.tot });
      }
    }
    return { P, weeks, ppl, filtered, series, A, B, per, open, groupRows, openFte: open.reduce((s, a) => s + a.alloc / 100, 0) };
  });
}

function coverage(sid) {
  return memo('cov|' + sid, () => {
    const X = ix();
    const by = [0, 0, 0, 0, 0];
    const adv = [];
    for (const p of X.people) {
      if (p.end != null && p.end < X.T) continue;
      const l = p.skills[sid] || 0;
      if (l) { by[l]++; if (l >= 3) adv.push(p); }
    }
    return { by, adv: by[3] + by[4], total: by[1] + by[2] + by[3] + by[4], advPeople: adv };
  });
}

function staffing(pr) {
  return memo('staff|' + pr.id, () => {
    const X = ix();
    const roles = X.byProject.get(pr.id) || [];
    const cur = roles.filter(a => a.e == null || a.e >= X.T);
    const set = cur.length ? cur : roles;
    let total = 0, filled = 0;
    const open = [];
    for (const a of set) { total += a.alloc / 100; if (a.personId) filled += a.alloc / 100; else open.push(a); }
    let state = 'good', label = 'Fully staffed';
    if (!COUNTS.has(pr.status)) { state = 'muted'; label = pr.status === 'Completed' ? 'Closed' : 'Paused'; }
    else if (!set.length) { state = 'neutral'; label = 'No one booked yet'; }
    else if (open.some(a => a.s != null && a.s <= X.T)) { state = 'crit'; label = 'Role unfilled'; }
    else if (open.some(a => a.s != null && a.s <= X.T + 28 * DAY)) { state = 'warn'; label = 'Role starts soon'; }
    else if (open.length) { state = 'neutral'; label = plural(open.length, 'open role'); }
    return { roles, set, total, filled, open, state, label };
  });
}

function attention(pid, home, team) {
  return memo('att|' + pid + '|' + home + '|' + team, () => {
    const X = ix();
    const D = dashData(pid, home, team);
    const P = D.P;
    const items = [];
    for (const r of D.per) {
      if (r.overW.length) items.push({ sev: 3, kind: 'over', p: r.p, peak: r.peak, first: r.overW[0], last: r.overW[r.overW.length - 1], count: r.overW.length, at: r.overW[0] });
    }
    for (const p of D.ppl) {
      if (p.end == null) continue;
      const after = (X.countByPerson.get(p.id) || []).filter(a => !a.noEnd && a.live && a.e > p.end && a.e >= X.T);
      if (after.length) items.push({ sev: 3, kind: 'contract', p, after, at: p.end });
      else if (p.end >= X.T && p.end <= X.T + 56 * DAY) items.push({ sev: 1, kind: 'ending', p, at: p.end });
    }
    if (!D.filtered) {
      for (const a of X.openRoles) {
        if (a.ce < X.T) continue;
        const inPeriod = a.ce >= P.from && a.s <= P.to;
        if (!inPeriod && a.s > X.T + 28 * DAY) continue;
        items.push({ sev: a.s <= X.T ? 3 : 2, kind: 'open', a, at: a.s });
      }
      for (const s of X.skills) {
        if (!s.critical) continue;
        const c = coverage(s.id);
        if (c.adv < 2) items.push({ sev: 2, kind: 'thin', s, c, at: 9e15 });
      }
      for (const pr of X.projects) {
        if (!COUNTS.has(pr.status)) continue;
        if (pr.kind === 'outcome' && !X.P.has(pr.leadId)) items.push({ sev: 1, kind: 'nolead', pr, at: pr.start ?? X.T });
        if (pr.kind === 'network' && pr.review != null && pr.review <= X.T + 28 * DAY) items.push({ sev: pr.review < X.T ? 2 : 1, kind: 'review', pr, at: pr.review });
      }
    }
    const unclassified = new Set();
    for (const a of X.asg) if (a.live && !a.focus && a.ce >= P.from && a.s <= P.to && (!D.filtered || (a.personId && D.ppl.some(p => p.id === a.personId)))) unclassified.add(a.projectId);
    if (unclassified.size) items.push({ sev: 1, kind: 'unclassified', n: unclassified.size, first: [...unclassified][0], at: 9e15 - 1 });
    const oos = subValue(D.A.subs, ['oos-handover']);
    if (oos >= 0.05) items.push({ sev: 1, kind: 'oos', v: oos, at: 9e15 - 2 });
    for (const a of X.asg) {
      if (!a.personId || !a.live || !a.skillId || !a.minLevel || a.e < X.T) continue;
      const p = X.P.get(a.personId);
      if (!p || !D.ppl.includes(p)) continue;
      const lvl = p.skills[a.skillId] || 0;
      if (lvl < a.minLevel) items.push({ sev: 1, kind: 'below', a, p, lvl, at: a.s });
    }
    items.sort((x, y) => y.sev - x.sev || x.at - y.at);
    return items;
  });
}

// People ranked for a role. `need` is a share of one full-time person (% FTE).
function candidates({ skillId, minLevel, s, e, need }) {
  const X = ix();
  if (s == null || e == null || e < s) return [];
  const weeks = [];
  for (let wk = monday(s); wk <= e && weeks.length < 52; wk += 7 * DAY) weeks.push(wk);
  const out = [];
  for (const p of X.people) {
    if (p.end != null && p.end < s) continue;
    if (p.start != null && p.start > e) continue;
    const level = skillId ? (p.skills[skillId] || 0) : null;
    if (skillId && level < Math.max(1, minLevel || 1)) continue;
    let fit = 0, sumFree = 0, minFree = 1, offW = 0;
    const marks = [];
    for (const wk of weeks) {
      const r = week(p, wk);
      if (r.work === 0 || r.avail === 0) { offW++; marks.push('off'); minFree = 0; continue; }
      const free = clamp((r.cap - r.alloc) / (r.avail / 5), 0, p.fte / 100);
      const ok = free + 1e-6 >= need / 100;
      if (ok) fit++;
      marks.push(ok ? 'ok' : free > 0.05 ? 'part' : '');
      sumFree += free; minFree = Math.min(minFree, free);
    }
    const n = weeks.length - offW;
    const avgFree = n > 0 ? sumFree / n : 0;
    out.push({ p, level, fit, weeks: weeks.length, avgFree, minFree, offW, marks, score: (weeks.length ? fit / weeks.length : 0) * 100 + (level || 0) * 6 + avgFree * 20 });
  }
  out.sort((a, b) => b.score - a.score || a.p.name.localeCompare(b.p.name));
  return out;
}

// ===================================================================
// Render helpers
// ===================================================================
const pill = (kind, text, ic) => `<span class="pill ${kind}">${ic ? icon(ic) : ''}${esc(text)}</span>`;
const STATUS_KIND = { Active: 'accent', Planned: 'neutral', 'On hold': 'warn', Completed: 'muted' };
const statusPill = s => pill(STATUS_KIND[s] || 'neutral', s);
function sevPill(sev) {
  if (sev === 3) return pill('crit', 'Critical', 'alert');
  if (sev === 2) return pill('warn', 'Warning', 'alert');
  return pill('neutral', 'Check', 'info');
}
function staffPill(st) {
  const ic = st.state === 'good' ? 'check' : (st.state === 'crit' || st.state === 'warn') ? 'alert' : '';
  return pill(st.state, st.label, ic);
}
const kindTag = (k, plural) => `<span class="ktag"><i class="kd k-${k}" aria-hidden="true"></i>${esc(plural ? KIND[k].plural : KIND[k].label)}</span>`;
const areaLabel = a => `${a.n} · ${a.name}`;
function focusText(sid) {
  const s = SUB.get(sid);
  return s ? `${s.area.n} · ${s.name}` : 'Focus not set';
}
const focusHtml = sid => (SUB.has(sid) ? `<span class="flab">${esc(focusText(sid))}</span>` : `<span class="flab none">Focus not set</span>`);
const leadLabel = k => (k === 'outcome' ? 'Outcome Lead' : k === 'network' ? 'Steward' : 'Lead');
function actDates(pr) {
  if (pr.end == null) return pr.start != null ? `Since ${fd(pr.start)} · ongoing` : 'Ongoing';
  return fdr(pr.start, pr.end);
}
const whenTxt = a => (a.ongoing ? `From ${fd(a.s)} · ongoing` : fdr(a.s, a.e));
function initials(n) { const p = n.split(/\s+/).filter(Boolean); return ((p[0] || '?')[0] + (p.length > 1 ? p[p.length - 1][0] : '')).toUpperCase(); }
const avatar = (p, lg) => `<span class="av${lg ? ' lg' : ''}" aria-hidden="true">${esc(initials(p.name))}</span>`;
const pips = l => `<span class="pips" role="img" aria-label="${LEVELS[l] || 'None'}">${[1, 2, 3, 4].map(i => `<i class="${i <= l ? 'on' : ''}"></i>`).join('')}</span>`;
const meterHtml = u => `<span class="meter${u > 1.005 ? ' over' : ''}" aria-hidden="true"><i style="width:${Math.min(100, Math.max(0, u * 100)).toFixed(1)}%"></i></span>`;
function groupBy(list, keyFn) {
  const out = [];
  const idx = new Map();
  for (const x of list) { const k = keyFn(x); if (!idx.has(k)) { idx.set(k, out.length); out.push([k, []]); } out[idx.get(k)][1].push(x); }
  return out;
}
function teamGroups(people) {
  const g = groupBy(people, p => p.team);
  g.sort((a, b) => (a[0] === '') - (b[0] === '') || a[0].localeCompare(b[0]));
  return g;
}
function topSkills(p, n) {
  const X = ix();
  return Object.entries(p.skills).filter(([sid]) => X.K.has(sid)).sort((a, b) => b[1] - a[1] || X.K.get(a[0]).name.localeCompare(X.K.get(b[0]).name)).slice(0, n);
}
function skillChips(p, n, hl) {
  const X = ix();
  let pick = topSkills(p, n);
  if (hl && p.skills[hl] && X.K.has(hl) && !pick.some(([s]) => s === hl)) pick = [[hl, p.skills[hl]], ...pick.slice(0, n - 1)];
  return pick.map(([sid, l]) => `<span class="chip${sid === hl ? ' hit' : ''}">${esc(X.K.get(sid).name)} ${pips(l)}</span>`).join('');
}
const editBtnsInner = (kind, id, label) => canEdit()
  ? `<button type="button" class="btn small icon-btn ghost" data-act="edit-${kind}" data-id="${esc(id)}" aria-label="Edit ${esc(label)}">${icon('edit')}</button><button type="button" class="btn small icon-btn ghost danger" data-act="del-${kind}" data-id="${esc(id)}" aria-label="Delete ${esc(label)}">${icon('trash')}</button>`
  : '';
const editBtns = (kind, id, label) => (canEdit() ? `<span class="row-actions">${editBtnsInner(kind, id, label)}</span>` : '');
function cellText(r, metric) {
  if (r.work === 0) return '';
  if (r.avail === 0) return 'Off';
  if (metric === 'free') return pctNum(r.free);
  return String(Math.round(r.util * 100));
}
function cellAria(p, r, wk) {
  if (r.work === 0) return `${p.name}, ${wkCode(wk)}: not employed`;
  if (r.avail === 0) return `${p.name}, ${wkCode(wk)}: off all week`;
  return `${p.name}, ${wkCode(wk)}: ${fmtPct(r.util)} booked, ${pctFte(r.free)} free${r.off ? `, ${r.off} days off` : ''}`;
}
const homeName = id => (AREA.has(id) ? AREA.get(id).name : '');
const homeRank = p => (AREA.has(p.home) ? AREA.get(p.home).n : 99);

function options(kind, value, group) {
  const X = ix();
  const o = (v, l) => `<option value="${esc(v)}"${String(v) === String(value) ? ' selected' : ''}>${esc(l)}</option>`;
  switch (kind) {
    case 'teams': {
      const home = group && app.f[group] ? app.f[group].home : '';
      return o('', 'All teams') + teamsFor(home).map(t => o(t, t)).join('');
    }
    case 'homes': return o('', 'All Capability Homes') + HOMES.map(a => o(a.id, areaLabel(a))).join('');
    case 'kinds': return o('', 'All types') + KINDS.map(k => o(k.id, k.plural)).join('');
    case 'areas': return o('', 'All focus areas') + FOCUS.map(a => o(a.id, areaLabel(a))).join('') + (group === 'activities' ? o('-', 'Focus not set') : '');
    case 'periods': return groupBy(periods(), p => p.group).map(([g, l]) => `<optgroup label="${esc(g)}">${l.map(p => o(p.id, p.label)).join('')}</optgroup>`).join('');
    case 'cats': return o('', 'All categories') + X.cats.map(c => o(c, c)).join('');
    case 'skills': return o('', 'Any skill') + groupBy(X.skills, s => s.cat).map(([cat, l]) => `<optgroup label="${esc(cat)}">${l.map(s => o(s.id, s.name)).join('')}</optgroup>`).join('');
    case 'levels': return [[1, 'Basic or above'], [2, 'Working or above'], [3, 'Advanced or above'], [4, 'Expert']].map(([v, l]) => o(v, l)).join('');
    case 'ptypes': return o('', 'Everyone') + o('Employee', 'Employees') + o('Contractor', 'Contractors');
    case 'psort': return [['name', 'Name'], ['free', 'Most available'], ['util', 'Most booked'], ['team', 'Team']].map(([v, l]) => o(v, l)).join('');
    case 'weekcounts': return [[8, '8 weeks'], [12, '12 weeks'], [26, '26 weeks']].map(([v, l]) => o(v, l)).join('');
    default: return '';
  }
}
function syncSelects(root) {
  for (const sel of $$('select[data-opts]', root)) {
    const [g, k] = sel.dataset.bind.split('.');
    const cur = app.f[g][k];
    const html = options(sel.dataset.opts, cur, g);
    if (sel._html !== html) { sel.innerHTML = html; sel._html = html; }
    if (String(sel.value) !== String(cur)) app.f[g][k] = typeof cur === 'number' ? Number(sel.value) : sel.value;
  }
}

// ===================================================================
// Chrome: navigation, status, banners
// ===================================================================
const VIEWS = {};
function renderChrome() {
  const X = ix();
  const V = VIEWS[app.view];
  $('#weekStamp').textContent = `Week ${isoWeek(X.W0).w} · ${fdr(X.W0, X.W0 + 4 * DAY)}`;
  $('#viewTitle').textContent = V.title;
  $('#viewSub').textContent = app.ready ? V.sub() : ' ';
  for (const a of $$('#nav a')) { if (a.dataset.nav === app.view) a.setAttribute('aria-current', 'page'); else a.removeAttribute('aria-current'); }
  const conn = $('#conn');
  if (app.mode === 'shared') conn.innerHTML = `${icon('cloud')}<span><strong>Shared planner</strong>${app.canWrite === false ? 'You can view, not edit' : 'Changes save for everyone with access'}</span>`;
  else if (app.mode === 'local') conn.innerHTML = `${icon('device')}<span><strong>This browser only</strong>Changes stay on this device</span>`;
  else conn.innerHTML = `${icon('cloud')}<span><strong>Connecting…</strong></span>`;
  const ta = $('#topActions');
  const html = (app.mode === 'shared' && app.canWrite === false ? `<span class="chip-ro">View only</span>` : '')
    + (canEdit() ? `<button type="button" class="btn" data-act="import">${icon('upload')}Import</button>` : '')
    + `<button type="button" class="btn primary" data-act="export">${icon('download')}Export to Excel</button>`;
  if (ta._html !== html) { ta.innerHTML = html; ta._html = html; }
  const bn = $('#banners');
  const bh = banners();
  if (bn._html !== bh) { bn.innerHTML = bh; bn._html = bh; }
}
function banners() {
  const out = [];
  if (app.stale) out.push(`<div class="banner warn">${icon('alert')}<p>${app.ready ? 'The shared data can’t be reached right now, so what you see may be out of date.' : 'The planner’s data can’t be reached yet. It will appear as soon as the connection is back.'}</p></div>`);
  if (app.mode === 'local') out.push(`<div class="banner">${icon('info')}<p>This copy isn’t connected to shared storage, so changes are saved in this browser only. Use Export to Excel to keep a copy or pass it on.</p></div>`);
  if (app.ready) {
    const n = c => [...S[c].values()].filter(d => d && d.sample).length;
    const np = n('people'), nj = n('projects'), na = n('assignments');
    if (np + nj + na + n('timeoff') > 0) {
      out.push(`<div class="banner sample">${icon('info')}<p><strong>Example data.</strong> ${plural(np, 'person', 'people')}, ${plural(nj, 'activity', 'activities')} and ${plural(na, 'booking')} are made up so you can try the planner. ${canEdit() ? 'Remove them when you’re ready to add your own team.' : ''}</p>${canEdit() ? `<button type="button" class="btn small" data-act="remove-samples">Remove examples</button>` : ''}</div>`);
    }
  }
  return out.join('');
}
function loadingState() {
  if (app.stale) return `<div class="state"><h2>Can’t reach the planner’s data yet</h2><p>People, activities and bookings will appear here as soon as the connection is back. There’s no need to reload.</p></div>`;
  return `<div class="state" aria-busy="true"><h2>Loading the planner…</h2><p>People, activities, bookings and time off will appear here in a moment.</p></div>`;
}
const canLoadSamples = () => canEdit() && typeof SEED_DATA !== 'undefined' && ![...S.people.values()].some(d => d && d.sample);
function emptyState(kind) {
  const ed = canEdit();
  const copy = {
    people: ['No people yet', 'Add the people on your team with their Capability Home, FTE and skills, or import them from an Excel workbook.'],
    activities: ['No activities yet', 'Create Capability Home work, Outcome Teams and Franchise Networks, then book people on them with a share of their FTE.'],
    skills: ['No skills yet', 'Build your skills catalogue first, then rate each person from Basic to Expert.'],
  }[kind];
  if (copy) {
    const btn = { people: ['add-person', 'userplus', 'Add a person'], activities: ['add-project', 'plus', 'Add an activity'], skills: ['add-skill', 'plus', 'Add a skill'] }[kind];
    return `<div class="state"><h2>${copy[0]}</h2><p>${copy[1]}</p>${ed ? `<div class="actions"><button type="button" class="btn primary" data-act="${btn[0]}">${icon(btn[1])}${btn[2]}</button><button type="button" class="btn" data-act="import">${icon('upload')}Import from Excel</button></div>` : ''}</div>`;
  }
  return `<div class="state">
    <h2>Start your Impact@Scale plan</h2>
    <p>Add your people and the activities they work on. Every activity is Capability Home work, an Outcome Team or a Franchise Network, with a focus area from the resource allocation paper. Availability is measured as a share of FTE.</p>
    <ol class="steps"><li>Add people with their Capability Home, team, FTE and skills.</li><li>Create activities and book people on them with a share of their FTE.</li><li>Record time off and public holidays.</li></ol>
    ${ed ? `<div class="actions">${canLoadSamples() ? `<button type="button" class="btn primary" data-act="load-samples">${icon('eye')}Try it with example data</button>` : ''}<button type="button" class="btn${canLoadSamples() ? '' : ' primary'}" data-act="add-person">${icon('userplus')}Add a person</button><button type="button" class="btn" data-act="add-project">${icon('plus')}Add an activity</button><button type="button" class="btn" data-act="import">${icon('upload')}Import from Excel</button></div>` : ''}
  </div>`;
}

// ===================================================================
// Charts: stacked columns against a capacity line, in FTE
// ===================================================================
const CHARTS = new Map();
function niceScale(max, count = 4) {
  const m = Math.max(max, 1e-6);
  const raw = m / count;
  const mag = Math.pow(10, Math.floor(Math.log10(raw)));
  const nrm = raw / mag;
  const step = (nrm <= 1 ? 1 : nrm <= 2 ? 2 : nrm <= 5 ? 5 : 10) * mag;
  const top = Math.ceil(m / step - 1e-9) * step;
  const ticks = [];
  for (let i = 0; i * step <= top + step / 1000; i++) ticks.push(+(i * step).toFixed(6));
  return { max: top || step, ticks };
}
const fmtTick = v => (Math.abs(v - Math.round(v)) < 1e-6 ? String(Math.round(v)) : fmt1(v));
function roundTop(x, y, w, h, r) {
  const f = v => v.toFixed(1);
  return `M${f(x)} ${f(y + h)}V${f(y + r)}Q${f(x)} ${f(y)} ${f(x + r)} ${f(y)}H${f(x + w - r)}Q${f(x + w)} ${f(y)} ${f(x + w)} ${f(y + r)}V${f(y + h)}Z`;
}
const chartTotal = (s, cfg) => cfg.keys.reduce((t, k) => t + (s[k.k] || 0), 0);
function stackChart(el, cfg) {
  const { series, noCap, keys } = cfg;
  const W = Math.max(260, Math.floor(el.getBoundingClientRect().width || 600));
  const H = cfg.height || 236;
  const m = { t: 12, r: 6, b: 38, l: 40 };
  const iw = W - m.l - m.r, ih = H - m.t - m.b;
  const n = series.length;
  if (!n) { el.innerHTML = ''; return; }
  const vmax = Math.max(cfg.floor || 0.5, ...series.map(s => Math.max(chartTotal(s, cfg), noCap ? 0 : s.cap)));
  const sc = niceScale(vmax);
  const y = v => m.t + ih - v / sc.max * ih;
  const band = iw / n;
  const bw = Math.min(cfg.barMax || 24, Math.max(4, band * 0.58));
  let out = '';
  out += series.map((s, i) => `<rect class="hit" x="${(m.l + band * i).toFixed(1)}" y="${m.t}" width="${band.toFixed(1)}" height="${ih}" tabindex="0" data-tip="chart:${cfg.id}:${i}" aria-label="${esc(chartAria(s, cfg))}"></rect>`).join('');
  for (const t of sc.ticks) {
    const yy = y(t).toFixed(1);
    out += `<line class="${t === 0 ? 'bl' : 'gl'}" x1="${m.l}" x2="${W - m.r}" y1="${yy}" y2="${yy}"></line><text class="ax" x="${m.l - 8}" y="${yy}" text-anchor="end" dominant-baseline="middle">${fmtTick(t)}</text>`;
  }
  const every = Math.max(1, Math.ceil(46 / band));
  series.forEach((s, i) => {
    const x0 = m.l + band * i + (band - bw) / 2;
    const segs = keys.map(k => [k.color, s[k.k] || 0]).filter(g => g[1] > sc.max / 500);
    let base = 0;
    segs.forEach((g, k) => {
      const top = base + g[1];
      const y1 = y(top), y0 = y(base) - (k > 0 ? 2 : 0);
      const h = y0 - y1;
      if (h > 0.4) {
        out += k === segs.length - 1
          ? `<path d="${roundTop(x0, y1, bw, h, Math.min(4, h, bw / 2))}" style="fill:${g[0]}"></path>`
          : `<rect x="${x0.toFixed(1)}" y="${y1.toFixed(1)}" width="${bw.toFixed(1)}" height="${h.toFixed(1)}" style="fill:${g[0]}"></rect>`;
      }
      base = top;
    });
    if (i % every === 0) {
      const cx = (m.l + band * (i + 0.5)).toFixed(1);
      const [l1, l2] = cfg.xl(s);
      out += `<text class="axw${cfg.isNow(s) ? ' now' : ''}" x="${cx}" y="${H - m.b + 16}" text-anchor="middle">${esc(l1)}</text>${l2 ? `<text class="ax" x="${cx}" y="${H - m.b + 30}" text-anchor="middle">${esc(l2)}</text>` : ''}`;
    }
  });
  if (!noCap) {
    const pts = series.map((s, i) => [m.l + band * (i + 0.5), y(s.cap)]);
    if (n > 1) out += `<path class="capline" d="${pts.map((p, i) => (i ? 'L' : 'M') + p[0].toFixed(1) + ' ' + p[1].toFixed(1)).join(' ')}"></path>`;
    out += pts.map(p => `<circle class="capdot" cx="${p[0].toFixed(1)}" cy="${p[1].toFixed(1)}" r="4"></circle>`).join('');
  }
  el.innerHTML = `<svg width="${W}" height="${H}" viewBox="0 0 ${W} ${H}" role="group" aria-label="${esc(cfg.title)}">${out}</svg>`;
}
function chartAria(s, cfg) {
  const parts = [cfg.name(s), ...cfg.keys.map(k => `${k.label} ${fmtFte(s[k.k] || 0)}`)];
  if (!cfg.noCap) parts.push(`capacity ${fmtFte(s.cap)}`);
  return parts.join(', ');
}
function drawCharts(root = document) {
  for (const el of $$('[data-chart]', root)) { const c = CHARTS.get(el.dataset.chart); if (c) stackChart(el, c); }
}
function chartTable(cfg) {
  const { series, noCap, keys } = cfg;
  return `<table class="data"><thead><tr><th scope="col">${esc(cfg.unitName)}</th>${noCap ? '' : '<th scope="col">Capacity (FTE)</th>'}${keys.map(k => `<th scope="col">${esc(k.label)} (FTE)</th>`).join('')}${noCap ? '' : '<th scope="col">Booked</th>'}</tr></thead><tbody>${series.map(s => `<tr><td>${esc(cfg.name(s))}</td>${noCap ? '' : `<td>${fx1(s.cap)}</td>`}${keys.map(k => `<td>${fx1(s[k.k] || 0)}</td>`).join('')}${noCap ? '' : `<td>${fmtPct(s.cap ? chartTotal(s, cfg) / s.cap : null)}</td>`}</tr>`).join('')}</tbody></table>`;
}
function chartLegend(cfg) {
  return `<div class="legend">${cfg.keys.map(k => `<span><i class="sw" style="background:${k.color}"></i>${esc(k.label)}</span>`).join('')}${cfg.noCap ? '' : '<span><i class="sw line" style="background:var(--fg)"></i>Available capacity</span>'}</div>`;
}
const KEY_BOOK = [{ k: 'conf', color: 'var(--s-conf)', label: 'Confirmed' }, { k: 'tent', color: 'var(--s-tent)', label: 'Tentative' }];
const KEY_OPEN = { k: 'open', color: 'var(--s-open)', label: 'Open roles' };
const KEY_KINDS = KINDS.map(k => ({ k: k.id, color: `var(${k.cssv})`, label: k.plural }));
function weekCfg(id, series, extra) {
  const X = ix();
  return Object.assign({ id, series, keys: KEY_BOOK, unitName: 'Week', xl: s => [wkCode(s.wk), fd(s.wk, false)], isNow: s => s.wk === X.W0, name: s => `${wkCode(s.wk)} · ${fdr(s.wk, s.wk + 4 * DAY)}` }, extra);
}

// Timeline of activities across the months around today.
function timeline(list) {
  const X = ix();
  if (!list.length) return `<p class="empty-note">No activities to show.</p>`;
  const t = new Date(X.T);
  const y0 = t.getUTCFullYear(), m0 = t.getUTCMonth();
  const from = Date.UTC(y0, m0 - 1, 1), to = Date.UTC(y0, m0 + 8, 1);
  const span = to - from;
  const pct = ms => (clamp(ms, from, to) - from) / span * 100;
  const months = Array.from({ length: 9 }, (_, i) => Date.UTC(y0, m0 - 1 + i, 1));
  const axis = months.map(ms => { const d = new Date(ms); return `<span style="left:${pct(ms).toFixed(2)}%">${MON[d.getUTCMonth()]}${d.getUTCMonth() === 0 ? ' ' + d.getUTCFullYear() : ''}</span>`; }).join('');
  const grid = months.map(ms => `<i style="left:${pct(ms).toFixed(2)}%"></i>`).join('') + `<i class="today" style="left:${pct(X.T).toFixed(2)}%"><b>Today</b></i>`;
  const rows = list.map(pr => {
    const st = staffing(pr);
    const s = pr.start ?? X.T, e = pr.end ?? to;
    const visible = e >= from && s < to;
    const l = pct(s), r = pct(e + DAY);
    const cls = { Active: '', Planned: 'planned', 'On hold': 'hold', Completed: 'done' }[pr.status] || '';
    const bar = visible ? `<span class="tl-bar ${cls} k-${pr.kind}${s < from ? ' cut-l' : ''}${pr.end == null || e + DAY > to ? ' cut-r' : ''}" style="left:${l.toFixed(2)}%;width:${Math.max(0.6, r - l).toFixed(2)}%">${st.open.length && COUNTS.has(pr.status) ? '<i class="openmark"></i>' : ''}</span>` : '';
    return `<button type="button" class="tl-row" data-act="open-project" data-id="${esc(pr.id)}" data-tip="tl:${esc(pr.id)}">
      <span class="tl-label"><strong>${esc(pr.name)}</strong><span class="meta">${kindTag(pr.kind)}${statusPill(pr.status)}${COUNTS.has(pr.status) && st.state !== 'good' && st.set.length ? staffPill(st) : ''}</span></span>
      <span class="tl-track">${bar}</span></button>`;
  }).join('');
  return `<div class="tl"><div class="tl-axis" aria-hidden="true"><span></span><div class="tl-axis-track">${axis}</div></div><div class="tl-body"><div class="tl-grid" aria-hidden="true">${grid}</div>${rows}</div></div>`;
}

// ===================================================================
// Impact@Scale building blocks
// ===================================================================
// A horizontal stack of segments. `segs` = [{ k, v, label }]; widths are v / scale.
function hstack(segs, scale, opts = {}) {
  const parts = segs.filter(s => s.v > scale / 1000).map(s => {
    const w = clamp(s.v / scale * 100, 0, 100);
    const lab = opts.labels && w >= (opts.minLabel || 9) ? `<b>${Math.round(s.v / (opts.labelBase || scale) * 100)}%</b>` : '';
    return `<i class="hs k-${s.k}" style="flex-basis:${w.toFixed(2)}%">${lab}</i>`;
  }).join('');
  return `<span class="hstack${opts.cls ? ' ' + opts.cls : ''}"${opts.tip ? ` data-tip="${esc(opts.tip)}"` : ''}${opts.aria ? ` role="img" aria-label="${esc(opts.aria)}"` : ' aria-hidden="true"'}>${opts.ref != null ? `<span class="ref" style="left:${clamp(opts.ref / scale * 100, 0, 100).toFixed(2)}%"></span>` : ''}${parts}</span>`;
}
const kindLegend = (withFree, only) => `<div class="legend">${KINDS.filter(k => !only || k.id === only).map(k => `<span><i class="sw k-${k.id}"></i>${esc(k.plural)}</span>`).join('')}${withFree ? '<span><i class="sw k-free"></i>Unallocated</span>' : ''}</div>`;
function selectionLabel(f) {
  const parts = [];
  if (f.kind) parts.push(KIND[f.kind].plural);
  if (f.area) parts.push(areaLabel(AREA.get(f.area)));
  return parts.join(' · ');
}
// FTE a person (or a total) spends in the current selection (type and/or focus area).
function selValue(r, f) {
  let v = 0;
  for (const [sid, sv] of r.subs) {
    if (f.area && !(SUB.has(sid) && SUB.get(sid).area.id === f.area)) continue;
    v += f.kind ? sv[f.kind] : sv.home + sv.outcome + sv.network;
  }
  return v;
}

// ===================================================================
// Dashboard
// ===================================================================
VIEWS.dashboard = {
  title: 'Dashboard',
  sub() {
    const X = ix();
    const fte = X.people.reduce((s, p) => s + p.fte / 100, 0);
    const n = k => X.projects.filter(p => p.kind === k && COUNTS.has(p.status)).length;
    return `${plural(X.people.length, 'person', 'people')} · ${fmtFte(fte)} · ${plural(n('outcome'), 'Outcome Team')} · ${plural(n('network'), 'Franchise Network')}`;
  },
  shell() {
    return `<div class="filters" role="group" aria-label="Dashboard filters">
      <label class="field"><span>Period</span><select id="dPeriod" data-bind="dash.period" data-opts="periods"></select></label>
      <label class="field"><span>Capability Home</span><select id="dHome" data-bind="dash.home" data-opts="homes"></select></label>
      <label class="field"><span>Team</span><select id="dTeam" data-bind="dash.team" data-opts="teams"></select></label>
    </div><div id="vb"></div>`;
  },
  body(vb) {
    const X = ix();
    const f = app.f.dash;
    if (!X.people.length && !X.projects.length) { vb.innerHTML = emptyState(); return; }
    const D = dashData(f.period, f.home, f.team);
    const P = D.P;
    const t = D.A.tot;
    const over = D.per.filter(r => r.overW.length).sort((a, b) => b.peak - a.peak);
    const cfg = weekCfg('dash', D.series, { keys: D.filtered ? KEY_BOOK : KEY_BOOK.concat(KEY_OPEN), title: 'Capacity and demand by week, in FTE' });
    CHARTS.set('dash', cfg);
    const items = attention(f.period, f.home, f.team);
    const shown = f.allAlerts ? items : items.slice(0, 7);
    const who = [f.home ? AREA.get(f.home).name : '', f.team].filter(Boolean).join(' · ') || 'everyone';
    vb.innerHTML = `
    <section class="kpis" aria-label="Key figures for ${esc(P.name)}">
      <div class="kpi">
        <div class="kpi-label">Utilization</div>
        <div class="kpi-value">${t.util == null ? '—' : Math.round(t.util * 100)}<span class="unit">%</span></div>
        <span class="meter${t.util > 1.005 ? ' over' : ''}" aria-hidden="true"><i class="tent" style="width:${Math.min(100, (t.util || 0) * 100).toFixed(1)}%"></i><i style="width:${Math.min(100, (t.cap ? t.conf / t.cap : 0) * 100).toFixed(1)}%"></i></span>
        <div class="kpi-sub">${fmtPct(t.cap ? t.conf / t.cap : null)} confirmed · ${esc(P.short)}</div>
      </div>
      <div class="kpi">
        <div class="kpi-label">Free capacity</div>
        <div class="kpi-value">${fmt1(t.free)}<span class="unit">FTE</span></div>
        <div class="kpi-sub">${fmtPct(t.cap ? t.free / t.cap : null)} of ${fmtFte(t.cap)} available</div>
      </div>
      <div class="kpi">
        <div class="kpi-label">Over-allocated ${over.length ? pill('crit', 'Review', 'alert') : ''}</div>
        <div class="kpi-value">${over.length}<span class="unit">${over.length === 1 ? 'person' : 'people'}</span></div>
        <div class="kpi-sub">${over.length ? `Highest: ${esc(over[0].p.name)}, ${fmtPct(over[0].peak)} in a week` : 'No one is booked above 100% in any week'}</div>
      </div>
      <div class="kpi">
        <div class="kpi-label">Open roles ${D.open.some(a => a.s <= X.T + 28 * DAY) ? pill('warn', 'Soon', 'alert') : ''}</div>
        <div class="kpi-value">${D.open.length}<span class="unit">${D.open.length === 1 ? 'role' : 'roles'}</span></div>
        <div class="kpi-sub">${fmtFte(D.openFte)} nobody is booked for${D.filtered ? ' · all teams' : ''}</div>
      </div>
    </section>
    ${focusSection(D)}
    <div class="sec-h"><div><h2>Capacity and staffing</h2><p>${esc(P.label.replace(/ \(.*\)$/, ''))} · ${esc(who)}. Capacity is measured in FTE after time off and public holidays.</p></div></div>
    <div class="cols">
      <section class="panel">
        <div class="panel-head"><div><h2>Needs attention</h2><p>Over-allocations, unstaffed roles, register gaps and thin skill coverage.</p></div>${items.length ? `<span class="count">${items.length}</span>` : ''}</div>
        ${items.length ? `<ul class="alerts">${shown.map(alertItem).join('')}</ul>${items.length > shown.length ? `<button type="button" class="btn small ghost" data-act="att-all" style="margin-top:10px">Show ${items.length - shown.length} more</button>` : ''}` : `<p class="empty-note">${icon('check')}Nothing needs attention in this period.</p>`}
      </section>
      <section class="panel">
        <div class="panel-head"><div><h2>${f.team ? 'Utilization by person' : 'Utilization by team'}</h2><p>Booked FTE as a share of available FTE, ${esc(P.short)}. The line marks 100%.</p></div></div>
        ${utilBars(D, f.team)}
      </section>
    </div>
    <section class="panel">
      <div class="panel-head">
        <div><h2>Capacity and demand by week</h2><p>FTE booked each week against the FTE people can work after time off and public holidays.${D.filtered ? '' : ' Open roles add the demand nobody is booked for yet.'}</p></div>
        <button type="button" class="btn small ghost" data-act="toggle-table" data-target="capTable" aria-expanded="false" aria-controls="capTable">Show as table</button>
      </div>
      ${chartLegend(cfg)}
      <div class="chart" data-chart="dash"></div>
      <div class="table-wrap" id="capTable" hidden>${chartTable(cfg)}</div>
    </section>
    <div class="cols">
      ${benchPanel(D)}
      ${offPanelDash(D)}
    </div>
    <section class="panel">
      <div class="panel-head"><div><h2>Outcome Teams</h2><p>Active, planned and paused Outcome Teams. An orange dot means the team has open roles.</p></div><a class="btn small ghost" href="#activities">All activities</a></div>
      ${timeline(X.projects.filter(p => p.kind === 'outcome' && p.status !== 'Completed'))}
    </section>`;
    drawCharts(vb);
  },
};

// ---------- Where the time goes ----------
function focusSection(D) {
  const f = app.f.dash;
  const P = D.P;
  const sel = selectionLabel(f);
  const months = [];
  const t = new Date(ix().T);
  for (let k = -3; k <= 6; k++) months.push({ k, from: mStart(t.getUTCFullYear(), t.getUTCMonth() + k), to: mEnd(t.getUTCFullYear(), t.getUTCMonth() + k) });
  const ppl = D.ppl;
  const tkey = f.home + '|' + f.team;
  const series = months.map(m => {
    const A = allocCalc(m.from, m.to, ppl, tkey);
    const kt = f.area ? kindTotals(A.subs, f.area) : A.tot;
    const s = { m: m.from, now: m.k === 0, cap: A.tot.cap, home: 0, outcome: 0, network: 0 };
    for (const k of KINDS) if (!f.kind || f.kind === k.id) s[k.id] = kt[k.id];
    return s;
  });
  const tcfg = {
    id: 'trend', series, keys: KEY_KINDS.filter(k => !f.kind || k.k === f.kind), unitName: 'Month', title: 'Booked FTE by month and type, against available capacity',
    xl: s => { const d = new Date(s.m); return [MON[d.getUTCMonth()], d.getUTCMonth() === 0 || s === series[0] ? String(d.getUTCFullYear()) : '']; },
    isNow: s => s.now, name: s => monthName(s.m, true), barMax: 30, height: 226,
  };
  CHARTS.set('trend', tcfg);
  return `<div class="sec-h" id="focusSec">
      <div><h2>Where the time goes</h2><p>Impact@Scale allocation for ${esc(P.label.replace(/ \(.*\)$/, ''))}: average FTE booked, including tentative bookings${sel ? `. Showing <strong>${esc(sel)}</strong>` : ''}.</p></div>
      <div class="sec-tools">
        <label class="field"><span>Type</span><select data-bind="dash.kind">${options('kinds', f.kind)}</select></label>
        <label class="field"><span>Focus area</span><select data-bind="dash.area">${options('areas', f.area)}</select></label>
        ${sel ? `<button type="button" class="btn small ghost" data-act="dash-clear">${icon('x')}Clear</button>` : ''}
        <button type="button" class="btn small" data-act="guide">${icon('book')}Focus guide</button>
      </div>
    </div>
    <div class="cols">
      ${splitPanel(D)}
      <section class="panel">
        <div class="panel-head"><div><h2>Trend by month</h2><p>Booked FTE per month by type${f.area ? ` in ${esc(AREA.get(f.area).name)}` : ''} against available capacity: where time went, and where it is planned to go.</p></div>
          <button type="button" class="btn small ghost" data-act="toggle-table" data-target="trendTable" aria-expanded="false" aria-controls="trendTable">Show as table</button></div>
        ${chartLegend(tcfg)}
        <div class="chart" data-chart="trend" style="min-height:226px"></div>
        <div class="table-wrap" id="trendTable" hidden>${chartTable(tcfg)}</div>
      </section>
    </div>
    ${focusPanel(D)}
    ${peoplePanel(D)}`;
}

function splitPanel(D) {
  const f = app.f.dash;
  const A = D.A, B = D.B;
  const area = f.area;
  const cur = area ? kindTotals(A.subs, area) : { home: A.tot.home, outcome: A.tot.outcome, network: A.tot.network, total: A.tot.booked };
  const prv = area ? kindTotals(B.subs, area) : { home: B.tot.home, outcome: B.tot.outcome, network: B.tot.network, total: B.tot.booked };
  const base = area ? cur.total : A.tot.booked + A.tot.free;
  const baseP = area ? prv.total : B.tot.booked + B.tot.free;
  const rows = KINDS.map(k => ({ k: k.id, label: k.plural, v: cur[k.id], p: prv[k.id] }));
  if (!area) rows.push({ k: 'free', label: 'Unallocated', v: A.tot.free, p: B.tot.free });
  for (const r of rows) { r.share = base > 0 ? r.v / base : null; r.d = base > 0 && baseP > 0 ? r.v / base - r.p / baseP : null; }
  const aria = rows.map(r => `${r.label} ${fmtPct(r.share)}`).join(', ');
  const empty = base <= 0.0001;
  const ofWhat = area ? `the time booked on ${AREA.get(area).name}` : 'available capacity';
  return `<section class="panel">
    <div class="panel-head"><div><h2>Impact@Scale allocation</h2><p>Share of ${esc(ofWhat)} by type, ${esc(D.P.short)}, compared with ${esc(D.P.prev.short)}.</p></div></div>
    ${empty ? `<p class="empty-note">No booked time${area ? ' in this focus area' : ''} for this period and team.</p>` : `
    ${kindLegend(!area)}
    <div class="split-bar">${hstack(rows.map(r => ({ k: r.k, v: r.v })), base, { labels: true, cls: 'lg', aria: 'Allocation: ' + aria })}</div>
    <div class="table-wrap tight"><table class="data split-t">
      <thead><tr><th scope="col">Type</th><th scope="col">FTE</th><th scope="col">Share</th><th scope="col"><span class="l-long">vs ${esc(D.P.prev.short)}</span><span class="l-short" aria-hidden="true">Chg.</span></th></tr></thead>
      <tbody>${rows.map(r => `<tr data-tip="sp:${r.k}"><th scope="row"><span class="ktag"><i class="kd k-${r.k}" aria-hidden="true"></i>${esc(r.label)}</span></th><td>${fx1(r.v)}</td><td>${fmtPct(r.share)}</td><td class="delta">${fmtPp(r.d)}</td></tr>`).join('')}</tbody>
      <tfoot><tr><th scope="row">${area ? 'Booked in this area' : 'Available capacity'}</th><td>${fx1(area ? cur.total : A.tot.cap)}</td><td>${area ? '100%' : ''}</td><td></td></tr></tfoot>
    </table></div>
    ${!area && A.tot.over > 0.005 ? overNote(A) : ''}
    ${!D.filtered && !area && A.open.total > 0.05 ? `<p class="note">${icon('userplus')}Open roles add ${fmtFte(A.open.total)} of demand nobody is booked for yet${A.open.outcome > 0.05 ? `, ${fmtFte(A.open.outcome)} of it in Outcome Teams` : ''}.</p>` : ''}`}
  </section>`;
}

function overNote(A) {
  const over = [...A.per.values()].filter(r => r.over > 0.005).sort((a, b) => b.over - a.over);
  const who = over.length === 1 ? over[0].p.name + ' is' : plural(over.length, 'person is', 'people are');
  const amt = A.tot.over < 0.95 ? pctFte(A.tot.over) : fmtFte(A.tot.over);
  return `<p class="note warn">${icon('alert')}${esc(who)} booked ${amt} more than available. Shares are of booked plus unallocated time.</p>`;
}
function focusPanel(D) {
  const f = app.f.dash;
  const A = D.A, B = D.B;
  const kind = f.kind;
  const tot = kind ? A.tot[kind] : A.tot.booked;
  const totP = kind ? B.tot[kind] : B.tot.booked;
  const segsFor = (subs, ids) => KINDS.filter(k => !kind || k.id === kind).map(k => ({ k: k.id, v: subValue(subs, ids, k.id) }));
  const rows = [];
  for (const a of FOCUS) {
    const ids = areaSubIds(a);
    rows.push({ area: a, ids, v: subValue(A.subs, ids, kind), p: subValue(B.subs, ids, kind), segs: segsFor(A.subs, ids) });
    if (!(a.subs.length === 1 && a.subs[0].solo)) for (const s of a.subs) rows.push({ sub: s, ids: [s.id], v: subValue(A.subs, [s.id], kind), p: subValue(B.subs, [s.id], kind), segs: segsFor(A.subs, [s.id]) });
  }
  const none = subValue(A.subs, [''], kind), noneP = subValue(B.subs, [''], kind);
  if (none > 0.004) rows.push({ none: true, ids: [''], v: none, p: noneP, segs: segsFor(A.subs, ['']) });
  const scale = Math.max(0.1, ...rows.filter(r => r.area || r.none).map(r => r.v));
  const share = (v, t) => (t > 0 ? v / t : null);
  const body = rows.map(r => {
    const d = tot > 0 && totP > 0 ? r.v / tot - r.p / totP : null;
    const zero = r.v < 0.005;
    const bar = hstack(r.segs, scale, { tip: r.area ? 'fa:' + r.area.id : r.sub ? 'fs:' + r.sub.id : 'fs:-' });
    const cells = `<td class="c-bar">${bar}</td><td>${zero ? '—' : fx1(r.v)}</td><td>${zero ? '—' : fmtPct(share(r.v, tot))}</td><td class="delta">${tot > 0 && totP > 0 ? fmtPp(d) : '—'}</td>`;
    if (r.area) {
      const on = f.area === r.area.id;
      return `<tr class="f-area${zero ? ' zero' : ''}${on ? ' on' : ''}"><th scope="row"><button type="button" class="linkish" data-act="dash-area" data-v="${r.area.id}" aria-pressed="${on}" title="${on ? 'Show all focus areas' : 'Filter the dashboard to this area'}"><span class="fn">${r.area.n}</span>${esc(r.area.name)}</button></th>${cells}</tr>`;
    }
    if (r.none) return `<tr class="f-area none"><th scope="row"><span class="fn">–</span>Focus not set <small>Classify these activities</small></th>${cells}</tr>`;
    return `<tr class="f-sub${zero ? ' zero' : ''}"><th scope="row" data-tip="fx:${r.sub.id}">${esc(r.sub.name)}</th>${cells}</tr>`;
  }).join('');
  return `<section class="panel">
    <div class="panel-head"><div><h2>Capability Home focus</h2><p>Booked time by type of work${kind ? ` in ${esc(KIND[kind].plural)}` : ''}, ${esc(D.P.short)}. Share is of all ${kind ? esc(KIND[kind].plural) + ' time' : 'booked time'}; the change is against ${esc(D.P.prev.short)}. Select an area to filter the dashboard.</p></div>${tot > 0 ? `<span class="count">${fmtFte(tot)}</span>` : ''}</div>
    ${tot <= 0.0001 ? `<p class="empty-note">No booked time${kind ? ` in ${esc(KIND[kind].plural)}` : ''} for this period and team.</p>` : `${kindLegend(false, kind)}
    <div class="table-wrap tight focus-wrap"><table class="data focus-t">
      <thead><tr><th scope="col">Focus area and activity sub-category</th><th scope="col" class="c-bar">By type</th><th scope="col">FTE</th><th scope="col">Share</th><th scope="col"><span class="l-long">vs ${esc(D.P.prev.short)}</span><span class="l-short" aria-hidden="true">Chg.</span></th></tr></thead>
      <tbody>${body}</tbody>
      <tfoot><tr><th scope="row">Total booked</th><td class="c-bar"></td><td>${fx1(tot)}</td><td>100%</td><td></td></tr></tfoot>
    </table></div>`}
  </section>`;
}

function peoplePanel(D) {
  const f = app.f.dash;
  const sel = selectionLabel(f);
  const rows = D.per.map(x => {
    const r = x.a;
    const subs = [...r.subs].filter(([sid]) => sid).sort((a, b) => (b[1].home + b[1].outcome + b[1].network) - (a[1].home + a[1].outcome + a[1].network));
    const top = subs[0];
    return { p: x.p, r, sel: sel ? selValue(r, f) : 0, top: top ? { sid: top[0], v: top[1].home + top[1].outcome + top[1].network } : null };
  }).filter(x => x.r.cap > 0.001 || x.r.booked > 0.001);
  const sort = f.psort === 'sel' && !sel ? 'team' : f.psort;
  if (sort === 'free') rows.sort((a, b) => b.r.free - a.r.free || a.p.name.localeCompare(b.p.name));
  else if (sort === 'sel') rows.sort((a, b) => b.sel - a.sel || a.p.name.localeCompare(b.p.name));
  else if (sort === 'name') rows.sort((a, b) => a.p.name.localeCompare(b.p.name));
  else rows.sort((a, b) => homeRank(a.p) - homeRank(b.p) || (a.p.team || '~').localeCompare(b.p.team || '~') || a.p.name.localeCompare(b.p.name));
  const scale = Math.max(1, ...rows.map(x => Math.max(x.r.cap, x.r.booked)));
  const sorts = [['team', 'Team'], ['name', 'Name'], ['free', 'Most unallocated'], ...(sel ? [['sel', 'Most in selection']] : [])];
  const body = rows.map(x => {
    const r = x.r;
    const segs = [...KINDS.map(k => ({ k: k.id, v: r[k.id] })), { k: 'free', v: r.free }];
    return `<tr>
      <th scope="row"><button type="button" class="linkish" data-act="open-person" data-id="${esc(x.p.id)}">${esc(x.p.name)}</button><small>${esc(x.p.team || homeName(x.p.home) || '—')}</small></th>
      <td class="c-avail">${pctNum(r.cap)}%${x.p.fte < 100 ? `<small>${x.p.fte}% contract</small>` : ''}</td>
      <td class="c-bar">${hstack(segs, scale, { tip: 'pa:' + x.p.id, ref: r.over > 0.005 ? r.cap : null, cls: r.over > 0.005 ? 'over' : '' })}</td>
      ${KINDS.map(k => `<td class="c-k">${r[k.id] > 0.004 ? pctNum(r[k.id]) + '%' : '—'}</td>`).join('')}
      <td class="c-free${r.over > 0.005 ? ' neg' : ''}">${r.over > 0.005 ? '−' + pctNum(r.over) + '%' : pctNum(r.free) + '%'}</td>
      <td class="c-top">${x.top ? `${esc(focusText(x.top.sid))} <span class="faint">${pctNum(x.top.v)}%</span>` : '<span class="faint">—</span>'}</td>
      ${sel ? `<td class="c-sel">${x.sel > 0.004 ? pctNum(x.sel) + '%' : '—'}</td>` : ''}
    </tr>`;
  }).join('');
  return `<section class="panel">
    <div class="panel-head"><div><h2>Where each person’s time goes</h2><p>Average share of one FTE, ${esc(D.P.short)}. Each bar is as long as the time the person is available; the tick marks it when they are booked beyond it.</p></div>
      <div class="seg" role="group" aria-label="Sort people">${sorts.map(([v, l]) => `<button type="button" data-act="dash-psort" data-v="${v}" aria-pressed="${sort === v}">${l}</button>`).join('')}</div></div>
    ${rows.length ? `${kindLegend(true)}<div class="table-wrap tight"><table class="data alloc-t">
      <thead><tr><th scope="col">Person</th><th scope="col">Available</th><th scope="col" class="c-bar">Split</th>${KINDS.map(k => `<th scope="col" class="c-k"><abbr title="${esc(k.plural)}">${esc(k.short)}</abbr></th>`).join('')}<th scope="col">Unallocated</th><th scope="col" class="c-top">Main focus</th>${sel ? `<th scope="col" class="c-sel">${esc(sel)}</th>` : ''}</tr></thead>
      <tbody>${body}</tbody></table></div>` : `<p class="empty-note">No one is available in this period.</p>`}
  </section>`;
}

function alertItem(it) {
  const X = ix();
  const open = (kind, id, label = 'Open') => `<button type="button" class="btn small" data-act="${kind}" data-id="${esc(id)}">${label}</button>`;
  let title = '', text = '', btn = '';
  switch (it.kind) {
    case 'over':
      title = `${it.p.name} is over-allocated`;
      text = `Up to ${fmtPct(it.peak)} of available FTE · ${it.count === 1 ? wkCode(it.first) : wkCode(it.first) + '–' + wkCode(it.last)} · ${plural(it.count, 'week')}`;
      btn = open('open-person', it.p.id);
      break;
    case 'contract':
      title = `${it.p.name} is booked past contract end`;
      text = `Contract ends ${fd(it.p.end)} · ${plural(it.after.length, 'booking')} run${it.after.length === 1 ? 's' : ''} later`;
      btn = open('open-person', it.p.id);
      break;
    case 'ending':
      title = `${it.p.name}’s contract ends ${fd(it.p.end, false)}`;
      text = [it.p.role, it.p.team].filter(Boolean).join(' · ');
      btn = open('open-person', it.p.id);
      break;
    case 'open': {
      const sk = it.a.skillId ? X.K.get(it.a.skillId) : null;
      title = `Open role: ${it.a.role}`;
      text = `${it.a.project.name} · ${it.a.s <= X.T ? 'started' : 'starts'} ${fd(it.a.s, false)} · ${it.a.alloc}% FTE${sk ? ' · ' + sk.name : ''}`;
      btn = canEdit() ? open('find-for', it.a.id, 'Find people') : open('open-project', it.a.projectId);
      break;
    }
    case 'thin':
      title = `Thin coverage: ${it.s.name}`;
      text = it.c.adv === 0 ? 'No one is Advanced or Expert in this business-critical skill' : `Only ${it.c.advPeople[0].name} is Advanced or Expert`;
      btn = open('go-skill', it.s.id, 'View');
      break;
    case 'below':
      title = `${it.p.name} is below the required level`;
      text = `${it.a.role} on ${it.a.project.name} needs ${LEVELS[it.a.minLevel]} ${X.K.get(it.a.skillId).name}; current level ${LEVELS[it.lvl]}`;
      btn = open('open-project', it.a.projectId);
      break;
    case 'nolead':
      title = `${it.pr.name} has no Outcome Lead`;
      text = 'One Outcome, one delivery authority: name the lead in the Outcome Register.';
      btn = open('open-project', it.pr.id);
      break;
    case 'review':
      title = `Forum review ${it.pr.review < X.T ? 'overdue' : 'due'} for ${it.pr.name}`;
      text = `Review date ${fd(it.pr.review)}${it.pr.decision ? ` · last decision: ${it.pr.decision}` : ''}`;
      btn = open('open-project', it.pr.id);
      break;
    case 'unclassified':
      title = `${plural(it.n, 'activity', 'activities')} without a focus area`;
      text = 'Their booked time shows as “Focus not set” in Capability Home focus.';
      btn = `<button type="button" class="btn small" data-act="go-unclassified">Review</button>`;
      break;
    case 'oos':
      title = `${fmtFte(it.v)} on tasks that should not be covered by PPWS`;
      text = 'Document, optimise and plan the hand-over to the right team.';
      btn = `<button type="button" class="btn small" data-act="dash-area" data-v="oos">Show</button>`;
      break;
  }
  return `<li class="alert"><div class="alert-sev">${sevPill(it.sev)}</div><div class="alert-main"><div class="alert-title">${esc(title)}</div><div class="alert-text">${esc(text)}</div></div>${btn}</li>`;
}

function utilBars(D, team) {
  const rows = team
    ? D.per.filter(r => r.a.cap > 0).map(r => ({ label: r.p.name, sub: r.p.role, util: r.a.util, tip: 'pu:' + r.p.id, id: r.p.id }))
    : D.groupRows.map((r, i) => ({ label: r.team || 'No team', sub: plural(r.n, 'person', 'people') + ' · ' + fmtFte(r.cap), util: r.util, tip: 'tu:' + i }));
  if (!rows.length) return `<p class="empty-note">No available capacity in this period.</p>`;
  const max = Math.max(1.2, ...rows.map(r => r.util || 0));
  const x = v => (v / max * 100).toFixed(2) + '%';
  return `<div class="bars">${rows.map(r => `<div class="bar-row" data-tip="${esc(r.tip)}">
      <span class="bar-label">${r.id ? `<button type="button" class="linkish" data-act="open-person" data-id="${esc(r.id)}">${esc(r.label)}</button>` : esc(r.label)}<small>${esc(r.sub || '')}</small></span>
      <span class="bar-track"><i class="bar-fill${r.util > 1.005 ? ' over' : ''}" style="width:${x(Math.min(r.util || 0, max))}"></i><i class="bar-ref" style="left:${x(1)}"></i></span>
      <span class="bar-val">${fmtPct(r.util)}</span></div>`).join('')}</div>
    <div class="bar-axis" aria-hidden="true"><span></span><div>${[0, 0.5, 1].map(v => `<span style="left:${x(v)}">${v * 100}%</span>`).join('')}</div><span></span></div>`;
}

function benchPanel(D) {
  const rows = D.per.map(r => r).filter(r => r.a.cap > 0 && r.a.free >= 0.2 - 1e-6).sort((a, b) => b.a.free - a.a.free);
  const list = rows.slice(0, 7);
  return `<section class="panel">
    <div class="panel-head"><div><h2>Available capacity</h2><p>People with 20% FTE or more unallocated on average, ${esc(D.P.short)}.</p></div>${rows.length ? `<span class="count">${rows.length}</span>` : ''}</div>
    ${list.length ? `<div class="rows">${list.map(r => `<div class="rowi"><div><button type="button" class="linkish" data-act="open-person" data-id="${esc(r.p.id)}">${esc(r.p.name)}</button>
      <div class="d"><span class="num"><strong>${pctFte(r.a.free)}</strong> free</span><span>${esc(r.p.role || r.p.team || '')}</span></div>
      <div class="chips" style="margin-top:6px">${skillChips(r.p, 3)}</div></div>
      ${canEdit() ? `<button type="button" class="btn small" data-act="book-person" data-id="${esc(r.p.id)}">Book</button>` : ''}</div>`).join('')}</div>${rows.length > list.length ? `<p class="faint" style="margin-top:8px">${rows.length - list.length} more in the Availability view.</p>` : ''}`
      : `<p class="empty-note">Everyone is booked for most of this period.</p>`}
  </section>`;
}

function offPanelDash(D) {
  const X = ix();
  const ids = new Set(D.ppl.map(p => p.id));
  const list = X.offs.filter(t => t.e >= D.P.from && t.s <= D.P.to && (t.personId === ALL || ids.has(t.personId)));
  return `<section class="panel">
    <div class="panel-head"><div><h2>Time off</h2><p>Leave, training and public holidays in ${esc(D.P.short)}.</p></div>${list.length ? `<span class="count">${list.length}</span>` : ''}</div>
    ${list.length ? `<div class="rows">${list.slice(0, 7).map(offRow).join('')}</div>${list.length > 7 ? `<p class="faint" style="margin-top:8px"><a href="#availability">See all ${list.length} in Availability</a></p>` : ''}` : `<p class="empty-note">No time off recorded in this period.</p>`}
  </section>`;
}
function offRow(t, withActions) {
  const X = ix();
  const p = t.personId === ALL ? null : X.P.get(t.personId);
  const who = p ? `<button type="button" class="linkish" data-act="open-person" data-id="${esc(p.id)}">${esc(p.name)}</button>` : `<span class="t">Everyone</span>`;
  const days = workdays(t.s, t.e);
  return `<div class="rowi${t.e < X.T ? ' past' : ''}"><div>${who}<div class="d">${pill(t.type === 'Public holiday' ? 'accent' : 'neutral', t.type)}<span class="num">${fdr(t.s, t.e)}</span><span class="num">${plural(days, 'working day')}</span>${t.note ? `<span>${esc(t.note)}</span>` : ''}</div></div>${withActions === true ? editBtns('off', t.id, t.type + ' ' + fdr(t.s, t.e)) : ''}</div>`;
}

// ===================================================================
// People
// ===================================================================
VIEWS.people = {
  title: 'People',
  sub() { const X = ix(); const fte = X.people.reduce((s, p) => s + p.fte / 100, 0); return `${plural(X.people.length, 'person', 'people')} · ${fmtFte(fte)} · ${plural(X.teams.length, 'team')}`; },
  shell() {
    const f = app.f.people;
    return `<div class="filters" role="group" aria-label="Filter people">
      <label class="field grow"><span>Search</span><span class="search">${icon('search')}<input type="search" id="pQ" data-bind="people.q" value="${esc(f.q)}" placeholder="Name, role, team or location" autocomplete="off"></span></label>
      <label class="field"><span>Capability Home</span><select id="pHome" data-bind="people.home" data-opts="homes"></select></label>
      <label class="field"><span>Team</span><select id="pTeam" data-bind="people.team" data-opts="teams"></select></label>
      <label class="field"><span>Skill</span><select id="pSkill" data-bind="people.skill" data-opts="skills"></select></label>
      <label class="field"><span>Level</span><select id="pMin" data-bind="people.min" data-opts="levels"></select></label>
      <label class="field"><span>Type</span><select id="pType" data-bind="people.type" data-opts="ptypes"></select></label>
      <label class="field"><span>Sort by</span><select id="pSort" data-bind="people.sort" data-opts="psort"></select></label>
      ${canEdit() ? `<div class="filters-end"><button type="button" class="btn primary" data-act="add-person">${icon('userplus')}Add person</button></div>` : ''}
    </div><div id="vb"></div>`;
  },
  body(vb) {
    const X = ix();
    if (!X.people.length) { vb.innerHTML = emptyState('people'); return; }
    const f = app.f.people;
    const q = f.q.trim().toLowerCase();
    const W4 = weeksFrom(X.W0, 4);
    let rows = X.people
      .filter(p => (!f.home || p.home === f.home) && (!f.team || p.team === f.team) && (!f.type || p.type === f.type) && (!f.skill || (p.skills[f.skill] || 0) >= f.min)
        && (!q || [p.name, p.role, p.team, homeName(p.home), p.location, p.email].join(' ').toLowerCase().includes(q)))
      .map(p => ({ p, now: week(p, X.W0), s4: summarize([p], W4) }));
    if (f.sort === 'free') rows.sort((a, b) => b.s4.free - a.s4.free);
    else if (f.sort === 'util') rows.sort((a, b) => (b.now.util ?? -1) - (a.now.util ?? -1));
    else if (f.sort === 'team') rows.sort((a, b) => (a.p.team || '~').localeCompare(b.p.team || '~') || a.p.name.localeCompare(b.p.name));
    const fte = rows.reduce((s, r) => s + r.p.fte / 100, 0);
    vb.innerHTML = `<div class="list-meta"><span>${plural(rows.length, 'person', 'people')} · ${fmtFte(fte)}</span><span class="faint">This week is ${wkCode(X.W0)}, ${fdr(X.W0, X.W0 + 4 * DAY)}</span></div>
      ${rows.length ? `<div class="plist">${rows.map(personRow).join('')}</div>` : `<div class="state"><h2>No one matches</h2><p>Try a different search, Capability Home, team, skill or level.</p></div>`}`;
  },
};
function personRow({ p, now, s4 }) {
  const X = ix();
  const projs = [...new Map((X.countByPerson.get(p.id) || []).filter(a => a.live && a.e >= X.T && a.s <= X.T + 28 * DAY).map(a => [a.projectId, a.project.name])).values()];
  const nowTxt = now.work === 0 ? 'Not employed' : now.avail === 0 ? 'Off' : fmtPct(now.util);
  return `<button type="button" class="prow" data-act="open-person" data-id="${esc(p.id)}">
    <span class="who">${avatar(p)}<span><strong>${esc(p.name)}</strong><small>${esc(p.role || '—')}</small></span></span>
    <span class="c-team"><span>${esc(p.team || 'No team')}</span><small>${esc([homeName(p.home), p.fte !== 100 ? p.fte + '% FTE' : '', p.type === 'Contractor' ? 'Contractor' : ''].filter(Boolean).join(' · ') || '—')}</small></span>
    <span class="utilmini"><span class="row"><small>This week</small><span>${nowTxt}</span></span>${now.util != null ? meterHtml(now.util) : '<span class="meter" aria-hidden="true"></span>'}</span>
    <span class="c-free"><small>Free, next 4 wks</small><strong class="num">${pctFte(s4.free)}</strong></span>
    <span class="c-proj"><small>Activities now</small><span class="projnames">${projs.length ? esc(projs.slice(0, 2).join(', ')) + (projs.length > 2 ? ` +${projs.length - 2}` : '') : '<span class="faint">None</span>'}</span></span>
    <span class="c-skills chips">${skillChips(p, 3, app.f.people.skill)}</span>
  </button>`;
}

// ===================================================================
// Activities: Capability Home work, Outcome Teams, Franchise Networks
// ===================================================================
VIEWS.activities = {
  title: 'Activities',
  sub() {
    const X = ix();
    const n = k => X.projects.filter(p => p.kind === k && COUNTS.has(p.status)).length;
    const open = X.openRoles.filter(a => a.e >= X.T).length;
    return `${plural(n('outcome'), 'Outcome Team')} · ${plural(n('network'), 'Franchise Network')} · ${plural(n('home'), 'Capability Home activity', 'Capability Home activities')} · ${plural(open, 'open role')}`;
  },
  shell() {
    const f = app.f.activities;
    const kinds = [['', 'All'], ...KINDS.map(k => [k.id, k.plural])];
    const segs = [['open', 'Active & planned'], ['Active', 'Active'], ['Planned', 'Planned'], ['On hold', 'On hold'], ['Completed', 'Completed'], ['all', 'All']];
    return `<div class="filters" role="group" aria-label="Filter activities">
      <div class="field"><span id="lblAk">Type</span><div class="seg" role="group" aria-labelledby="lblAk">${kinds.map(([v, l]) => `<button type="button" data-act="act-kind" data-v="${esc(v)}" aria-pressed="${f.kind === v}">${v ? `<i class="kd k-${v}" aria-hidden="true"></i>` : ''}${l}</button>`).join('')}</div></div>
      <div class="field"><span id="lblPs">Status</span><div class="seg" role="group" aria-labelledby="lblPs">${segs.map(([v, l]) => `<button type="button" data-act="act-status" data-v="${esc(v)}" aria-pressed="${f.status === v}">${l}</button>`).join('')}</div></div>
      <label class="field"><span>Focus area</span><select id="aArea" data-bind="activities.area" data-opts="areas"></select></label>
      <label class="field grow"><span>Search</span><span class="search">${icon('search')}<input type="search" id="prQ" data-bind="activities.q" value="${esc(f.q)}" placeholder="Name, code, sponsor or purpose" autocomplete="off"></span></label>
      <div class="filters-end"><button type="button" class="btn" data-act="guide">${icon('book')}Focus guide</button>${canEdit() ? `<button type="button" class="btn primary" data-act="add-project">${icon('plus')}Add activity</button>` : ''}</div>
    </div><div id="vb"></div>`;
  },
  body(vb) {
    const X = ix();
    if (!X.projects.length) { vb.innerHTML = emptyState('activities'); return; }
    const f = app.f.activities;
    const q = f.q.trim().toLowerCase();
    const list = X.projects.filter(p => (f.status === 'all' || (f.status === 'open' ? COUNTS.has(p.status) : p.status === f.status))
      && (!f.kind || p.kind === f.kind)
      && (!f.area || (f.area === '-' ? !p.focus || (X.byProject.get(p.id) || []).some(a => !a.focus) : (SUB.has(p.focus) && SUB.get(p.focus).area.id === f.area) || (X.byProject.get(p.id) || []).some(a => SUB.has(a.focus) && SUB.get(a.focus).area.id === f.area)))
      && (!q || [p.name, p.code, p.sponsor, p.description, p.purpose].join(' ').toLowerCase().includes(q)));
    const openN = list.reduce((s, p) => s + (COUNTS.has(p.status) ? staffing(p).open.length : 0), 0);
    const dated = list.filter(p => p.kind === 'outcome' || p.end != null);
    const groups = f.kind ? [[f.kind, list]] : groupBy(list, p => p.kind);
    vb.innerHTML = list.length ? `${dated.length ? `<section class="panel">
        <div class="panel-head"><div><h2>Timeline</h2><p>Outcome Teams and other activities with an end date. Time on paused or completed activities counts only up to today.</p></div></div>
        ${timeline(dated)}
      </section>` : ''}
      <div class="list-meta"><span>${plural(list.length, 'activity', 'activities')} · ${plural(openN, 'open role')}</span></div>
      <div class="ptable"><div class="pjhead" aria-hidden="true"><span>Activity and focus</span><span>Type and status</span><span>Lead</span><span>Dates</span><span>Staffing, current and upcoming</span></div>${groups.map(([k, l]) => `${f.kind ? '' : `<div class="pjgroup"><i class="kd k-${k}" aria-hidden="true"></i><strong>${esc(KIND[k].plural)}</strong><span class="faint">${esc(KIND[k].desc)}</span></div>`}${l.map(projectRow).join('')}`).join('')}</div>`
      : `<div class="state"><h2>No activities match</h2><p>Try another type, status, focus area or search term.</p></div>`;
  },
};
function projectRow(pr) {
  const X = ix();
  const st = staffing(pr);
  const lead = X.P.get(pr.leadId);
  const prog = pr.start != null && pr.end != null && pr.end > pr.start ? clamp((X.T - pr.start) / (pr.end - pr.start), 0, 1) : null;
  const openFte = st.total - st.filled;
  return `<button type="button" class="pjrow" data-act="open-project" data-id="${esc(pr.id)}">
    <span class="pj-name"><strong>${esc(pr.name)}</strong>${[pr.code, pr.sponsor].some(Boolean) ? `<small>${esc([pr.code, pr.sponsor].filter(Boolean).join(' · '))}</small>` : pr.purpose ? `<small class="clamp1">${esc(pr.purpose)}</small>` : ''}${focusHtml(pr.focus)}</span>
    <span class="pj-status">${kindTag(pr.kind)}${statusPill(pr.status)}</span>
    <span class="pj-lead"><small>${leadLabel(pr.kind)}</small>${lead ? esc(lead.name) : '<span class="faint">Not named</span>'}</span>
    <span class="pj-dates"><span class="num">${esc(actDates(pr))}</span>${prog != null ? `<span class="prog" aria-hidden="true"><i style="width:${(prog * 100).toFixed(1)}%"></i></span>` : ''}</span>
    <span class="pj-staff"><span class="staffbar" aria-hidden="true">${st.set.length ? `${st.filled > 0 ? `<i style="flex:${st.filled.toFixed(2)}"></i>` : ''}${openFte > 0.001 ? `<i class="open" style="flex:${openFte.toFixed(2)}"></i>` : ''}` : '<i class="none"></i>'}</span>
      <span class="staffline">${pr.kind === 'outcome' || st.open.length ? `<span>${fmt1(st.filled)} of ${fmtFte(st.total)} filled</span>${staffPill(st)}` : `<span>${fmtFte(st.filled)} booked · ${plural(new Set(st.set.filter(a => a.personId).map(a => a.personId)).size, 'person', 'people')}</span>`}</span></span>
  </button>`;
}

// ===================================================================
// Skills
// ===================================================================
VIEWS.skills = {
  title: 'Skills',
  sub() {
    const X = ix();
    const thin = X.skills.filter(s => s.critical && coverage(s.id).adv < 2).length;
    return `${plural(X.skills.length, 'skill')} in ${plural(X.cats.length, 'category', 'categories')}${thin ? ` · ${plural(thin, 'critical skill')} with thin coverage` : ''}`;
  },
  shell() {
    const f = app.f.skills;
    return `<div class="filters" role="group" aria-label="Filter skills">
      <div class="field"><span id="lblSt">View</span><div class="seg" role="group" aria-labelledby="lblSt"><button type="button" data-act="skills-tab" data-v="matrix" aria-pressed="${f.tab === 'matrix'}">Matrix</button><button type="button" data-act="skills-tab" data-v="catalogue" aria-pressed="${f.tab === 'catalogue'}">Catalogue</button></div></div>
      <label class="field"><span>Team</span><select id="sTeam" data-bind="skills.team" data-opts="teams"></select></label>
      <label class="field"><span>Category</span><select id="sCat" data-bind="skills.cat" data-opts="cats"></select></label>
      <label class="field grow"><span>Search</span><span class="search">${icon('search')}<input type="search" id="sQ" data-bind="skills.q" value="${esc(f.q)}" placeholder="Person or skill" autocomplete="off"></span></label>
      ${canEdit() ? `<div class="filters-end"><button type="button" class="btn primary" data-act="add-skill">${icon('plus')}Add skill</button></div>` : ''}
    </div><div id="vb"></div>`;
  },
  body(vb) {
    if (!ix().skills.length) { vb.innerHTML = emptyState('skills'); return; }
    if (app.f.skills.tab === 'catalogue') catalogueBody(vb); else matrixBody(vb);
  },
};
const levelLegend = () => `<div class="lvl-legend">${[1, 2, 3, 4].map(i => `<span><i class="lvl l${i}" aria-hidden="true">${i}</i>${LEVELS[i]}</span>`).join('')}<span>${icon('diamond')}Business-critical skill</span>${canEdit() ? '<span class="faint">Select a cell to change a level.</span>' : ''}</div>`;
function matrixBody(vb) {
  const X = ix();
  const f = app.f.skills;
  const q = f.q.trim().toLowerCase();
  let skills = X.skills.filter(s => !f.cat || s.cat === f.cat);
  let people = X.people.filter(p => !f.team || p.team === f.team);
  if (q) {
    const sk = skills.filter(s => s.name.toLowerCase().includes(q));
    const pp = people.filter(p => (p.name + ' ' + p.role).toLowerCase().includes(q));
    if (pp.length) people = pp;
    if (sk.length) skills = sk;
    if (!pp.length && !sk.length) { people = []; }
  }
  if (!people.length || !skills.length) { vb.innerHTML = `${levelLegend()}<div class="state"><h2>Nothing matches</h2><p>Try another team, category or search term.</p></div>`; return; }
  const groups = groupBy(skills, s => s.cat);
  const firsts = new Set(groups.map(g => g[1][0].id));
  const edit = canEdit();
  const head = `<thead><tr class="cat"><th class="rowh" rowspan="2" scope="col">${plural(people.length, 'person', 'people')}</th>${groups.map(([cat, l]) => `<th colspan="${l.length}" scope="colgroup">${esc(cat)}</th>`).join('')}</tr>
    <tr class="sk">${skills.map(s => `<th scope="col" class="${firsts.has(s.id) ? 'first' : ''}" data-tip="sk:${esc(s.id)}"><span class="rot">${esc(s.name)}${s.critical ? icon('diamond') : ''}</span></th>`).join('')}</tr></thead>`;
  const tg = f.team ? [[f.team, people]] : teamGroups(people);
  const body = tg.map(([team, list]) => `<tr class="team"><th colspan="${skills.length + 1}" scope="rowgroup">${esc(team || 'No team')}</th></tr>` + list.map(p => `<tr><th class="rowh" scope="row"><strong>${esc(p.name)}</strong><small>${esc(p.role)}</small></th>${skills.map(s => {
    const l = p.skills[s.id] || 0;
    const label = `${p.name}, ${s.name}: ${LEVELS[l]}`;
    const inner = edit
      ? `<button type="button" class="lvl l${l}" data-act="lvl" data-pid="${esc(p.id)}" data-sid="${esc(s.id)}" data-tip="lvl:${esc(p.id)}:${esc(s.id)}" aria-label="${esc(label)}" aria-haspopup="menu">${l || ''}</button>`
      : `<span class="lvl l${l}" data-tip="lvl:${esc(p.id)}:${esc(s.id)}" role="img" aria-label="${esc(label)}">${l || ''}</span>`;
    return `<td class="${firsts.has(s.id) ? 'gstart' : ''}">${inner}</td>`;
  }).join('')}</tr>`).join('')).join('');
  const foot = `<tfoot><tr><th class="rowh" scope="row">Advanced or expert</th>${skills.map(s => {
    const n = people.filter(p => (p.skills[s.id] || 0) >= 3).length;
    const thin = s.critical && n < 2;
    return `<td class="${thin ? 'thin' : ''}${firsts.has(s.id) ? ' gstart' : ''}" data-tip="cov:${esc(s.id)}">${n}</td>`;
  }).join('')}</tr></tfoot>`;
  vb.innerHTML = `${levelLegend()}<div class="mx-wrap"><table class="mx">${head}<tbody>${body}</tbody>${foot}</table></div>`;
}
function catalogueBody(vb) {
  const X = ix();
  const f = app.f.skills;
  const q = f.q.trim().toLowerCase();
  const skills = X.skills.filter(s => (!f.cat || s.cat === f.cat) && (!q || s.name.toLowerCase().includes(q)));
  if (!skills.length) { vb.innerHTML = `<div class="state"><h2>No skills match</h2><p>Try another category or search term.</p></div>`; return; }
  vb.innerHTML = groupBy(skills, s => s.cat).map(([cat, list]) => `<section class="panel">
    <div class="panel-head"><h2>${esc(cat)}</h2><span class="count">${list.length}</span></div>
    <ul class="sklist">${list.map(s => {
      const c = coverage(s.id);
      const thin = s.critical && c.adv < 2;
      const dist = [1, 2, 3, 4].map(l => (c.by[l] ? `<i class="l${l}" style="flex:${c.by[l]}"></i>` : '')).join('') || '<i class="none"></i>';
      return `<li class="skrow">
        <div><strong>${esc(s.name)}</strong> ${s.critical ? pill(thin ? 'crit' : 'neutral', thin ? 'Critical, thin' : 'Critical', 'diamond') : ''}</div>
        <div class="c-dist"><div class="dist" aria-hidden="true">${dist}</div><div class="dist-n">${[1, 2, 3, 4].map(l => `${LEVELS[l]} ${c.by[l]}`).join(' · ')}</div></div>
        <div class="c-adv"><strong class="num">${c.adv}</strong> <span class="muted">advanced or expert</span></div>
        ${editBtns('skill', s.id, s.name) || '<span></span>'}
      </li>`;
    }).join('')}</ul></section>`).join('');
}

// ===================================================================
// Availability
// ===================================================================
let HM_TEAMS = [];
VIEWS.availability = {
  title: 'Availability',
  sub() { const X = ix(); const f = app.f.avail; const s = X.W0 + f.offset * 7 * DAY; return `${wkCode(s)}–${wkCode(s + (f.weeks - 1) * 7 * DAY)} · ${fdr(s, s + (f.weeks - 1) * 7 * DAY + 4 * DAY)}`; },
  shell() {
    const f = app.f.avail;
    return `<div class="filters" role="group" aria-label="Filter availability">
      <div class="field"><span id="lblWk">Weeks</span><div class="seg nowrap" role="group" aria-labelledby="lblWk"><button type="button" data-act="avail-shift" data-v="-1" aria-label="Show earlier weeks">${icon('left')}</button><button type="button" data-act="avail-shift" data-v="0">This week</button><button type="button" data-act="avail-shift" data-v="1" aria-label="Show later weeks">${icon('right')}</button></div></div>
      <label class="field"><span>Show</span><select id="aWeeks" data-bind="avail.weeks" data-opts="weekcounts"></select></label>
      <label class="field"><span>Capability Home</span><select id="aHome" data-bind="avail.home" data-opts="homes"></select></label>
      <label class="field"><span>Team</span><select id="aTeam" data-bind="avail.team" data-opts="teams"></select></label>
      <label class="field"><span>Skill</span><select id="aSkill" data-bind="avail.skill" data-opts="skills"></select></label>
      <label class="field"><span>Level</span><select id="aMin" data-bind="avail.min" data-opts="levels"></select></label>
      <label class="field grow"><span>Search</span><span class="search">${icon('search')}<input type="search" id="aQ" data-bind="avail.q" value="${esc(f.q)}" placeholder="Name or role" autocomplete="off"></span></label>
      <div class="field"><span id="lblMetric">Cells show</span><div class="seg" role="group" aria-labelledby="lblMetric"><button type="button" data-act="avail-metric" data-v="util" aria-pressed="${f.metric === 'util'}">% booked</button><button type="button" data-act="avail-metric" data-v="free" aria-pressed="${f.metric === 'free'}">% FTE free</button></div></div>
      <div class="filters-end"><button type="button" class="btn" data-act="finder">${icon('search')}Find available people</button>${canEdit() ? `<button type="button" class="btn primary" data-act="add-off">${icon('plus')}Add time off</button>` : ''}</div>
    </div><div id="vb"></div>`;
  },
  body(vb) {
    const X = ix();
    if (!X.people.length) { vb.innerHTML = emptyState('people'); return; }
    const f = app.f.avail;
    const start = X.W0 + f.offset * 7 * DAY;
    const weeks = weeksFrom(start, f.weeks);
    const q = f.q.trim().toLowerCase();
    const people = X.people.filter(p => (!f.home || p.home === f.home) && (!f.team || p.team === f.team) && (!f.skill || (p.skills[f.skill] || 0) >= f.min) && (!q || (p.name + ' ' + p.role).toLowerCase().includes(q)));
    const groups = f.team ? [[f.team, people]] : teamGroups(people);
    HM_TEAMS = groups.map(g => g[1].map(p => p.id));
    const head = `<thead><tr><th class="rowh" scope="col">${plural(people.length, 'person', 'people')}</th>${weeks.map(wk => `<th scope="col" class="${wk === X.W0 ? 'cur' : ''}"><span class="wk">${wkCode(wk)}</span><span class="wd">${fd(wk, false)}</span></th>`).join('')}</tr></thead>`;
    const rows = groups.map(([team, list], gi) => {
      const teamCells = weeks.map(wk => {
        let cap = 0, alloc = 0, work = 0;
        for (const p of list) { const r = week(p, wk); cap += r.cap; alloc += r.alloc; work += r.work; }
        const util = cap > 0 ? alloc / cap : null;
        const cls = work === 0 ? 'na' : cap === 0 ? 'off' : util > 1.005 ? 'over' : 'b' + bin(util);
        return `<td><span class="cell sm ${cls}" data-tip="tw:${gi}:${wk}">${work === 0 ? '' : cap === 0 ? 'Off' : f.metric === 'free' ? pctNum((cap - alloc) / cap) : Math.round(util * 100)}</span></td>`;
      }).join('');
      const personRows = list.map(p => `<tr><th class="rowh" scope="row"><button type="button" data-act="open-person" data-id="${esc(p.id)}"><strong>${esc(p.name)}</strong><small>${esc(p.role || p.type)}${p.fte !== 100 ? ` · ${p.fte}% FTE` : ''}</small></button></th>${weeks.map(wk => {
        const r = week(p, wk);
        const part = r.off > 0 && r.avail > 0;
        return `<td><button type="button" class="cell ${cellClass(r)}" data-act="open-person" data-id="${esc(p.id)}" data-tip="hm:${esc(p.id)}:${wk}" aria-label="${esc(cellAria(p, r, wk))}">${cellText(r, f.metric)}${part ? '<i class="pl"></i>' : ''}</button></td>`;
      }).join('')}</tr>`).join('');
      return `<tr class="team"><th class="rowh" scope="rowgroup">${esc(team || 'No team')} <small>· ${plural(list.length, 'person', 'people')}</small></th>${teamCells}</tr>${personRows}`;
    }).join('');
    const ids = new Set(people.map(p => p.id));
    const upcoming = X.offs.filter(t => t.e >= X.T && (t.personId === ALL || ids.has(t.personId)));
    vb.innerHTML = `<div class="heat-legend" aria-label="Legend">
        <span class="ends">0%<span class="scale">${[0, 1, 2, 3, 4].map(i => `<i style="background:var(--heat-${i});box-shadow:inset 0 0 0 1px var(--grid)"></i>`).join('')}</span>100% booked</span>
        <span class="key"><i style="background:var(--heat-over)"></i>Over 100%</span>
        <span class="key"><i style="background:var(--heat-off)"></i>Off all week</span>
        <span class="key"><i style="background:var(--heat-1)"><b class="pldemo"></b></i>Dot: some days off</span>
        <span class="key"><i style="box-shadow:inset 0 0 0 1px var(--line-strong)"></i>Not employed</span>
        <span class="faint">${f.metric === 'free' ? 'Numbers: % of one FTE still free (team rows: % of the team’s capacity).' : 'Numbers: % of available FTE booked.'}</span>
      </div>
      ${people.length ? `<div class="hm-wrap"><table class="hm">${head}<tbody>${rows}</tbody></table></div>` : `<div class="state"><h2>No one matches</h2><p>Try another Capability Home, team, skill level or search term.</p></div>`}
      <section class="panel">
        <div class="panel-head"><div><h2>Time off</h2><p>Upcoming leave, training and public holidays. Each entry lowers capacity in the grid above.</p></div>${canEdit() ? `<button type="button" class="btn small" data-act="add-off">${icon('plus')}Add time off</button>` : ''}</div>
        ${upcoming.length ? `<div class="rows">${upcoming.map(t => offRow(t, true)).join('')}</div>` : `<p class="empty-note">No upcoming time off recorded.</p>`}
      </section>`;
  },
};

// ===================================================================
// Drawers: person and activity detail
// ===================================================================
function openDrawer(type, id) {
  app.drawer = { type, id };
  const d = $('#drawer');
  renderDrawer();
  if (!d.open) d.showModal();
  const b = d.querySelector('.dr-body'); if (b) b.scrollTop = 0;
}
function renderDrawer() {
  const d = $('#drawer');
  if (!app.drawer) return;
  const X = ix();
  const fa = document.activeElement;
  const focusKey = fa && d.contains(fa) && fa.dataset && fa.dataset.act ? `[data-act="${fa.dataset.act}"]${fa.dataset.id ? `[data-id="${CSS.escape(fa.dataset.id)}"]` : ''}` : null;
  const body = d.querySelector('.dr-body');
  const scroll = body ? body.scrollTop : 0;
  let html = '';
  if (app.drawer.type === 'person') { const p = X.P.get(app.drawer.id); if (!p) { if (d.open) d.close(); return; } html = personDrawer(p); }
  else { const pr = X.J.get(app.drawer.id); if (!pr) { if (d.open) d.close(); return; } html = projectDrawer(pr); }
  floatersOut(d);
  hideTip();
  d.innerHTML = html;
  placeToast();
  const nb = d.querySelector('.dr-body');
  if (nb) nb.scrollTop = scroll;
  drawCharts(d);
  if (focusKey) { const el = d.querySelector(focusKey); if (el) el.focus(); }
}
function drawerHead(titleHtml, sub, actions, lead) {
  return `<div class="dr-head"><div class="dr-title">${lead || ''}<div><h2 id="drawerTitle">${titleHtml}</h2><p>${sub}</p></div></div><div class="dr-actions">${actions}<button type="button" class="btn small icon-btn ghost" data-act="close-drawer" aria-label="Close">${icon('x')}</button></div></div>`;
}
function personSplit(p) {
  const P = periodById(app.f.dash.period);
  const A = allocCalc(P.from, P.to, [p], 'p:' + p.id);
  const r = A.per.get(p.id);
  if (!r || r.cap <= 0.001) return `<p class="empty-note">Not available in ${esc(P.short)}.</p>`;
  const subs = [...r.subs].map(([sid, sv]) => ({ sid, v: sv.home + sv.outcome + sv.network, sv })).filter(x => x.v > 0.004).sort((a, b) => b.v - a.v);
  const scale = Math.max(1, r.cap, r.booked);
  const segs = [...KINDS.map(k => ({ k: k.id, v: r[k.id] })), { k: 'free', v: r.free }];
  return `<div class="psplit">${hstack(segs, scale, { cls: 'lg' + (r.over > 0.005 ? ' over' : ''), ref: r.over > 0.005 ? r.cap : null, aria: KINDS.map(k => `${k.plural} ${pctFte(r[k.id])}`).join(', ') + `, unallocated ${pctFte(r.free)}` })}
    <div class="legend vals">${KINDS.map(k => `<span><i class="sw k-${k.id}"></i>${esc(k.plural)} <strong>${pctNum(r[k.id])}%</strong></span>`).join('')}<span><i class="sw k-free"></i>Unallocated <strong>${r.over > 0.005 ? '−' + pctNum(r.over) : pctNum(r.free)}%</strong></span></div>
    <p class="faint small">Available ${pctFte(r.cap)} on average in ${esc(P.short)}${p.fte < 100 ? ` (contract ${p.fte}% FTE)` : ''}.</p>
    ${subs.length ? `<ul class="flist">${subs.map(x => `<li><span>${esc(focusText(x.sid))}</span><span class="kmini">${KINDS.filter(k => x.sv[k.id] > 0.004).map(k => `<i class="kd k-${k.id}" title="${esc(k.plural)}"></i>`).join('')}</span><strong class="num">${pctNum(x.v)}%</strong></li>`).join('')}</ul>` : ''}
  </div>`;
}
function personDrawer(p) {
  const X = ix();
  const edit = canEdit();
  const weeks = weeksFrom(X.W0, 12);
  const s4 = summarize([p], weeksFrom(X.W0, 4));
  const strip = weeks.map(wk => { const r = week(p, wk); return `<span class="cell ${cellClass(r)}" data-tip="hm:${esc(p.id)}:${wk}" role="img" aria-label="${esc(cellAria(p, r, wk))}">${cellText(r, 'util')}${r.off > 0 && r.avail > 0 ? '<i class="pl"></i>' : ''}</span>`; }).join('');
  const roles = (X.byPerson.get(p.id) || []).slice();
  const cur = roles.filter(a => a.e == null || a.e >= X.T);
  const past = roles.filter(a => a.e != null && a.e < X.T).sort((a, b) => b.e - a.e).slice(0, 4);
  const roleRow = a => {
    const below = a.skillId && a.minLevel && (p.skills[a.skillId] || 0) < a.minLevel;
    return `<div class="rowi${a.e != null && a.e < X.T ? ' past' : ''}"><div><button type="button" class="linkish" data-act="open-project" data-id="${esc(a.projectId)}">${esc(a.project.name)}</button>
      <div class="d">${kindTag(a.project.kind)}<span>${esc(a.role)}</span><span class="num">${a.alloc}% FTE</span><span class="num">${esc(whenTxt(a))}</span>${a.booking === 'Tentative' ? pill('neutral', 'Tentative') : ''}${!COUNTS.has(a.project.status) ? pill('muted', a.project.status) : ''}${below ? pill('warn', 'Below required level', 'alert') : ''}${p.end != null && a.e > p.end && a.live && !a.noEnd ? pill('crit', 'After contract end', 'alert') : ''}</div>
      <div class="d">${focusHtml(a.focus)}</div></div>
      ${editBtns('asg', a.id, a.role + ' on ' + a.project.name)}</div>`;
  };
  const offs = (X.offBy.get(p.id) || []).filter(t => t.e >= X.T - 28 * DAY);
  const skillGroups = groupBy(topSkills(p, 99).map(([sid, l]) => ({ s: X.K.get(sid), l })), x => x.s.cat);
  const facts = [
    ['Capability Home', homeName(p.home) || '—'], ['Team', p.team || '—'], ['FTE', `${p.fte}%`], ['Type', p.type],
    ['Location', p.location || '—'], ['Email', p.email || '—'],
    ['Started', fd(p.start)], [p.type === 'Contractor' ? 'Contract ends' : 'End date', p.end != null ? fd(p.end) : 'Open-ended'],
  ];
  const P = periodById(app.f.dash.period);
  return drawerHead(esc(p.name), esc(p.role || '—'),
    edit ? `<button type="button" class="btn small" data-act="edit-person" data-id="${esc(p.id)}">${icon('edit')}Edit</button><button type="button" class="btn small icon-btn danger" data-act="del-person" data-id="${esc(p.id)}" aria-label="Delete ${esc(p.name)}">${icon('trash')}</button>` : '',
    avatar(p, true))
    + `<div class="dr-body">
      <dl class="facts">${facts.map(([k, v]) => `<div><dt>${k}</dt><dd>${esc(v)}</dd></div>`).join('')}</dl>
      <section class="dr-sec"><div class="dr-sec-h"><h3>Where their time goes · ${esc(P.short)}</h3></div>${personSplit(p)}</section>
      <section class="dr-sec"><div class="dr-sec-h"><h3>Next 12 weeks</h3><span class="muted num">${fmtPct(s4.util)} booked over 4 weeks · ${pctFte(s4.free)} free</span></div>
        <div class="strip">${strip}</div><div class="strip-labels" aria-hidden="true">${weeks.map(wk => `<span>${wkCode(wk)}</span>`).join('')}</div></section>
      <section class="dr-sec"><div class="dr-sec-h"><h3>Bookings</h3>${edit ? `<button type="button" class="btn small" data-act="book-person" data-id="${esc(p.id)}">${icon('plus')}Book on an activity</button>` : ''}</div>
        ${cur.length || past.length ? `<div class="rows">${cur.map(roleRow).join('')}${past.map(roleRow).join('')}</div>` : '<p class="empty-note">No bookings yet.</p>'}</section>
      <section class="dr-sec"><div class="dr-sec-h"><h3>Time off</h3>${edit ? `<button type="button" class="btn small" data-act="add-off" data-person="${esc(p.id)}">${icon('plus')}Add time off</button>` : ''}</div>
        ${offs.length ? `<div class="rows">${offs.map(t => offRow(t, true)).join('')}</div>` : '<p class="empty-note">No time off recorded.</p>'}</section>
      <section class="dr-sec"><div class="dr-sec-h"><h3>Skills</h3>${edit ? `<button type="button" class="btn small" data-act="edit-person" data-id="${esc(p.id)}">${icon('edit')}Edit skills</button>` : ''}</div>
        ${skillGroups.length ? `<div class="skillgroups">${skillGroups.map(([cat, l]) => `<div><h4>${esc(cat)}</h4><div class="chips">${l.map(x => `<span class="chip">${esc(x.s.name)} ${pips(x.l)} <span class="faint">${LEVELS[x.l]}</span></span>`).join('')}</div></div>`).join('')}</div>` : '<p class="empty-note">No skills recorded.</p>'}</section>
      ${p.notes ? `<section class="dr-sec"><h3>Notes</h3><p class="desc">${esc(p.notes)}</p></section>` : ''}
    </div>`;
}
function projectSeries(pr) {
  const X = ix();
  const roles = X.byProject.get(pr.id) || [];
  if (pr.start == null) return [];
  const first = Math.max(monday(pr.start), X.W0 - 4 * 7 * DAY);
  const last = pr.end != null ? pr.end : X.W0 + 25 * 7 * DAY;
  const series = [];
  for (let wk = first; wk <= last && series.length < 26; wk += 7 * DAY) {
    let conf = 0, tent = 0, open = 0;
    for (const a of roles) {
      if (!a.counts) continue;
      if (a.personId) {
        const r = week(X.P.get(a.personId), wk);
        const e = r.proj.find(x => x.a.id === a.id);
        if (e) { if (a.booking === 'Tentative') tent += e.v; else conf += e.v; }
      } else open += roleFte(a, wk);
    }
    series.push({ wk, conf, tent, open, cap: 0 });
  }
  return series;
}
function projectDrawer(pr) {
  const X = ix();
  const edit = canEdit();
  const st = staffing(pr);
  const lead = X.P.get(pr.leadId);
  const series = projectSeries(pr);
  const cfg = weekCfg('proj', series, { keys: KEY_BOOK.concat(KEY_OPEN), noCap: true, height: 200, floor: 0.2, title: `FTE per week on ${pr.name}` });
  CHARTS.set('proj', cfg);
  const roles = (X.byProject.get(pr.id) || []);
  const roleRow = a => {
    const p = a.personId ? X.P.get(a.personId) : null;
    const sk = a.skillId ? X.K.get(a.skillId) : null;
    const below = p && sk && a.minLevel && (p.skills[sk.id] || 0) < a.minLevel;
    const who = p ? `<button type="button" class="linkish" data-act="open-person" data-id="${esc(p.id)}">${esc(p.name)}</button>` : `${pill('warn', 'Open role', 'userplus')}`;
    return `<div class="rowi${a.e != null && a.e < X.T ? ' past' : ''}"><div><span class="t">${esc(a.role)}</span> <span style="margin-left:6px">${who}</span>
      <div class="d"><span class="num">${a.alloc}% FTE</span><span class="num">${esc(whenTxt(a))}</span>${sk ? `<span>${esc(sk.name)}${a.minLevel ? `, ${LEVELS[a.minLevel]}+` : ''}</span>` : ''}${a.booking === 'Tentative' ? pill('neutral', 'Tentative') : ''}${below ? pill('warn', 'Below required level', 'alert') : ''}</div>
      ${a.ownFocus && a.ownFocus !== pr.focus ? `<div class="d">${focusHtml(a.ownFocus)}</div>` : ''}</div>
      <span class="row-actions">${!p && edit && a.e >= X.T ? `<button type="button" class="btn small primary" data-act="find-for" data-id="${esc(a.id)}">Find people</button>` : ''}${editBtnsInner('asg', a.id, a.role)}</span></div>`;
  };
  const facts = [['Type', KIND[pr.kind].label], [leadLabel(pr.kind), lead ? lead.name : '—'], ['Sponsor', pr.sponsor || '—'], [pr.kind === 'outcome' ? 'Dates (target end)' : 'Dates', actDates(pr)], ['Priority', pr.priority], ['Staffing', `${fmt1(st.filled)} of ${fmtFte(st.total)} filled`], ['Open roles', String(st.open.length)]];
  if (pr.kind === 'network') facts.push(['Review date', pr.review != null ? fd(pr.review) : '—'], ['Forum decision', pr.decision || '—']);
  const reg = [];
  if (pr.purpose) reg.push([pr.kind === 'outcome' ? 'Intended result' : 'Purpose', pr.purpose]);
  if (pr.kind === 'outcome' && pr.why) reg.push(['Why an Outcome rather than BAU', pr.why]);
  if (pr.kind === 'outcome' && pr.deprio) reg.push(['Capacity released: paused, delegated or deprioritized', pr.deprio]);
  return drawerHead(esc(pr.name), `${pr.code ? `<span class="mono">${esc(pr.code)}</span> · ` : ''}${kindTag(pr.kind)} ${statusPill(pr.status)} ${COUNTS.has(pr.status) && st.set.length ? staffPill(st) : ''}`,
    edit ? `<button type="button" class="btn small" data-act="edit-project" data-id="${esc(pr.id)}">${icon('edit')}Edit</button><button type="button" class="btn small icon-btn danger" data-act="del-project" data-id="${esc(pr.id)}" aria-label="Delete ${esc(pr.name)}">${icon('trash')}</button>` : '')
    + `<div class="dr-body">
      <div class="focus-box"><span class="faint">Focus</span>${SUB.has(pr.focus) ? `<strong>${esc(focusText(pr.focus))}</strong><span class="faint">${esc(SUB.get(pr.focus).area.name)}</span>` : `<strong>Not set</strong><span class="faint">Set a focus so this time appears in Capability Home focus.</span>`}</div>
      <dl class="facts">${facts.map(([k, v]) => `<div><dt>${k}</dt><dd>${esc(v)}</dd></div>`).join('')}</dl>
      ${reg.length ? `<dl class="register">${reg.map(([k, v]) => `<div><dt>${esc(k)}</dt><dd>${esc(v)}</dd></div>`).join('')}</dl>` : ''}
      ${pr.description ? `<p class="desc">${esc(pr.description)}</p>` : ''}
      ${!COUNTS.has(pr.status) ? `<div class="banner">${icon('info')}<p>This activity is ${pr.status.toLowerCase()}, so its bookings count only up to today.</p></div>` : ''}
      ${series.length && COUNTS.has(pr.status) ? `<section class="dr-sec"><div class="dr-sec-h"><h3>FTE per week</h3><button type="button" class="btn small ghost" data-act="toggle-table" data-target="projTable" aria-expanded="false" aria-controls="projTable">Show as table</button></div>${chartLegend(cfg)}<div class="chart" data-chart="proj" style="min-height:200px"></div><div class="table-wrap" id="projTable" hidden>${chartTable(cfg)}</div></section>` : ''}
      <section class="dr-sec"><div class="dr-sec-h"><h3>People and roles</h3>${edit ? `<button type="button" class="btn small" data-act="add-role" data-id="${esc(pr.id)}">${icon('plus')}Add role</button>` : ''}</div>
        ${roles.length ? `<div class="rows">${roles.map(roleRow).join('')}</div>` : '<p class="empty-note">No one booked yet. Add a role to staff this activity.</p>'}</section>
    </div>`;
}

// ===================================================================
// Modal dialog: forms, confirmations, finder, import, focus guide
// ===================================================================
let modalState = null;
function openModal(html, opts = {}) {
  const m = $('#modal');
  floatersOut(m);
  hideTip();
  m.className = 'modal' + (opts.wide ? ' wide' : '');
  m.innerHTML = html;
  modalState = { kind: opts.kind || 'form' };
  if (!m.open) m.showModal();
  placeToast();
  const first = m.querySelector('[autofocus]') || m.querySelector('.md-body input:not([type=hidden]), .md-body select, .md-body textarea') || m.querySelector('.md-foot .btn:last-child');
  if (first) first.focus();
}
function closeModal() { const m = $('#modal'); if (m.open) m.close(); }

function optionHtml(o, v) {
  if (o && o.group) return `<optgroup label="${esc(o.group)}">${o.options.map(x => optionHtml(x, v)).join('')}</optgroup>`;
  const [val, lab] = Array.isArray(o) ? o : [o, o];
  return `<option value="${esc(val)}"${String(val) === String(v ?? '') ? ' selected' : ''}>${esc(lab)}</option>`;
}
function fieldHtml(f, v) {
  const id = 'f_' + f.name;
  const req = f.required ? ' aria-required="true"' : '';
  const show = f.showIf ? ` data-show-field="${esc(f.showIf[0])}" data-show-values="${esc(f.showIf[1].join(' '))}"` : '';
  if (f.type === 'checkbox') {
    return `<label class="check${f.full ? ' full' : ''}"${show}><input type="checkbox" id="${id}" name="${f.name}"${v ? ' checked' : ''}><span>${esc(f.label)}${f.hint ? `<br><span class="faint">${esc(f.hint)}</span>` : ''}</span></label>`;
  }
  let input;
  if (f.type === 'select') {
    input = `<select id="${id}" name="${f.name}"${req}>${f.options.map(o => optionHtml(o, v)).join('')}</select>`;
  } else if (f.type === 'textarea') {
    input = `<textarea id="${id}" name="${f.name}" rows="${f.rows || 3}"${f.placeholder ? ` placeholder="${esc(f.placeholder)}"` : ''}>${esc(v ?? '')}</textarea>`;
  } else {
    input = `<input type="${f.type || 'text'}" id="${id}" name="${f.name}" value="${esc(v ?? '')}"${req}${f.min != null ? ` min="${f.min}"` : ''}${f.max != null ? ` max="${f.max}"` : ''}${f.step ? ` step="${f.step}"` : ''}${f.list ? ` list="${id}_list"` : ''}${f.placeholder ? ` placeholder="${esc(f.placeholder)}"` : ''} autocomplete="off">`
      + (f.list ? `<datalist id="${id}_list">${f.list.map(x => `<option value="${esc(x)}"></option>`).join('')}</datalist>` : '');
  }
  return `<div class="field${f.full ? ' full' : ''}"${show}><label class="field-label" for="${id}">${esc(f.label)}${f.required ? ' <span aria-hidden="true">*</span>' : ''}</label>${input}${f.hint ? `<span class="hint" id="${id}_hint">${esc(f.hint)}</span>` : ''}<span class="err" id="${id}_err" hidden></span></div>`;
}
function applyShowIf(form) {
  for (const el of form.querySelectorAll('[data-show-field]')) {
    const ctl = form.elements.namedItem(el.dataset.showField);
    el.hidden = !(ctl && el.dataset.showValues.split(' ').includes(ctl.value));
  }
}
function openForm({ title, intro, fields, values = {}, submit = 'Save', extraHtml = '', validate, onSubmit, wide, onChange }) {
  openModal(`<form id="mform" novalidate>
    <div class="md-head"><div><h2 id="modalTitle">${esc(title)}</h2>${intro ? `<p>${esc(intro)}</p>` : ''}</div><button type="button" class="btn icon-btn ghost" data-act="close-modal" aria-label="Close">${icon('x')}</button></div>
    <div class="md-body"><div class="form-grid">${fields.map(f => fieldHtml(f, values[f.name])).join('')}</div>${extraHtml}</div>
    <div class="md-foot"><button type="button" class="btn" data-act="close-modal">Cancel</button><button type="submit" class="btn primary">${esc(submit)}</button></div>
  </form>`, { wide });
  const form = $('#mform');
  applyShowIf(form);
  form.addEventListener('change', e => { applyShowIf(form); if (onChange) onChange(e, form); });
  if (onChange) onChange(null, form);
  form.addEventListener('submit', async e => {
    e.preventDefault();
    const vals = {};
    for (const f of fields) {
      const el = form.elements.namedItem(f.name);
      if (!el) continue;
      vals[f.name] = f.type === 'checkbox' ? el.checked : f.type === 'number' ? (el.value === '' ? '' : Number(el.value)) : el.value.trim();
    }
    const errs = {};
    for (const f of fields) {
      const box = form.querySelector('#f_' + f.name);
      const hiddenField = box && box.closest('[data-show-field]') && box.closest('[data-show-field]').hidden;
      if (f.required && !hiddenField && (vals[f.name] === '' || vals[f.name] == null)) errs[f.name] = 'This field is required';
    }
    if (validate) Object.assign(errs, validate(vals) || {});
    let first = null;
    for (const f of fields) {
      const el = form.elements.namedItem(f.name);
      const box = form.querySelector('#f_' + f.name + '_err');
      if (!el || !box) continue;
      const msg = errs[f.name];
      if (msg) { el.setAttribute('aria-invalid', 'true'); el.setAttribute('aria-describedby', box.id); if (!first) first = el; }
      else { el.removeAttribute('aria-invalid'); const h = form.querySelector('#f_' + f.name + '_hint'); if (h) el.setAttribute('aria-describedby', h.id); else el.removeAttribute('aria-describedby'); }
      box.hidden = !msg; box.textContent = msg || '';
    }
    if (first) { first.focus(); return; }
    const btn = form.querySelector('[type=submit]');
    btn.disabled = true;
    const ok = await onSubmit(vals, form);
    btn.disabled = false;
    if (ok !== false) closeModal();
  });
}
function confirmBox({ title, body, confirm = 'Delete', danger = true }) {
  return new Promise(resolve => {
    openModal(`<div class="md-head"><div><h2 id="modalTitle">${esc(title)}</h2></div></div>
      <div class="md-body"><p>${esc(body)}</p></div>
      <div class="md-foot"><button type="button" class="btn" data-act="confirm-no">Cancel</button><button type="button" class="btn ${danger ? 'danger solid' : 'primary'}" data-act="confirm-yes" autofocus>${esc(confirm)}</button></div>`, { kind: 'confirm' });
    modalState.resolve = resolve;
  });
}
function settleConfirm(v) {
  const r = modalState && modalState.resolve;
  if (modalState) modalState.resolve = null;
  closeModal();
  if (r) r(v);
}
// Select options for the 17 focus sub-categories, grouped by area.
function focusOptions(first) {
  return [first, ...FOCUS.map(a => ({ group: areaLabel(a), options: a.subs.map(s => [s.id, s.solo ? s.name : s.name]) }))];
}

// ---------- person ----------
function skillsEditorHtml(cur) {
  const X = ix();
  if (!X.skills.length) return `<p class="faint">Add skills in the Skills view to rate people against them.</p>`;
  return `<fieldset class="skills-editor"><legend class="field-label">Skills <span class="faint">(1 Basic · 2 Working · 3 Advanced · 4 Expert)</span></legend>${groupBy(X.skills, s => s.cat).map(([cat, list]) => `<div><h4>${esc(cat)}</h4><div class="se-grid">${list.map(s => `<label class="se-row"><span>${esc(s.name)}</span><select data-skill="${esc(s.id)}" aria-label="${esc(s.name)} level">${LEVELS.map((l, i) => `<option value="${i}"${(cur[s.id] || 0) === i ? ' selected' : ''}>${i ? i + ' · ' + l : '—'}</option>`).join('')}</select></label>`).join('')}</div></div>`).join('')}</fieldset>`;
}
function personForm(id) {
  const X = ix();
  const raw = id ? S.people.get(id) : null;
  const v = raw
    ? { name: raw.name || '', role: raw.role || '', home: normPerson(id, raw).home, team: raw.team || '', location: raw.location || '', email: raw.email || '', type: PTYPES.includes(raw.type) ? raw.type : 'Employee', fte: fteOf(raw), startDate: raw.startDate || '', endDate: raw.endDate || '', notes: raw.notes || '' }
    : { type: 'Employee', fte: 100, home: app.f.people.home || '', team: app.f.people.team || '' };
  const cur = {};
  if (raw && raw.skills) for (const [k, l] of Object.entries(raw.skills)) cur[k] = clamp(Math.round(num(l, 0)), 0, 4);
  openForm({
    title: raw ? `Edit ${raw.name || 'person'}` : 'Add person', wide: true,
    submit: raw ? 'Save changes' : 'Add person',
    fields: [
      { name: 'name', label: 'Full name', required: true },
      { name: 'role', label: 'Role or job title', placeholder: 'e.g. Product Specialist' },
      { name: 'home', label: 'Capability Home', type: 'select', options: [['', 'Not set'], ...HOMES.map(a => [a.id, areaLabel(a)])], hint: 'Their stable professional home.' },
      { name: 'team', label: 'Team', list: X.teams, placeholder: 'e.g. Equity Product Specialists' },
      { name: 'fte', label: 'FTE (%)', type: 'number', min: 5, max: 100, step: 5, required: true, hint: '100 is full time. All capacity is measured as a share of FTE.' },
      { name: 'type', label: 'Employment type', type: 'select', options: PTYPES },
      { name: 'location', label: 'Location', list: [...new Set(X.people.map(p => p.location).filter(Boolean))].sort() },
      { name: 'email', label: 'Email', type: 'email' },
      { name: 'startDate', label: 'Start date', type: 'date' },
      { name: 'endDate', label: 'End date', type: 'date', hint: 'For contractors or leavers. Leave empty if open-ended.' },
      { name: 'notes', label: 'Notes', type: 'textarea', full: true },
    ],
    values: v,
    extraHtml: skillsEditorHtml(cur),
    validate: vals => {
      const e = {};
      if (vals.email && !/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(vals.email)) e.email = 'Enter a valid email address, or leave it empty';
      if (vals.fte === '' || vals.fte < 5 || vals.fte > 100) e.fte = 'Enter an FTE between 5% and 100%';
      if (vals.startDate && vals.endDate && vals.endDate < vals.startDate) e.endDate = 'The end date is before the start date';
      return e;
    },
    onSubmit: async (vals, form) => {
      const skills = {};
      for (const sel of form.querySelectorAll('select[data-skill]')) { const l = Number(sel.value); if (l > 0) skills[sel.dataset.skill] = l; }
      const pid = id || uid('p_');
      const body = Object.assign({}, raw || { createdAt: new Date().toISOString() }, vals, { fte: Math.round(Number(vals.fte)), skills, sample: false });
      delete body.hoursPerWeek;
      const ok = await run(() => putDoc('people', pid, body), raw ? 'Changes saved' : `${vals.name} added`);
      if (ok && !raw) setTimeout(() => openDrawer('person', pid), 60);
      return ok;
    },
  });
}

// ---------- activity ----------
function projectForm(id, presetKind) {
  const X = ix();
  const raw = id ? S.projects.get(id) : null;
  const t = X.T;
  const kind0 = presetKind || app.f.activities.kind || 'outcome';
  const v = raw
    ? { name: raw.name || '', kind: KIND[raw.kind] ? raw.kind : 'outcome', focus: SUB.has(raw.focus) ? raw.focus : '', code: raw.code || '', sponsor: raw.sponsor || '', status: STATUSES.includes(raw.status) ? raw.status : 'Planned', priority: PRIORITIES.includes(raw.priority) ? raw.priority : 'Medium', leadId: raw.leadId || '', startDate: raw.startDate || '', endDate: raw.endDate || '', purpose: raw.purpose || '', why: raw.why || '', deprio: raw.deprio || '', reviewDate: raw.reviewDate || '', decision: raw.decision || '', description: raw.description || '' }
    : { kind: kind0, status: kind0 === 'outcome' ? 'Planned' : 'Active', priority: 'Medium', startDate: iso(kind0 === 'outcome' ? monday(t) + 7 * DAY : t), endDate: kind0 === 'outcome' ? iso(monday(t) + 7 * DAY + 13 * 7 * DAY - 3 * DAY) : '', code: kind0 === 'outcome' ? nextCode() : '' };
  openForm({
    title: raw ? `Edit ${raw.name || 'activity'}` : 'Add activity', wide: true,
    submit: raw ? 'Save changes' : 'Add activity',
    intro: raw ? '' : 'Capability Home work is enduring; Outcome Teams are temporary projects; Franchise Networks are ongoing virtual networks.',
    fields: [
      { name: 'name', label: 'Name', required: true, full: true },
      { name: 'kind', label: 'Impact@Scale type', type: 'select', required: true, options: [['home', 'Capability Home · enduring work'], ['outcome', 'Outcome Team · temporary project'], ['network', 'Franchise Network · ongoing virtual network']] },
      { name: 'focus', label: 'Focus (type of work)', type: 'select', options: focusOptions(['', 'Not set']), hint: 'Default for everyone booked here. A booking can override it.' },
      { name: 'status', label: 'Status', type: 'select', options: STATUSES, hint: 'Time on On hold and Completed activities counts only up to today.' },
      { name: 'priority', label: 'Priority', type: 'select', options: PRIORITIES },
      { name: 'leadId', label: 'Lead', type: 'select', options: [['', 'Not named yet'], ...X.people.map(p => [p.id, p.name])], hint: 'Outcome Lead, Franchise Steward or Team Lead.' },
      { name: 'sponsor', label: 'Sponsor', list: [...new Set(X.projects.map(p => p.sponsor).filter(Boolean))].sort() },
      { name: 'code', label: 'Code', placeholder: 'Optional' },
      { name: 'startDate', label: 'Start date', type: 'date', required: true },
      { name: 'endDate', label: 'End date', type: 'date', hint: 'Target end date for an Outcome. Leave empty for ongoing work.' },
      { name: 'purpose', label: 'Intended result or purpose', type: 'textarea', rows: 2, full: true, placeholder: 'One sentence' },
      { name: 'why', label: 'Why this is an Outcome rather than BAU', type: 'textarea', rows: 2, full: true, showIf: ['kind', ['outcome']] },
      { name: 'deprio', label: 'Capacity released: what is paused, delegated or deprioritized', type: 'textarea', rows: 2, full: true, showIf: ['kind', ['outcome']] },
      { name: 'reviewDate', label: 'Forum review date', type: 'date', showIf: ['kind', ['network']] },
      { name: 'decision', label: 'Last Forum decision', type: 'select', options: [['', 'None yet'], ...DECISIONS.map(d => [d, d])], showIf: ['kind', ['network']] },
      { name: 'description', label: 'Notes', type: 'textarea', full: true, placeholder: 'Scope, products or regions covered, decision gates, risks' },
    ],
    values: v,
    validate: vals => {
      const e = {};
      if (vals.startDate && vals.endDate && vals.endDate < vals.startDate) e.endDate = 'The end date is before the start date';
      if (vals.kind === 'outcome' && !vals.endDate) e.endDate = 'Outcome Teams are temporary: give a target end date';
      return e;
    },
    onSubmit: async vals => {
      const pid = id || uid('pr_');
      const body = Object.assign({}, raw || { createdAt: new Date().toISOString() }, vals, { sample: false });
      if (vals.kind !== 'outcome') { body.why = ''; body.deprio = ''; }
      if (vals.kind !== 'network') { body.reviewDate = ''; body.decision = ''; }
      const ok = await run(() => putDoc('projects', pid, body), raw ? 'Changes saved' : `${vals.name} added`);
      if (ok && !raw) setTimeout(() => openDrawer('project', pid), 60);
      return ok;
    },
  });
}
function nextCode() {
  const X = ix();
  const y = new Date(X.T).getUTCFullYear();
  let max = 0;
  for (const p of X.projects) { const m = new RegExp('^OUT-' + y + '-(\\d+)$').exec(p.code); if (m) max = Math.max(max, +m[1]); }
  return `OUT-${y}-${String(max + 1).padStart(3, '0')}`;
}

// ---------- booking / role ----------
function asgForm({ id, projectId, personId, preset }) {
  const X = ix();
  if (!X.projects.length) { toast('Create an activity first, then book people on it.'); projectForm(); return; }
  const raw = id ? S.assignments.get(id) : null;
  let v;
  if (raw) {
    v = { projectId: raw.projectId || '', personId: raw.personId || '', role: raw.role || '', focus: SUB.has(raw.focus) ? raw.focus : '', skillId: raw.skillId || '', minLevel: String(raw.minLevel || 0), allocation: raw.allocation ?? 50, startDate: raw.startDate || '', endDate: raw.endDate || '', booking: raw.booking === 'Tentative' ? 'Tentative' : 'Confirmed' };
  } else {
    const pr = X.J.get(projectId) || X.projects.find(p => p.status === 'Active') || X.projects.find(p => COUNTS.has(p.status)) || X.projects[0];
    const s = pr && pr.start != null ? Math.max(pr.start, X.W0) : X.W0;
    const e = pr && pr.end != null && pr.end >= s ? pr.end : null;
    v = { projectId: pr ? pr.id : '', personId: personId || '', role: '', focus: '', skillId: '', minLevel: '0', allocation: 20, startDate: iso(s), endDate: e != null ? iso(e) : '', booking: 'Confirmed' };
    if (personId) { const p = X.P.get(personId); if (p) v.role = p.role; }
    if (preset) Object.assign(v, preset);
  }
  const person = X.P.get(v.personId);
  const proj = X.J.get(v.projectId);
  const title = raw ? (raw.personId ? 'Edit booking' : 'Edit role') : person ? `Book ${person.name}` : proj ? `Add a role to ${proj.name}` : 'Add a role';
  const actOpts = KINDS.map(k => ({ group: k.plural, options: X.projects.filter(p => p.kind === k.id).map(p => [p.id, `${p.name}${p.status !== 'Active' ? ' (' + p.status + ')' : ''}`]) })).filter(g => g.options.length);
  openForm({
    title, submit: raw ? 'Save changes' : person ? 'Book' : 'Add role', wide: true,
    intro: raw ? '' : 'Leave the person empty to create an open role you can staff later.',
    fields: [
      { name: 'projectId', label: 'Activity', type: 'select', required: true, full: true, options: actOpts },
      { name: 'personId', label: 'Person', type: 'select', full: true, options: [['', 'Open role, nobody assigned yet'], ...X.people.map(p => [p.id, `${p.name}${p.team ? ' · ' + p.team : ''}${p.fte !== 100 ? ' · ' + p.fte + '% FTE' : ''}`])] },
      { name: 'role', label: 'Role on the activity', required: true, placeholder: 'e.g. Launch coordinator' },
      { name: 'allocation', label: 'Allocation (% FTE)', type: 'number', min: 1, max: 100, step: 5, required: true, hint: 'Share of one full-time person. Broad bands are enough: 10%, 20%, 30%…' },
      { name: 'focus', label: 'Focus (type of work)', type: 'select', full: true, options: focusOptions(['', 'Same as the activity']) },
      { name: 'booking', label: 'Booking', type: 'select', options: [['Confirmed', 'Confirmed'], ['Tentative', 'Tentative (soft booking)']] },
      { name: 'skillId', label: 'Main skill needed', type: 'select', options: [['', 'No specific skill'], ...X.skills.map(s => [s.id, s.name])] },
      { name: 'minLevel', label: 'Minimum level', type: 'select', options: [['0', 'Any level'], ['1', '1 · Basic'], ['2', '2 · Working'], ['3', '3 · Advanced'], ['4', '4 · Expert']] },
      { name: 'startDate', label: 'Start date', type: 'date', required: true },
      { name: 'endDate', label: 'End date', type: 'date', hint: 'Leave empty to run until the activity ends, or ongoing.' },
    ],
    values: v,
    onChange: (e, form) => {
      const sel = form.elements.namedItem('focus');
      const pr = X.J.get(form.elements.namedItem('projectId').value);
      if (sel && sel.options[0]) sel.options[0].textContent = pr && SUB.has(pr.focus) ? `Same as the activity: ${focusText(pr.focus)}` : 'Same as the activity (not set)';
      if (!raw && pr && e && e.target && e.target.name === 'projectId') {
        const s = pr.start != null ? Math.max(pr.start, X.W0) : X.W0;
        form.elements.namedItem('startDate').value = iso(s);
        form.elements.namedItem('endDate').value = pr.end != null && pr.end >= s ? iso(pr.end) : '';
      }
    },
    validate: vals => {
      const e = {};
      if (vals.allocation !== '' && (vals.allocation < 1 || vals.allocation > 100)) e.allocation = 'Enter a percentage between 1 and 100';
      if (vals.startDate && vals.endDate && vals.endDate < vals.startDate) e.endDate = 'The end date is before the start date';
      return e;
    },
    onSubmit: async vals => {
      const aid = id || uid('a_');
      const body = Object.assign({}, raw || { createdAt: new Date().toISOString() }, vals, { allocation: Number(vals.allocation), minLevel: Number(vals.minLevel), sample: false });
      const who = X.P.get(vals.personId);
      return run(() => putDoc('assignments', aid, body), raw ? 'Changes saved' : who ? `${who.name} booked` : 'Open role added');
    },
  });
}

// ---------- time off ----------
function offForm(id, personId) {
  const X = ix();
  const raw = id ? S.timeoff.get(id) : null;
  const pid = raw ? raw.personId : (personId || '');
  const v = raw
    ? { personId: raw.personId || '', type: OFFTYPES.includes(raw.type) ? raw.type : 'Other', startDate: raw.startDate || '', endDate: raw.endDate || raw.startDate || '', note: raw.note || '' }
    : { personId: pid || (X.people[0] ? X.people[0].id : ALL), type: pid === ALL ? 'Public holiday' : 'Vacation', startDate: iso(X.T), endDate: iso(X.T), note: '' };
  openForm({
    title: raw ? 'Edit time off' : 'Add time off',
    submit: raw ? 'Save changes' : 'Add time off',
    intro: 'Working days in this range are removed from the person’s available FTE. Weekends are ignored.',
    fields: [
      { name: 'personId', label: 'Who', type: 'select', full: true, options: [[ALL, 'Everyone (public holiday or office closure)'], ...X.people.map(p => [p.id, p.name])] },
      { name: 'type', label: 'Type', type: 'select', options: OFFTYPES },
      { name: 'note', label: 'Note', placeholder: 'Optional' },
      { name: 'startDate', label: 'First day', type: 'date', required: true },
      { name: 'endDate', label: 'Last day', type: 'date', required: true },
    ],
    values: v,
    validate: vals => (vals.startDate && vals.endDate && vals.endDate < vals.startDate ? { endDate: 'The last day is before the first day' } : {}),
    onSubmit: async vals => {
      const tid = id || uid('t_');
      const body = Object.assign({}, raw || { createdAt: new Date().toISOString() }, vals, { sample: false });
      return run(() => putDoc('timeoff', tid, body), raw ? 'Changes saved' : 'Time off added');
    },
  });
}

// ---------- skill ----------
function skillForm(id) {
  const X = ix();
  const raw = id ? S.skills.get(id) : null;
  const v = raw ? { name: raw.name || '', category: raw.category || '', critical: !!raw.critical } : { category: app.f.skills.cat || '', critical: false };
  openForm({
    title: raw ? `Edit ${raw.name || 'skill'}` : 'Add skill',
    submit: raw ? 'Save changes' : 'Add skill',
    fields: [
      { name: 'name', label: 'Skill name', required: true, placeholder: 'e.g. Index methodology' },
      { name: 'category', label: 'Category', list: X.cats, placeholder: 'e.g. Product & structuring' },
      { name: 'critical', label: 'Business-critical', type: 'checkbox', full: true, hint: 'The dashboard warns when fewer than two people are Advanced or Expert.' },
    ],
    values: v,
    validate: vals => {
      const dup = X.skills.find(s => s.name.toLowerCase() === vals.name.toLowerCase() && s.id !== id);
      return dup ? { name: 'A skill with this name already exists' } : {};
    },
    onSubmit: async vals => {
      const sid = id || uid('sk_');
      const body = Object.assign({}, raw || { createdAt: new Date().toISOString() }, { name: vals.name, category: vals.category || 'Other', critical: !!vals.critical });
      return run(() => putDoc('skills', sid, body), raw ? 'Changes saved' : `${vals.name} added`);
    },
  });
}

// ---------- deletions ----------
async function deletePerson(id) {
  const X = ix();
  const p = X.P.get(id);
  if (!p) return;
  const all = [...S.assignments].filter(([, d]) => d && d.personId === id).map(([aid, d]) => ({ aid, d, e: pd(d.endDate) }));
  const future = all.filter(x => x.e == null || x.e >= X.T);
  const past = all.filter(x => x.e != null && x.e < X.T);
  const offs = [...S.timeoff].filter(([, d]) => d && d.personId === id);
  const parts = [];
  if (future.length) parts.push(`${plural(future.length, 'current or upcoming booking')} will become open ${future.length === 1 ? 'role' : 'roles'}`);
  if (past.length) parts.push(`${plural(past.length, 'past booking')} will be deleted`);
  if (offs.length) parts.push(`${plural(offs.length, 'time-off entry', 'time-off entries')} will be deleted`);
  const ok = await confirmBox({ title: `Delete ${p.name}?`, body: parts.length ? parts.join(', ') + '.' : 'This removes them from the planner.', confirm: 'Delete person' });
  if (!ok) return;
  const ops = [{ coll: 'people', id, del: true }];
  for (const x of future) ops.push({ coll: 'assignments', id: x.aid, body: Object.assign({}, x.d, { personId: '' }) });
  for (const x of past) ops.push({ coll: 'assignments', id: x.aid, del: true });
  for (const [tid] of offs) ops.push({ coll: 'timeoff', id: tid, del: true });
  $('#drawer').open && $('#drawer').close();
  const res = await bulk(ops);
  if (res.failed.length) failWrite(res.failed[0].e); else toast(`${p.name} deleted`);
}
async function deleteProject(id) {
  const X = ix();
  const pr = X.J.get(id);
  if (!pr) return;
  const roles = [...S.assignments].filter(([, d]) => d && d.projectId === id);
  const ok = await confirmBox({ title: `Delete ${pr.name}?`, body: roles.length ? `Its ${plural(roles.length, 'role and booking', 'roles and bookings')} will be deleted too, and availability updates straight away.` : 'This removes the activity from the planner.', confirm: 'Delete activity' });
  if (!ok) return;
  $('#drawer').open && $('#drawer').close();
  const res = await bulk([{ coll: 'projects', id, del: true }, ...roles.map(([aid]) => ({ coll: 'assignments', id: aid, del: true }))]);
  if (res.failed.length) failWrite(res.failed[0].e); else toast(`${pr.name} deleted`);
}
async function deleteAsg(id) {
  const X = ix();
  const a = X.asg.find(x => x.id === id);
  if (!a) return;
  const p = a.personId ? X.P.get(a.personId) : null;
  const ok = await confirmBox({ title: p ? 'Delete this booking?' : 'Delete this open role?', body: `${a.role} on ${a.project.name}${p ? ' for ' + p.name : ''}, ${whenTxt(a)}.`, confirm: 'Delete' });
  if (ok) await run(() => delDoc('assignments', id), 'Deleted');
}
async function deleteOff(id) {
  const X = ix();
  const t = X.offs.find(x => x.id === id);
  if (!t) return;
  const who = t.personId === ALL ? 'Everyone' : (X.P.get(t.personId) || {}).name || 'Someone';
  const ok = await confirmBox({ title: 'Delete this time off?', body: `${who}: ${t.type}, ${fdr(t.s, t.e)}.`, confirm: 'Delete' });
  if (ok) await run(() => delDoc('timeoff', id), 'Deleted');
}
async function deleteSkill(id) {
  const X = ix();
  const s = X.K.get(id);
  if (!s) return;
  const ppl = [...S.people].filter(([, d]) => d && d.skills && num(d.skills[id], 0) > 0);
  const roles = [...S.assignments].filter(([, d]) => d && d.skillId === id);
  const ok = await confirmBox({ title: `Delete ${s.name}?`, body: `It will be removed from ${plural(ppl.length, 'person’s profile', 'people’s profiles')}${roles.length ? ` and from ${plural(roles.length, 'role')} that ask for it` : ''}.`, confirm: 'Delete skill' });
  if (!ok) return;
  const ops = [{ coll: 'skills', id, del: true }];
  for (const [pid, d] of ppl) { const sk = Object.assign({}, d.skills); delete sk[id]; ops.push({ coll: 'people', id: pid, body: Object.assign({}, d, { skills: sk }) }); }
  for (const [aid, d] of roles) ops.push({ coll: 'assignments', id: aid, body: Object.assign({}, d, { skillId: '', minLevel: 0 }) });
  const res = await bulk(ops);
  if (res.failed.length) failWrite(res.failed[0].e); else toast(`${s.name} deleted`);
}
async function removeSamples() {
  const ops = [];
  const counts = {};
  for (const c of COLLS) for (const [id, d] of S[c]) if (d && d.sample) { ops.push({ coll: c, id, del: true }); counts[c] = (counts[c] || 0) + 1; }
  if (!ops.length) return;
  const ok = await confirmBox({
    title: 'Remove the example data?',
    body: `This deletes ${plural(counts.people || 0, 'example person', 'example people')}, ${plural(counts.projects || 0, 'activity', 'activities')}, ${plural(counts.assignments || 0, 'booking')} and ${plural(counts.timeoff || 0, 'time-off entry', 'time-off entries')}. The skills catalogue and anything you added or edited yourself stay.`,
    confirm: 'Remove examples',
  });
  if (!ok) return;
  if ($('#drawer').open) $('#drawer').close();
  toast(`Removing ${ops.length} example records…`, 60000);
  const res = await bulk(ops, (d, n) => toast(`Removing example records… ${d} of ${n}`, 60000));
  if (res.failed.length) failWrite(res.failed[0].e);
  else toast('Examples removed. Add your people or import a workbook to start.');
}
// Example data travels with the page. Its dates move by whole weeks so it always sits around today.
async function loadSamples() {
  if (typeof SEED_DATA === 'undefined') return;
  const ref = pd(SEED_DATA.refMonday);
  const shift = ref == null ? 0 : monday(todayMs()) - ref;
  const mv = s => { const t = pd(s); return t == null ? s : iso(t + shift); };
  const ops = [];
  for (const c of COLLS) {
    const docs = SEED_DATA.docs[c] || {};
    for (const [id, d] of Object.entries(docs)) {
      if (c !== 'skills' && S[c].has(id)) continue;
      if (c === 'skills' && S.skills.has(id)) continue;
      const body = Object.assign({}, d);
      if (!(c === 'timeoff' && body.personId === ALL)) for (const k of ['startDate', 'endDate', 'reviewDate']) if (body[k]) body[k] = mv(body[k]);
      ops.push({ coll: c, id, body });
    }
  }
  toast(`Adding ${ops.length} example records…`, 60000);
  const res = await bulk(ops, (d, n) => toast(`Adding example records… ${d} of ${n}`, 60000));
  if (res.failed.length) failWrite(res.failed[0].e);
  else toast('Example data added. Remove it any time with “Remove examples”.');
}

// ---------- finder ----------
let finder = null;
function openFinder(roleId) {
  const X = ix();
  const a = roleId ? X.asg.find(x => x.id === roleId) : null;
  finder = a
    ? { roleId, skillId: a.skillId, min: Math.max(1, a.minLevel || 1), s: iso(Math.max(a.s, X.T)), e: iso(a.ongoing ? Math.max(a.s, X.T) + 12 * 7 * DAY : Math.max(a.e, X.T)), need: a.alloc }
    : { roleId: null, skillId: app.f.avail.skill || '', min: app.f.avail.skill ? app.f.avail.min : 2, s: iso(X.W0), e: iso(X.W0 + 7 * 7 * DAY + 4 * DAY), need: 20 };
  const title = a ? `Staff the role “${a.role}”` : 'Find available people';
  const intro = a ? `${a.project.name} · ${a.alloc}% FTE · ${whenTxt(a)}. People are ranked by how many weeks they have the time free, then by skill level.` : 'Choose a skill and a period. People are ranked by how many weeks they have the time free, then by skill level.';
  openModal(`<div class="md-head"><div><h2 id="modalTitle">${esc(title)}</h2><p>${esc(intro)}</p></div><button type="button" class="btn icon-btn ghost" data-act="close-modal" aria-label="Close">${icon('x')}</button></div>
    <div class="md-body">
      <div class="finder-form">
        <label class="field f-skill"><span>Skill</span><select data-fbind="skillId">${[['', 'Any skill'], ...X.skills.map(s => [s.id, s.name])].map(([v, l]) => `<option value="${esc(v)}"${v === finder.skillId ? ' selected' : ''}>${esc(l)}</option>`).join('')}</select></label>
        <label class="field"><span>Level</span><select data-fbind="min">${[1, 2, 3, 4].map(i => `<option value="${i}"${i === finder.min ? ' selected' : ''}>${LEVELS[i]}+</option>`).join('')}</select></label>
        <label class="field"><span>From</span><input type="date" data-fbind="s" value="${finder.s}"></label>
        <label class="field"><span>To</span><input type="date" data-fbind="e" value="${finder.e}"></label>
        <label class="field"><span>Time needed (% FTE)</span><input type="number" min="5" max="100" step="5" data-fbind="need" value="${finder.need}" aria-describedby="needHint"></label>
      </div>
      <p class="hint faint" id="needHint" style="font-size:12px">Time needed is a share of one full-time person, checked against what each person still has free in every week.</p>
      <div id="cands" aria-live="polite"></div>
    </div>
    <div class="md-foot"><button type="button" class="btn" data-act="close-modal">Close</button></div>`, { wide: true, kind: 'finder' });
  renderCands();
}
function renderCands() {
  const box = $('#cands');
  if (!box || !finder) return;
  const X = ix();
  const s = pd(finder.s), e = pd(finder.e);
  if (s == null || e == null || e < s) { box.innerHTML = `<p class="empty-note">Choose a valid date range.</p>`; return; }
  const list = candidates({ skillId: finder.skillId, minLevel: finder.min, s, e, need: clamp(num(finder.need, 20), 1, 100) });
  const top = list.slice(0, 12);
  const sk = finder.skillId ? X.K.get(finder.skillId) : null;
  if (!top.length) { box.innerHTML = `<p class="empty-note">${sk ? `No one is at ${LEVELS[finder.min]} or above in ${esc(sk.name)}.` : 'No one is employed in this period.'} Try a lower level or another skill.</p>`; return; }
  const edit = canEdit();
  box.innerHTML = `<div class="list-meta" style="margin-bottom:8px"><span>${plural(list.length, 'match', 'matches')}${list.length > top.length ? `, best ${top.length} shown` : ''}</span><span class="legend" style="margin:0"><span><i class="sw" style="background:var(--good)"></i>Time free</span><span><i class="sw" style="background:var(--warn);opacity:.75"></i>Partly free</span><span><i class="sw" style="background:var(--heat-off)"></i>Off</span></span></div>
    <div class="cands">${top.map(c => `<div class="cand">
      <div class="who">${avatar(c.p)}<span><strong>${esc(c.p.name)}</strong><small class="faint" style="display:block">${esc([c.p.role, c.p.team, c.p.fte !== 100 ? c.p.fte + '% FTE' : ''].filter(Boolean).join(' · '))}</small></span></div>
      <div class="c-level">${sk ? `${pips(c.level)} <span class="muted" style="font-size:12.5px">${LEVELS[c.level]}</span>` : ''}</div>
      <div class="c-fit"><div class="fitbar" aria-hidden="true">${c.marks.map(m => `<i class="${m}"></i>`).join('')}</div><small class="faint" style="font-size:11.5px">${c.fit} of ${plural(c.weeks, 'week')} with the time free · ${pctFte(c.avgFree)} free on average</small></div>
      <div>${edit ? (finder.roleId ? `<button type="button" class="btn small primary" data-act="assign" data-id="${esc(finder.roleId)}" data-person="${esc(c.p.id)}">Assign</button>` : `<button type="button" class="btn small" data-act="book-found" data-person="${esc(c.p.id)}">Book</button>`) : ''}</div>
    </div>`).join('')}</div>`;
}

// ---------- focus guide ----------
function openGuide() {
  openModal(`<div class="md-head"><div><h2 id="modalTitle">Focus guide</h2><p>Where to allocate time, following the PPWS resource allocation paper. Every booking has one type and one focus sub-category.</p></div><button type="button" class="btn icon-btn ghost" data-act="close-modal" aria-label="Close">${icon('x')}</button></div>
    <div class="md-body guide">
      <h3>Impact@Scale types</h3>
      <dl class="guide-kinds">${KINDS.map(k => `<div><dt>${kindTag(k.id)}</dt><dd>${esc(k.desc)}</dd></div>`).join('')}</dl>
      <h3>Capability Home focus</h3>
      <ol class="guide-areas">${FOCUS.map(a => `<li><strong>${esc(a.name)}</strong><p class="muted">${esc(a.desc)}</p>${a.subs.some(s => !s.solo) ? `<ul>${a.subs.map(s => `<li><span>${esc(s.name)}</span><small>${esc(s.desc)}</small></li>`).join('')}</ul>` : `<p class="small">${esc(a.subs[0].desc)}</p>`}</li>`).join('')}</ol>
      <p class="faint small">Allocations use broad bands rather than false precision. The purpose is not time-sheet control: it shows whether capacity follows priorities.</p>
    </div>
    <div class="md-foot"><button type="button" class="btn primary" data-act="close-modal">Close</button></div>`, { wide: true, kind: 'guide' });
}

// ===================================================================
// Skill-level popover (matrix)
// ===================================================================
let popEl = null, popAnchor = null;
function openLevelPop(btn) {
  closePop();
  const X = ix();
  const p = X.P.get(btn.dataset.pid), s = X.K.get(btn.dataset.sid);
  if (!p || !s) return;
  const cur = p.skills[s.id] || 0;
  popEl = document.createElement('div');
  popEl.className = 'pop';
  popEl.setAttribute('role', 'menu');
  popEl.setAttribute('aria-label', `${p.name}, ${s.name}`);
  popEl.innerHTML = `<div class="pop-t">${esc(p.name)} · ${esc(s.name)}</div>` + LEVELS.map((l, i) => `<button type="button" role="menuitemradio" aria-checked="${i === cur}" data-act="set-lvl" data-pid="${esc(p.id)}" data-sid="${esc(s.id)}" data-v="${i}"><span class="lvl l${i}" aria-hidden="true">${i || ''}</span>${esc(i ? l : 'None')}</button>`).join('');
  document.body.appendChild(popEl);
  popAnchor = btn;
  positionPop();
  const checked = popEl.querySelector('[aria-checked="true"]');
  (checked || popEl.querySelector('button')).focus({ preventScroll: true });
}
function positionPop() {
  if (!popEl) return;
  if (!popAnchor || !document.contains(popAnchor)) { closePop(); return; }
  const r = popAnchor.getBoundingClientRect();
  if (r.bottom < 0 || r.top > innerHeight) { closePop(); return; }
  const pw = popEl.offsetWidth, ph = popEl.offsetHeight;
  let left = r.left, top = r.bottom + 6;
  if (left + pw > innerWidth - 8) left = innerWidth - pw - 8;
  if (top + ph > innerHeight - 8) top = r.top - ph - 6;
  popEl.style.left = Math.max(8, left) + 'px';
  popEl.style.top = Math.max(8, top) + 'px';
}
function closePop(refocus) {
  if (!popEl) return;
  popEl.remove();
  popEl = null;
  if (refocus && popAnchor && document.contains(popAnchor)) popAnchor.focus();
  popAnchor = null;
}

// ===================================================================
// Tooltip
// ===================================================================
let tipFor = null;
function tipNode(title, rows, foot) {
  const box = document.createElement('div');
  const h = document.createElement('div');
  h.className = 'tip-t';
  h.textContent = title;
  box.append(h);
  for (const [val, label, key] of rows) {
    const r = document.createElement('div');
    r.className = 'tip-r';
    const k = document.createElement('i');
    k.className = 'tip-k';
    if (key) k.style.background = `var(${key})`;
    const b = document.createElement('strong');
    b.textContent = val;
    const a = document.createElement('span');
    a.textContent = label;
    r.append(k, b, a);
    box.append(r);
  }
  if (foot) { const f = document.createElement('div'); f.className = 'tip-f'; f.textContent = foot; box.append(f); }
  return box;
}
const KVAR = { home: '--k-home', outcome: '--k-outcome', network: '--k-network', free: null };
function buildTip(key) {
  const X = ix();
  const [kind, a, b] = key.split(':');
  const wkRange = wk => `${wkCode(wk)} · ${fdr(wk, wk + 4 * DAY)}`;
  const f = app.f.dash;
  const dash = () => dashData(f.period, f.home, f.team);
  switch (kind) {
    case 'hm': {
      const p = X.P.get(a);
      if (!p) return null;
      const wk = Number(b);
      const r = week(p, wk);
      const title = `${p.name} · ${wkRange(wk)}`;
      if (r.work === 0) return tipNode(title, [], 'Not employed this week');
      if (r.avail === 0) return tipNode(title, [], `Off all week: ${r.offTypes.join(', ')}`);
      const rows = [[pctFte(r.conf), 'Confirmed', '--s-conf'], [pctFte(r.tent), 'Tentative', '--s-tent'], [pctFte(r.free), r.free < 0 ? 'Over capacity' : 'Free', null]];
      for (const e of r.proj) rows.push([pctFte(e.v), e.a.project.name, KVAR[e.a.project.kind]]);
      const foot = [`${fmtPct(r.util)} of ${pctFte(r.cap)} available this week`, r.off ? `${plural(r.off, 'day')} off (${r.offTypes.join(', ')})` : '', r.outside ? 'Some bookings fall outside their contract dates' : ''].filter(Boolean).join(' · ');
      return tipNode(title, rows, foot);
    }
    case 'tw': {
      const ids = HM_TEAMS[Number(a)] || [];
      const wk = Number(b);
      let cap = 0, conf = 0, tent = 0, off = 0;
      for (const id of ids) { const p = X.P.get(id); if (!p) continue; const r = week(p, wk); cap += r.cap; conf += r.conf; tent += r.tent; off += r.off; }
      return tipNode(`Team · ${wkRange(wk)}`, [[fmtFte(conf), 'Confirmed', '--s-conf'], [fmtFte(tent), 'Tentative', '--s-tent'], [fmtFte(cap - conf - tent), 'Free', null]], `${fmtPct(cap ? (conf + tent) / cap : null)} of ${fmtFte(cap)} available${off ? ` · ${plural(off, 'person-day')} off` : ''}`);
    }
    case 'chart': {
      const cfg = CHARTS.get(a);
      const s = cfg && cfg.series[Number(b)];
      if (!s) return null;
      const rows = cfg.keys.map(k => [fmtFte(s[k.k] || 0), k.label, k.color.replace(/^var\((.*)\)$/, '$1')]);
      if (!cfg.noCap) rows.push([fmtFte(s.cap), 'Available capacity', '--fg']);
      const total = chartTotal(s, cfg);
      return tipNode(cfg.name(s), rows, cfg.noCap ? `${fmtFte(total)} in total` : `${fmtPct(s.cap ? total / s.cap : null)} of available capacity`);
    }
    case 'tu': case 'pu': {
      const D = dash();
      let label, sm;
      if (kind === 'tu') { const r = D.groupRows[Number(a)]; if (!r) return null; label = r.team || 'No team'; sm = r; }
      else { const r = D.per.find(x => x.p.id === a); if (!r) return null; label = r.p.name; sm = r.a; }
      return tipNode(label, [[fmtFte(sm.conf), 'Confirmed', '--s-conf'], [fmtFte(sm.tent), 'Tentative', '--s-tent'], [fmtFte(sm.free), 'Free', null]], `${fmtPct(sm.util)} of ${fmtFte(sm.cap)} available, ${D.P.short}`);
    }
    case 'sp': {
      const D = dash();
      const area = f.area;
      const cur = area ? kindTotals(D.A.subs, area) : D.A.tot;
      const v = a === 'free' ? D.A.tot.free : cur[a];
      const base = area ? cur.total : D.A.tot.booked + D.A.tot.free;
      const label = a === 'free' ? 'Unallocated' : KIND[a].plural;
      const top = a === 'free' ? [] : [...D.A.acts].map(([id, x]) => [X.J.get(id), x]).filter(([pr]) => pr && pr.kind === a && (!area || (SUB.has(pr.focus) && SUB.get(pr.focus).area.id === area))).sort((p, q) => q[1] - p[1]).slice(0, 4);
      return tipNode(`${label} · ${D.P.short}`, [[fmtFte(v), 'Average booked', KVAR[a]], [fmtPct(base ? v / base : null), area ? 'Of the time in this area' : 'Of available capacity', null], ...top.map(([pr, x]) => [fmtFte(x), pr.name, null])], a === 'free' ? 'Capacity not booked on any activity' : (area ? '' : KIND[a].desc.split('.')[0] + '.'));
    }
    case 'fa': case 'fs': case 'fx': {
      const D = dash();
      if (kind === 'fx') { const s = SUB.get(a); return s ? tipNode(s.name, [], s.desc) : null; }
      const ids = kind === 'fa' ? (AREA.has(a) ? areaSubIds(AREA.get(a)) : []) : [a === '-' ? '' : a];
      const title = kind === 'fa' ? AREA.get(a).name : (a === '-' ? 'Focus not set' : SUB.get(a).name);
      const rows = KINDS.filter(k => !f.kind || f.kind === k.id).map(k => [fmtFte(subValue(D.A.subs, ids, k.id)), k.plural, k.cssv]);
      const people = D.per.map(x => [x.p, subValue(x.a.subs, ids, f.kind)]).filter(x => x[1] > 0.004).sort((p, q) => q[1] - p[1]);
      return tipNode(`${title} · ${D.P.short}`, rows, people.length ? `${plural(people.length, 'person', 'people')}: ${people.slice(0, 5).map(([p, v]) => `${p.name} ${pctNum(v)}%`).join(', ')}${people.length > 5 ? '…' : ''}` : 'No one booked');
    }
    case 'pa': {
      const D = dash();
      const x = D.per.find(r => r.p.id === a);
      if (!x) return null;
      const r = x.a;
      const rows = [...KINDS.map(k => [pctFte(r[k.id]), k.plural, k.cssv]), [r.over > 0.005 ? '−' + pctFte(r.over) : pctFte(r.free), r.over > 0.005 ? 'Over capacity' : 'Unallocated', null]];
      const acts = [...r.acts].map(([id, v]) => [X.J.get(id), v]).filter(([pr]) => pr).sort((p, q) => q[1] - p[1]).slice(0, 5);
      for (const [pr, v] of acts) rows.push([pctFte(v), pr.name, KVAR[pr.kind]]);
      return tipNode(`${x.p.name} · ${D.P.short}`, rows, `Available ${pctFte(r.cap)} on average${x.p.fte < 100 ? ` of a ${x.p.fte}% FTE contract` : ''}`);
    }
    case 'tl': {
      const pr = X.J.get(a);
      if (!pr) return null;
      const st = staffing(pr);
      const lead = X.P.get(pr.leadId);
      return tipNode(pr.name, [[actDates(pr), 'Dates', null], [`${fmt1(st.filled)} / ${fmt1(st.total)} FTE`, 'Staffed', '--s-conf'], [String(st.open.length), st.open.length === 1 ? 'Open role' : 'Open roles', '--s-open']], [KIND[pr.kind].label, pr.status, lead ? leadLabel(pr.kind) + ': ' + lead.name : ''].filter(Boolean).join(' · '));
    }
    case 'lvl': {
      const p = X.P.get(a), s = X.K.get(b);
      if (!p || !s) return null;
      const l = p.skills[s.id] || 0;
      return tipNode(p.name, [[l ? `${l} · ${LEVELS[l]}` : 'None', s.name, null]], s.cat);
    }
    case 'sk': case 'cov': {
      const s = X.K.get(a);
      if (!s) return null;
      const c = coverage(s.id);
      const names = c.advPeople.map(p => p.name);
      return tipNode(s.name, [[String(c.by[4]), 'Expert', null], [String(c.by[3]), 'Advanced', null], [String(c.by[2]), 'Working', null], [String(c.by[1]), 'Basic', null]], (s.critical ? 'Business-critical. ' : '') + (names.length ? 'Advanced or expert: ' + names.join(', ') : 'No one is Advanced or Expert'));
    }
    default: return null;
  }
}
function showTip(el) {
  const node = buildTip(el.dataset.tip);
  if (!node) return;
  const t = $('#tip');
  const host = el.closest('dialog') || document.body;
  if (t.parentNode !== host) host.appendChild(t);
  t.replaceChildren(node);
  t.hidden = false;
  tipFor = el;
  const r = el.getBoundingClientRect();
  const tw = t.offsetWidth, th = t.offsetHeight;
  let x = r.left + r.width / 2 - tw / 2;
  let y = r.top - th - 8;
  if (y < 8) y = r.bottom + 8;
  x = clamp(x, 8, Math.max(8, innerWidth - tw - 8));
  t.style.left = x + 'px';
  t.style.top = y + 'px';
}
function hideTip() { const t = $('#tip'); if (t) t.hidden = true; tipFor = null; }

let toastTimer = 0;
function toast(msg, ms = 3800) {
  const t = $('#toast');
  placeToast();
  t.textContent = msg;
  t.hidden = false;
  clearTimeout(toastTimer);
  toastTimer = setTimeout(() => { t.hidden = true; }, ms);
}

// ===================================================================
// XLSX writer (no library): SpreadsheetML parts in a stored ZIP
// ===================================================================
const CRC_TABLE = (() => {
  const t = new Uint32Array(256);
  for (let n = 0; n < 256; n++) { let c = n; for (let k = 0; k < 8; k++) c = c & 1 ? 0xEDB88320 ^ (c >>> 1) : c >>> 1; t[n] = c >>> 0; }
  return t;
})();
function crc32(u8) { let c = 0xFFFFFFFF; for (let i = 0; i < u8.length; i++) c = CRC_TABLE[(c ^ u8[i]) & 0xFF] ^ (c >>> 8); return (c ^ 0xFFFFFFFF) >>> 0; }
function zipStore(files) {
  const enc = new TextEncoder();
  const parts = [], central = [];
  let offset = 0;
  const now = new Date();
  const dosTime = ((now.getHours() << 11) | (now.getMinutes() << 5) | (now.getSeconds() >> 1)) & 0xFFFF;
  const dosDate = (((now.getFullYear() - 1980) << 9) | ((now.getMonth() + 1) << 5) | now.getDate()) & 0xFFFF;
  for (const f of files) {
    const name = enc.encode(f.name);
    const data = typeof f.data === 'string' ? enc.encode(f.data) : f.data;
    const crc = crc32(data), size = data.length;
    const lh = new DataView(new ArrayBuffer(30));
    lh.setUint32(0, 0x04034b50, true); lh.setUint16(4, 20, true); lh.setUint16(6, 0x0800, true); lh.setUint16(8, 0, true);
    lh.setUint16(10, dosTime, true); lh.setUint16(12, dosDate, true); lh.setUint32(14, crc, true);
    lh.setUint32(18, size, true); lh.setUint32(22, size, true); lh.setUint16(26, name.length, true); lh.setUint16(28, 0, true);
    parts.push(new Uint8Array(lh.buffer), name, data);
    const ch = new DataView(new ArrayBuffer(46));
    ch.setUint32(0, 0x02014b50, true); ch.setUint16(4, 20, true); ch.setUint16(6, 20, true); ch.setUint16(8, 0x0800, true); ch.setUint16(10, 0, true);
    ch.setUint16(12, dosTime, true); ch.setUint16(14, dosDate, true); ch.setUint32(16, crc, true); ch.setUint32(20, size, true); ch.setUint32(24, size, true);
    ch.setUint16(28, name.length, true); ch.setUint16(30, 0, true); ch.setUint16(32, 0, true); ch.setUint16(34, 0, true); ch.setUint16(36, 0, true);
    ch.setUint32(38, 0, true); ch.setUint32(42, offset, true);
    central.push(new Uint8Array(ch.buffer), name);
    offset += 30 + name.length + size;
  }
  const cdSize = central.reduce((s, a) => s + a.length, 0);
  const end = new DataView(new ArrayBuffer(22));
  end.setUint32(0, 0x06054b50, true); end.setUint16(4, 0, true); end.setUint16(6, 0, true);
  end.setUint16(8, files.length, true); end.setUint16(10, files.length, true);
  end.setUint32(12, cdSize, true); end.setUint32(16, offset, true); end.setUint16(20, 0, true);
  return new Blob([...parts, ...central, new Uint8Array(end.buffer)], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
}
const xmlEsc = s => String(s).replace(/[\u0000-\u0008\u000B\u000C\u000E-\u001F  ]/g, '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
const colName = i => { let s = ''; i++; while (i > 0) { const m = (i - 1) % 26; s = String.fromCharCode(65 + m) + s; i = Math.floor((i - 1) / 26); } return s; };
const xlDate = ms => (ms == null ? null : (ms - Date.UTC(1899, 11, 30)) / DAY);
const sheetSafe = n => String(n).replace(/[\[\]:*?/\\]/g, ' ').slice(0, 31);

class Workbook {
  constructor() {
    this.sheets = []; this.sst = []; this.sstMap = new Map();
    this.fonts = []; this.fills = ['<fill><patternFill patternType="none"/></fill>', '<fill><patternFill patternType="gray125"/></fill>'];
    this.borders = ['<border><left/><right/><top/><bottom/><diagonal/></border>'];
    this.numFmts = new Map(); this.xfs = ['<xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/>']; this.xfMap = new Map();
    this.font({});
  }
  font({ bold, italic, size = 11, color }) {
    const x = `<font>${bold ? '<b/>' : ''}${italic ? '<i/>' : ''}<sz val="${size}"/>${color ? `<color rgb="${color}"/>` : ''}<name val="Calibri"/><family val="2"/></font>`;
    let i = this.fonts.indexOf(x);
    if (i < 0) { i = this.fonts.length; this.fonts.push(x); }
    return i;
  }
  fill(rgb) {
    if (!rgb) return 0;
    const x = `<fill><patternFill patternType="solid"><fgColor rgb="${rgb}"/><bgColor indexed="64"/></patternFill></fill>`;
    let i = this.fills.indexOf(x);
    if (i < 0) { i = this.fills.length; this.fills.push(x); }
    return i;
  }
  border(rgb) {
    if (!rgb) return 0;
    const x = `<border><left/><right/><top/><bottom style="thin"><color rgb="${rgb}"/></bottom><diagonal/></border>`;
    let i = this.borders.indexOf(x);
    if (i < 0) { i = this.borders.length; this.borders.push(x); }
    return i;
  }
  fmt(code) {
    if (!code) return 0;
    const builtin = { '0': 1, '0.00': 2, '0%': 9, '0.00%': 10 };
    if (builtin[code] != null) return builtin[code];
    if (!this.numFmts.has(code)) this.numFmts.set(code, 164 + this.numFmts.size);
    return this.numFmts.get(code);
  }
  style(spec) {
    const key = JSON.stringify(spec);
    if (this.xfMap.has(key)) return this.xfMap.get(key);
    const fontId = this.font(spec), fillId = this.fill(spec.fill), borderId = this.border(spec.border), numFmtId = this.fmt(spec.fmt);
    const al = spec.align || spec.valign || spec.wrap ? `<alignment${spec.align ? ` horizontal="${spec.align}"` : ''}${spec.valign ? ` vertical="${spec.valign}"` : ''}${spec.wrap ? ' wrapText="1"' : ''}/>` : '';
    const x = `<xf numFmtId="${numFmtId}" fontId="${fontId}" fillId="${fillId}" borderId="${borderId}" xfId="0"${numFmtId ? ' applyNumberFormat="1"' : ''}${fontId ? ' applyFont="1"' : ''}${fillId ? ' applyFill="1"' : ''}${borderId ? ' applyBorder="1"' : ''}${al ? ' applyAlignment="1"' : ''}>${al}</xf>`;
    const i = this.xfs.length;
    this.xfs.push(x);
    this.xfMap.set(key, i);
    return i;
  }
  str(s) {
    s = String(s).slice(0, 32000);
    this.sstRefs = (this.sstRefs || 0) + 1;
    let i = this.sstMap.get(s);
    if (i === undefined) { i = this.sst.length; this.sst.push(s); this.sstMap.set(s, i); }
    return i;
  }
  sheet(name, opts = {}) { const sh = Object.assign({ name: sheetSafe(name), rows: [], heights: {}, merges: [], validations: [] }, opts); this.sheets.push(sh); return sh; }
  sheetXml(sh, idx) {
    let maxCol = 0;
    const rows = sh.rows.map((cells, ri) => {
      const r = ri + 1;
      maxCol = Math.max(maxCol, cells.length);
      const cx = cells.map((c, ci) => {
        if (c == null) return '';
        let v = c, s = 0;
        if (typeof c === 'object') { v = c.v; s = c.s || 0; }
        const ref = colName(ci) + r;
        if (v == null || v === '') return s ? `<c r="${ref}" s="${s}"/>` : '';
        if (typeof v === 'number') return Number.isFinite(v) ? `<c r="${ref}" s="${s}"><v>${v}</v></c>` : '';
        if (typeof v === 'boolean') return `<c r="${ref}" s="${s}" t="b"><v>${v ? 1 : 0}</v></c>`;
        return `<c r="${ref}" s="${s}" t="s"><v>${this.str(v)}</v></c>`;
      }).join('');
      const ht = sh.heights[ri] ? ` ht="${sh.heights[ri]}" customHeight="1"` : '';
      return `<row r="${r}"${ht}>${cx}</row>`;
    }).join('');
    const fz = sh.freeze || {};
    let pane = '';
    if (fz.row || fz.col) {
      const tl = colName(fz.col || 0) + ((fz.row || 0) + 1);
      const ap = fz.row && fz.col ? 'bottomRight' : fz.row ? 'bottomLeft' : 'topRight';
      pane = `<pane${fz.col ? ` xSplit="${fz.col}"` : ''}${fz.row ? ` ySplit="${fz.row}"` : ''} topLeftCell="${tl}" activePane="${ap}" state="frozen"/><selection pane="${ap}" activeCell="${tl}" sqref="${tl}"/>`;
    }
    const views = `<sheetViews><sheetView workbookViewId="0"${idx === 0 ? ' tabSelected="1"' : ''}${sh.zoom ? ` zoomScale="${sh.zoom}"` : ''}>${pane}</sheetView></sheetViews>`;
    const cols = sh.cols ? `<cols>${sh.cols.map((w, i) => `<col min="${i + 1}" max="${i + 1}" width="${w}" customWidth="1"/>`).join('')}</cols>` : '';
    const hr = sh.headerRow || 1;
    const filter = sh.filter && sh.rows.length >= hr ? `<autoFilter ref="A${hr}:${colName(Math.max(0, (sh.filterCols || maxCol) - 1))}${Math.max(hr, sh.rows.length)}"/>` : '';
    const merges = sh.merges.length ? `<mergeCells count="${sh.merges.length}">${sh.merges.map(m => `<mergeCell ref="${m}"/>`).join('')}</mergeCells>` : '';
    const dv = sh.validations.length ? `<dataValidations count="${sh.validations.length}">${sh.validations.map(v => v.list
      ? `<dataValidation type="list" allowBlank="1" showInputMessage="1" showErrorMessage="1" sqref="${v.ref}"><formula1>${xmlEsc('"' + v.list.join(',') + '"')}</formula1></dataValidation>`
      : `<dataValidation type="whole" allowBlank="1" showErrorMessage="1" errorTitle="${xmlEsc(v.title || 'Value')}" error="${xmlEsc(v.error || '')}" sqref="${v.ref}"><formula1>${v.min}</formula1><formula2>${v.max}</formula2></dataValidation>`).join('')}</dataValidations>` : '';
    return `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">${views}<sheetFormatPr defaultRowHeight="15"/>${cols}<sheetData>${rows}</sheetData>${filter}${merges}${dv}<pageMargins left="0.7" right="0.7" top="0.75" bottom="0.75" header="0.3" footer="0.3"/></worksheet>`;
  }
  toBlob(title) {
    const sheetXmls = this.sheets.map((sh, i) => this.sheetXml(sh, i));
    const files = [];
    const n = this.sheets.length;
    files.push({ name: '[Content_Types].xml', data: `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/><Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>${this.sheets.map((_, i) => `<Override PartName="/xl/worksheets/sheet${i + 1}.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>`).join('')}<Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/><Override PartName="/xl/sharedStrings.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sharedStrings+xml"/><Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/><Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/></Types>` });
    files.push({ name: '_rels/.rels', data: `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/><Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/></Relationships>` });
    files.push({ name: 'docProps/core.xml', data: `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><dc:title>${xmlEsc(title)}</dc:title><dc:creator>${xmlEsc(APP_NAME)}</dc:creator><dcterms:created xsi:type="dcterms:W3CDTF">${new Date().toISOString().replace(/\.\d+Z$/, 'Z')}</dcterms:created></cp:coreProperties>` });
    files.push({ name: 'docProps/app.xml', data: `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties"><Application>${xmlEsc(APP_NAME)}</Application></Properties>` });
    const defined = this.sheets.map((sh, i) => (sh.filter ? `<definedName name="_xlnm._FilterDatabase" localSheetId="${i}" hidden="1">'${sh.name.replace(/'/g, "''")}'!$A$${sh.headerRow || 1}:$${colName(Math.max(0, (sh.filterCols || sh.rows.reduce((m, r) => Math.max(m, r.length), 0)) - 1))}$${Math.max(sh.headerRow || 1, sh.rows.length)}</definedName>` : '')).join('');
    files.push({ name: 'xl/workbook.xml', data: `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><bookViews><workbookView xWindow="0" yWindow="0" windowWidth="28800" windowHeight="16000" activeTab="0"/></bookViews><sheets>${this.sheets.map((sh, i) => `<sheet name="${xmlEsc(sh.name)}" sheetId="${i + 1}" r:id="rId${i + 1}"/>`).join('')}</sheets>${defined ? `<definedNames>${defined}</definedNames>` : ''}</workbook>` });
    files.push({ name: 'xl/_rels/workbook.xml.rels', data: `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">${this.sheets.map((_, i) => `<Relationship Id="rId${i + 1}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet${i + 1}.xml"/>`).join('')}<Relationship Id="rId${n + 1}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/><Relationship Id="rId${n + 2}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/sharedStrings" Target="sharedStrings.xml"/></Relationships>` });
    sheetXmls.forEach((x, i) => files.push({ name: `xl/worksheets/sheet${i + 1}.xml`, data: x }));
    const numFmts = this.numFmts.size ? `<numFmts count="${this.numFmts.size}">${[...this.numFmts].map(([code, id]) => `<numFmt numFmtId="${id}" formatCode="${xmlEsc(code)}"/>`).join('')}</numFmts>` : '';
    files.push({ name: 'xl/styles.xml', data: `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">${numFmts}<fonts count="${this.fonts.length}">${this.fonts.join('')}</fonts><fills count="${this.fills.length}">${this.fills.join('')}</fills><borders count="${this.borders.length}">${this.borders.join('')}</borders><cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs><cellXfs count="${this.xfs.length}">${this.xfs.join('')}</cellXfs><cellStyles count="1"><cellStyle name="Normal" xfId="0" builtinId="0"/></cellStyles></styleSheet>` });
    files.push({ name: 'xl/sharedStrings.xml', data: `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n<sst xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" count="${this.sstRefs || 0}" uniqueCount="${this.sst.length}">${this.sst.map(s => `<si><t xml:space="preserve">${xmlEsc(s)}</t></si>`).join('')}</sst>` });
    return zipStore(files);
  }
}

// ===================================================================
// Export: everything in one workbook
// ===================================================================
const XL = { ink: 'FF0E222A', muted: 'FF5B6E76', head: 'FF0B5574', line: 'FFB2C1C6', white: 'FFFFFFFF', heat: ['FFEBF5FA', 'FFC7E3F0', 'FF92C7DF', 'FF4F9CC2', 'FF136B94'], over: 'FFCF432C', off: 'FFDFE4E6', lvl: ['', 'FF78B4D1', 'FF4593B9', 'FF1A7199', 'FF075172'], crit: 'FFC53829', soft: 'FFDBEFF9', band: 'FFF2F6F7',
  kind: { home: 'FF136B94', outcome: 'FF139267', network: 'FFA24FC9' }, kink: { home: 'FFFFFFFF', outcome: 'FF06161C', network: 'FFFFFFFF' } };
// Average FTE of one booking over a date range (only days the person is available).
function bookingFte(a, p, from, to) {
  const X = ix();
  let n = 0;
  const s = Math.max(from, a.s), e = Math.min(to, a.ce);
  for (let d = s; d <= e; d += DAY) if (dow(d) < 5 && employed(p, d) && !offOn(p, d, X)) n++;
  return n ? a.alloc / 100 * n / (workdays(from, to) || 1) : 0;
}
function buildWorkbook() {
  const X = ix();
  const wb = new Workbook();
  const st = s => wb.style(s);
  const H = st({ bold: true, color: XL.white, fill: XL.head, border: XL.head, valign: 'center', wrap: true });
  const HC = st({ bold: true, color: XL.white, fill: XL.head, border: XL.head, valign: 'center', align: 'center', wrap: true });
  const DATE = st({ fmt: 'd mmm yyyy', align: 'left' });
  const PCT = st({ fmt: '0%' });
  const PCTB = st({ fmt: '0%', bold: true });
  const PP = st({ fmt: '+0" pp";"−"0" pp";"±0 pp"' });
  const INT = st({ fmt: '0' });
  const DEC = st({ fmt: '0.0' });
  const DECB = st({ fmt: '0.0', bold: true });
  const DEC2 = st({ fmt: '0.00' });
  const TITLE = st({ bold: true, size: 16, color: XL.ink });
  const NOTE = st({ italic: true, color: XL.muted });
  const SECTION = st({ bold: true, size: 12, color: XL.head });
  const BOLD = st({ bold: true });
  const AREA_S = st({ bold: true, fill: XL.band, border: XL.line });
  const AREA_N = st({ bold: true, fill: XL.band, border: XL.line, fmt: '0.0' });
  const AREA_P = st({ bold: true, fill: XL.band, border: XL.line, fmt: '0%' });
  const AREA_PP = st({ bold: true, fill: XL.band, border: XL.line, fmt: '+0" pp";"−"0" pp";"±0 pp"' });
  const INDENT = st({ color: XL.ink });
  const WRAP = st({ wrap: true, valign: 'top' });
  const KS = Object.fromEntries(KINDS.map(k => [k.id, st({ bold: true, fill: XL.kind[k.id], color: XL.kink[k.id] })]));
  const heatS = XL.heat.map((c, i) => st({ fmt: '0%', fill: c, align: 'center', color: i === 4 ? XL.white : XL.ink, bold: i === 4 }));
  const overS = st({ fmt: '0%', fill: XL.over, align: 'center', color: XL.white, bold: true });
  const offS = st({ fill: XL.off, align: 'center', color: XL.muted, italic: true });
  const freeS = st({ fmt: '0%', align: 'center' });
  const freeNeg = st({ fmt: '0%', align: 'center', color: XL.crit, bold: true });
  const lvlS = XL.lvl.map((c, i) => (i ? st({ fill: c, align: 'center', bold: true, color: i >= 3 ? XL.white : XL.ink }) : st({ align: 'center', color: XL.muted })));
  const D = v => (v == null || v >= OPEN_END ? '' : { v: xlDate(v), s: DATE });
  const V = (v, s) => ({ v: Math.round(v * 1000) / 1000, s });
  const now = new Date();
  const stamp = `${fd(todayMs())}, ${String(now.getHours()).padStart(2, '0')}:${String(now.getMinutes()).padStart(2, '0')}`;
  const W4 = weeksFrom(X.W0, 4), W26 = weeksFrom(X.W0, 26);
  const PM = [periodById('m-1'), periodById('m0'), periodById('m1')];
  const AM = PM.map(p => allocCalc(p.from, p.to, X.people, '|'));
  const cur = AM[1], dashCur = dashData('m0', '', '');

  // ---------- Summary ----------
  const sum = wb.sheet('Summary', { cols: [44, 13, 11, 13, 11, 13, 11, 12] });
  sum.rows.push([{ v: APP_NAME, s: TITLE }]);
  sum.heights[0] = 24;
  sum.rows.push([{ v: `Exported ${stamp}. Capacity is measured in FTE: averages over the working days of each month, after time off and public holidays.`, s: NOTE }]);
  sum.rows.push([]);
  sum.rows.push([{ v: `Key figures, ${PM[1].name}`, s: H }, { v: 'Value', s: H }]);
  const kv = [
    ['People', X.people.length, INT], ['Contract FTE', X.people.reduce((s, p) => s + p.fte / 100, 0), DEC],
    ['Available FTE (after time off)', cur.tot.cap, DEC], ['Booked FTE', cur.tot.booked, DEC], ['Utilization (booked ÷ available)', cur.tot.util, PCT],
    ['Free capacity (FTE)', cur.tot.free, DEC], ['People over-allocated in at least one week', dashCur.per.filter(r => r.overW.length).length, INT],
    ['Open roles', dashCur.open.length, INT], ['Open role FTE', dashCur.openFte, DEC],
    ['Active and planned Outcome Teams', X.projects.filter(p => p.kind === 'outcome' && COUNTS.has(p.status)).length, INT],
    ['Active Franchise Networks', X.projects.filter(p => p.kind === 'network' && COUNTS.has(p.status)).length, INT],
  ];
  for (const [k, v, s] of kv) sum.rows.push([k, v == null ? '' : { v, s }]);
  sum.rows.push([]);
  sum.rows.push([{ v: 'Impact@Scale allocation (FTE and share of available capacity)', s: SECTION }]);
  sum.rows.push(['Type', ...PM.flatMap(p => [p.short + ' FTE', 'Share']), 'Change'].map((v, i) => ({ v, s: i ? HC : H })));
  const shareOf = (A, k) => { const base = A.tot.booked + A.tot.free; const v = k === 'free' ? A.tot.free : A.tot[k]; return [v, base ? v / base : 0]; };
  for (const k of [...KINDS.map(x => x.id), 'free']) {
    const vals = AM.map(A => shareOf(A, k));
    sum.rows.push([k === 'free' ? { v: 'Unallocated', s: BOLD } : { v: KIND[k].plural, s: KS[k] }, ...vals.flatMap(([v, sh]) => [V(v, DEC), V(sh, PCT)]), { v: Math.round((vals[2][1] - vals[0][1]) * 100), s: PP }]);
  }
  sum.rows.push(['Available capacity', ...AM.flatMap(A => [V(A.tot.cap, DECB), ''])]);
  sum.rows.push([{ v: `Change = share next month minus share last month, in percentage points.`, s: NOTE }]);
  sum.rows.push([]);
  sum.rows.push([{ v: `Utilization by team, ${PM[1].name}`, s: SECTION }]);
  sum.rows.push(['Team', 'People', 'Available FTE', 'Booked FTE', 'Utilization', 'Free FTE'].map(v => ({ v, s: H })));
  for (const r of dashCur.groupRows) sum.rows.push([r.team || 'No team', { v: r.n, s: INT }, V(r.cap, DEC), V(r.booked, DEC), r.util == null ? '' : { v: r.util, s: PCT }, V(r.free, DEC)]);
  sum.rows.push([]);
  sum.rows.push([{ v: 'How to read this file', s: SECTION }]);
  for (const line of [
    'All capacity is in FTE. 1 FTE = one full-time person for the whole period; 50% = half of one full-time person.',
    'Allocation % on a booking is a share of one full-time person (% FTE). A 60% FTE person booked at 30% has 30% FTE left.',
    'Monthly figures are averages over the month’s working days (Monday to Friday) after time off and public holidays.',
    'Time on paused (On hold) or Completed activities counts only up to the day before the export.',
    'Sheets: Impact@Scale by person, Capability focus, Focus by person and Allocation data follow the PPWS resource allocation paper.',
    'To re-import, edit the People, Skills, Skills matrix, Activities, Bookings and Time off sheets and keep their ID columns.',
  ]) sum.rows.push([{ v: line, s: NOTE }]);

  // ---------- People ----------
  const pe = wb.sheet('People', { cols: [14, 24, 28, 34, 26, 9, 12, 14, 30, 13, 13, 13, 13, 40, 30], freeze: { row: 1, col: 2 }, filter: true });
  pe.rows.push(['ID', 'Name', 'Role', 'Capability Home', 'Team', 'FTE %', 'Type', 'Location', 'Email', 'Start date', 'End date', 'Utilization next 4 weeks', 'Free % FTE next 4 weeks', 'Current activities', 'Notes'].map(v => ({ v, s: H })));
  pe.heights[0] = 30;
  for (const p of X.people) {
    const s4 = summarize([p], W4);
    const projs = [...new Set((X.countByPerson.get(p.id) || []).filter(a => a.live && a.e >= X.T && a.s <= X.T + 28 * DAY).map(a => a.project.name))].join(', ');
    pe.rows.push([p.id, p.name, p.role, homeName(p.home), p.team, { v: p.fte, s: INT }, p.type, p.location, p.email, D(p.start), D(p.end), s4.util == null ? '' : { v: s4.util, s: PCT }, V(s4.free, PCT), projs, p.notes]);
  }
  pe.validations.push({ ref: 'G2:G2000', list: PTYPES }, { ref: 'F2:F2000', min: 5, max: 100, title: 'FTE %', error: 'Use a whole percentage from 5 to 100.' });

  // ---------- Skills matrix ----------
  const sk = X.skills;
  const mx = wb.sheet('Skills matrix', { cols: [14, 24, 22, ...sk.map(() => 9)], freeze: { row: 1, col: 3 }, filter: true });
  mx.rows.push(['ID', 'Name', 'Team', ...sk.map(s => s.name)].map((v, i) => ({ v, s: i < 3 ? H : HC })));
  mx.heights[0] = 66;
  for (const p of X.people) mx.rows.push([p.id, p.name, p.team, ...sk.map(s => { const l = p.skills[s.id] || 0; return l ? { v: l, s: lvlS[l] } : ''; })]);
  if (sk.length) mx.validations.push({ ref: `D2:${colName(2 + sk.length)}2000`, min: 0, max: 4, title: 'Skill level', error: 'Use 0 (none) to 4 (Expert).' });

  // ---------- Skills ----------
  const sks = wb.sheet('Skills', { cols: [14, 34, 26, 11, 9, 10, 11, 9, 13], freeze: { row: 1, col: 0 }, filter: true });
  sks.rows.push(['ID', 'Skill', 'Category', 'Critical', 'Basic', 'Working', 'Advanced', 'Expert', 'Advanced or expert'].map(v => ({ v, s: H })));
  sks.heights[0] = 30;
  for (const s of sk) { const c = coverage(s.id); sks.rows.push([s.id, s.name, s.cat, s.critical ? 'Yes' : 'No', { v: c.by[1], s: INT }, { v: c.by[2], s: INT }, { v: c.by[3], s: INT }, { v: c.by[4], s: INT }, { v: c.adv, s: INT }]); }
  sks.validations.push({ ref: 'D2:D2000', list: ['Yes', 'No'] });

  // ---------- Activities ----------
  const pj = wb.sheet('Activities', { cols: [14, 34, 18, 34, 40, 11, 10, 22, 22, 14, 13, 13, 46, 40, 40, 13, 13, 40, 9, 9, 11, 11, 14, 12], freeze: { row: 1, col: 2 }, filter: true });
  pj.rows.push(['ID', 'Name', 'Type', 'Focus area', 'Focus sub-category', 'Status', 'Priority', 'Lead', 'Sponsor', 'Code', 'Start date', 'End date', 'Intended result or purpose', 'Why an Outcome rather than BAU', 'Capacity released', 'Review date', 'Forum decision', 'Notes', 'People booked', 'Open roles', 'Staffed FTE', 'Open FTE', 'Lead ID', 'Focus ID'].map(v => ({ v, s: H })));
  pj.heights[0] = 30;
  for (const p of X.projects) {
    const s = staffing(p);
    const lead = X.P.get(p.leadId);
    const sb = SUB.get(p.focus);
    pj.rows.push([p.id, p.name, { v: KIND[p.kind].label, s: KS[p.kind] }, sb ? areaLabel(sb.area) : '', sb ? sb.name : '', p.status, p.priority, lead ? lead.name : '', p.sponsor, p.code, D(p.start), D(p.end), { v: p.purpose, s: WRAP }, { v: p.why, s: WRAP }, { v: p.deprio, s: WRAP }, D(p.review), p.decision, { v: p.description, s: WRAP },
      { v: new Set((X.byProject.get(p.id) || []).filter(a => a.personId).map(a => a.personId)).size, s: INT }, { v: s.open.length, s: INT }, V(s.filled, DEC), V(s.total - s.filled, DEC), lead ? lead.id : '', p.focus]);
  }
  pj.validations.push({ ref: 'C2:C2000', list: KINDS.map(k => k.label) }, { ref: 'F2:F2000', list: STATUSES }, { ref: 'G2:G2000', list: PRIORITIES }, { ref: 'Q2:Q2000', list: DECISIONS });

  // ---------- Bookings ----------
  const bk = wb.sheet('Bookings', { cols: [14, 32, 18, 22, 28, 12, 13, 13, 12, 34, 40, 40, 24, 9, 14, 14], freeze: { row: 1, col: 0 }, filter: true });
  bk.rows.push(['ID', 'Activity', 'Type', 'Person', 'Role', 'Allocation % FTE', 'Start date', 'End date', 'Booking', 'Focus area', 'Focus sub-category', 'Focus override', 'Skill', 'Min level', 'Activity ID', 'Person ID'].map(v => ({ v, s: H })));
  bk.heights[0] = 30;
  const asgSorted = X.asg.slice().sort((a, b) => KORDER[a.project.kind] - KORDER[b.project.kind] || a.project.name.localeCompare(b.project.name) || (a.s ?? 0) - (b.s ?? 0));
  for (const a of asgSorted) {
    const p = a.personId ? X.P.get(a.personId) : null;
    const s = a.skillId ? X.K.get(a.skillId) : null;
    const sb = SUB.get(a.focus);
    bk.rows.push([a.id, a.project.name, KIND[a.project.kind].label, p ? p.name : 'Open role', a.role, { v: a.alloc, s: INT }, D(a.s), a.noEnd ? '' : D(a.e), a.booking, sb ? areaLabel(sb.area) : '', sb ? sb.name : '', SUB.has(a.ownFocus) ? SUB.get(a.ownFocus).name : '', s ? s.name : '', a.minLevel ? { v: a.minLevel, s: INT } : '', a.projectId, a.personId]);
  }
  bk.validations.push({ ref: 'I2:I5000', list: BOOKINGS }, { ref: 'F2:F5000', min: 1, max: 100, title: 'Allocation', error: 'Use a whole percentage of one FTE, from 1 to 100.' });

  // ---------- Time off ----------
  const to = wb.sheet('Time off', { cols: [14, 24, 16, 13, 13, 13, 34, 14], freeze: { row: 1, col: 0 }, filter: true });
  to.rows.push(['ID', 'Person', 'Type', 'Start date', 'End date', 'Working days', 'Note', 'Person ID'].map(v => ({ v, s: H })));
  to.heights[0] = 30;
  for (const t of X.offs) {
    const p = t.personId === ALL ? null : X.P.get(t.personId);
    to.rows.push([t.id, p ? p.name : 'Everyone', t.type, D(t.s), D(t.e), { v: workdays(t.s, t.e), s: INT }, t.note, t.personId]);
  }
  to.validations.push({ ref: 'C2:C5000', list: OFFTYPES });

  // ---------- Impact@Scale by person ----------
  const ip = wb.sheet('Impact@Scale by person', { cols: [24, 30, 24, ...PM.flatMap(() => [10, 10, 10, 10, 11])], freeze: { row: 2, col: 1 } });
  ip.rows.push([{ v: '', s: H }, { v: '', s: H }, { v: '', s: H }, ...PM.flatMap(p => [{ v: p.name, s: HC }, { v: '', s: HC }, { v: '', s: HC }, { v: '', s: HC }, { v: '', s: HC }])]);
  PM.forEach((p, i) => ip.merges.push(`${colName(3 + i * 5)}1:${colName(7 + i * 5)}1`));
  ip.rows.push(['Person', 'Capability Home', 'Team', ...PM.flatMap(() => ['Available', 'Capability Homes', 'Outcome Teams', 'Franchise Networks', 'Unallocated'])].map((v, i) => ({ v, s: i < 3 ? H : HC })));
  ip.heights[1] = 32;
  for (const p of X.people) {
    ip.rows.push([p.name, homeName(p.home), p.team, ...AM.flatMap(A => { const r = A.per.get(p.id); return r ? [V(r.cap, PCTB), V(r.home, PCT), V(r.outcome, PCT), V(r.network, PCT), V(r.over > 0.005 ? -r.over : r.free, r.over > 0.005 ? freeNeg : PCT)] : ['', '', '', '', '']; })]);
  }
  ip.rows.push([{ v: 'Team total (FTE)', s: BOLD }, '', '', ...AM.flatMap(A => [V(A.tot.cap, DECB), V(A.tot.home, DEC), V(A.tot.outcome, DEC), V(A.tot.network, DEC), V(A.tot.free, DEC)])]);
  ip.rows.push([]);
  ip.rows.push([{ v: 'Person rows are shares of one full-time person (% FTE), averaged over the month. They add up to the person’s available FTE. Negative unallocated (red) means booked beyond availability.', s: NOTE }]);

  // ---------- Capability focus ----------
  const cf = wb.sheet('Capability focus', { cols: [62, ...PM.flatMap(() => [10, 10]), 12], freeze: { row: 2, col: 1 } });
  cf.rows.push([{ v: '', s: H }, ...PM.flatMap(p => [{ v: p.name, s: HC }, { v: '', s: HC }]), { v: '', s: HC }]);
  PM.forEach((p, i) => cf.merges.push(`${colName(1 + i * 2)}1:${colName(2 + i * 2)}1`));
  cf.rows.push(['Capability Home / activity sub-category', ...PM.flatMap(() => ['FTE', 'Share']), 'Change'].map((v, i) => ({ v, s: i ? HC : H })));
  const booked = AM.map(A => A.tot.booked);
  const line = (label, ids, sA, sN, sP, indent) => {
    const vals = AM.map(A => subValue(A.subs, ids));
    const sh = vals.map((v, i) => (booked[i] > 0 ? v / booked[i] : 0));
    cf.rows.push([{ v: (indent ? '    ' : '') + label, s: sA }, ...vals.flatMap((v, i) => [V(v, sN), V(sh[i], sP)]), { v: Math.round((sh[2] - sh[0]) * 100), s: indent ? PP : AREA_PP }]);
  };
  for (const a of FOCUS) {
    line(areaLabel(a), areaSubIds(a), AREA_S, AREA_N, AREA_P, false);
    if (!(a.subs.length === 1 && a.subs[0].solo)) for (const s of a.subs) line(s.name, [s.id], INDENT, DEC, PCT, true);
  }
  if (AM.some(A => subValue(A.subs, ['']) > 0.004)) line('Focus not set', [''], AREA_S, AREA_N, AREA_P, false);
  cf.rows.push([{ v: 'Total booked', s: BOLD }, ...booked.flatMap(v => [V(v, DECB), { v: 1, s: PCTB }])]);
  cf.rows.push([]);
  cf.rows.push([{ v: 'Share = part of all booked time that month. Change = share next month minus share last month, in percentage points. Mirrors the Capability Home focus table of the allocation paper.', s: NOTE }]);

  // ---------- Focus by person (this month) ----------
  const subs = [...SUB.values()];
  const fp = wb.sheet('Focus by person', { cols: [24, 24, 10, ...subs.map(() => 12)], freeze: { row: 1, col: 1 }, filter: true });
  fp.rows.push(['Person', 'Team', 'Booked', ...subs.map(s => `${s.area.n} · ${s.name}`)].map((v, i) => ({ v, s: i < 2 ? H : HC })));
  fp.heights[0] = 96;
  for (const p of X.people) {
    const r = cur.per.get(p.id);
    if (!r) continue;
    fp.rows.push([p.name, p.team, V(r.booked, PCTB), ...subs.map(s => { const v = subValue(r.subs, [s.id]); return v > 0.004 ? V(v, PCT) : ''; })]);
  }
  fp.rows.push([]);
  fp.rows.push([{ v: `${PM[1].name}: share of one FTE each person spends on each activity sub-category, averaged over the month.`, s: NOTE }]);

  // ---------- Allocation data (long table for pivots) ----------
  const ad = wb.sheet('Allocation data', { cols: [12, 24, 30, 24, 34, 18, 34, 46, 12, 12, 14], freeze: { row: 1, col: 0 }, filter: true });
  ad.rows.push(['Month', 'Person', 'Capability Home', 'Team', 'Activity', 'Type', 'Focus area', 'Focus sub-category', 'Booking', 'FTE', 'Person ID'].map(v => ({ v, s: H })));
  ad.heights[0] = 30;
  const t0 = new Date(X.T);
  for (let k = -3; k <= 6; k++) {
    const from = mStart(t0.getUTCFullYear(), t0.getUTCMonth() + k), to2 = mEnd(t0.getUTCFullYear(), t0.getUTCMonth() + k);
    for (const p of X.people) {
      for (const a of (X.countByPerson.get(p.id) || [])) {
        if (a.ce < from || a.s > to2) continue;
        const v = bookingFte(a, p, from, to2);
        if (v < 0.0005) continue;
        const sb = SUB.get(a.focus);
        ad.rows.push([{ v: xlDate(from), s: st({ fmt: 'mmm yyyy', align: 'left' }) }, p.name, homeName(p.home), p.team, a.project.name, KIND[a.project.kind].label, sb ? areaLabel(sb.area) : 'Focus not set', sb ? sb.name : '', a.booking, V(v, DEC2), p.id]);
      }
    }
  }
  ad.rows.push([]);
  ad.rows.push([{ v: 'One row per person, booking and month: average FTE over the month’s working days. Build pivot tables from this sheet.', s: NOTE }]);

  // ---------- Availability & free FTE, 26 weeks ----------
  const heads = ['Name', 'Team', 'FTE %', ...W26.map(wk => `${wkCode(wk)} ${fd(wk, false)}`)];
  const av = wb.sheet('Availability', { cols: [24, 22, 8, ...W26.map(() => 10)], freeze: { row: 1, col: 3 } });
  const fr = wb.sheet('Free FTE', { cols: [24, 22, 8, ...W26.map(() => 10)], freeze: { row: 1, col: 3 } });
  av.rows.push(heads.map((v, i) => ({ v, s: i < 3 ? H : HC })));
  fr.rows.push(heads.map((v, i) => ({ v, s: i < 3 ? H : HC })));
  av.heights[0] = 32; fr.heights[0] = 32;
  for (const p of X.people) {
    const ra = [p.name, p.team, { v: p.fte, s: INT }], rf = [p.name, p.team, { v: p.fte, s: INT }];
    for (const wk of W26) {
      const r = week(p, wk);
      if (r.work === 0) { ra.push(''); rf.push(''); continue; }
      if (r.avail === 0) { ra.push({ v: 'Off', s: offS }); rf.push({ v: 'Off', s: offS }); continue; }
      ra.push({ v: Math.round(r.util * 1000) / 1000, s: r.util > 1.005 ? overS : heatS[bin(r.util)] });
      rf.push({ v: Math.round(r.free * 1000) / 1000, s: r.free < -0.0005 ? freeNeg : freeS });
    }
    av.rows.push(ra); fr.rows.push(rf);
  }
  av.rows.push([]);
  av.rows.push([{ v: 'Share of available FTE booked each week (after time off). Red cells are above 100%.', s: NOTE }]);
  fr.rows.push([]);
  fr.rows.push([{ v: 'Share of one full-time person still free each week. Negative values (red) mean the person is booked beyond what they have available.', s: NOTE }]);
  return wb.toBlob(APP_NAME + ' export');
}


async function saveFile(name, blob) {
  const C = window.claude;
  let dl = null;
  if (C && typeof C.use === 'function') { try { dl = await C.use('downloads'); } catch (e) { dl = null; } }
  if (dl) {
    try {
      const res = await dl.save({ filename: name, data: blob });
      toast(res && res.status === 'delivered' ? 'Workbook sent.' : `Saved ${name}`);
    } catch (e) {
      const code = e && e.code;
      if (code === 'declined') toast('Download cancelled.');
      else if (code === 'rate_limited') toast('A download is already waiting for your confirmation.');
      else toast('Downloads aren’t available in this view.');
    }
    return;
  }
  let top = false;
  try { top = window.top === window.self; } catch (e) { top = false; }
  if (top) {
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url; a.download = name;
    document.body.appendChild(a); a.click(); a.remove();
    setTimeout(() => URL.revokeObjectURL(url), 5000);
    toast(`Downloaded ${name}`);
    return;
  }
  toast('Downloads aren’t available in this view.');
}
async function exportExcel() {
  if (!app.ready) { toast('The planner is still loading. Try again in a moment.'); return; }
  let blob;
  try { blob = buildWorkbook(); } catch (e) { console.error(e); toast('The workbook couldn’t be built. Please try again.'); return; }
  await saveFile(`Impact-at-Scale-planner_${iso(todayMs())}.xlsx`, blob);
}

// ===================================================================
// XLSX reader (import)
// ===================================================================
async function inflateRaw(u8) {
  if (typeof DecompressionStream !== 'function') throw new Error('This browser can’t read compressed workbooks.');
  const stream = new Blob([u8]).stream().pipeThrough(new DecompressionStream('deflate-raw'));
  return new Uint8Array(await new Response(stream).arrayBuffer());
}
function unzip(buf) {
  const u8 = new Uint8Array(buf);
  const dv = new DataView(buf);
  let eocd = -1;
  for (let i = u8.length - 22; i >= Math.max(0, u8.length - 22 - 65535); i--) if (dv.getUint32(i, true) === 0x06054b50) { eocd = i; break; }
  if (eocd < 0) throw new Error('This file isn’t an Excel workbook (.xlsx).');
  const count = dv.getUint16(eocd + 10, true);
  let p = dv.getUint32(eocd + 16, true);
  const dec = new TextDecoder();
  const entries = new Map();
  for (let k = 0; k < count; k++) {
    if (dv.getUint32(p, true) !== 0x02014b50) throw new Error('The workbook looks damaged.');
    const method = dv.getUint16(p + 10, true), csize = dv.getUint32(p + 20, true);
    const nlen = dv.getUint16(p + 28, true), xlen = dv.getUint16(p + 30, true), clen = dv.getUint16(p + 32, true);
    const lho = dv.getUint32(p + 42, true);
    const name = dec.decode(u8.subarray(p + 46, p + 46 + nlen));
    p += 46 + nlen + xlen + clen;
    const start = lho + 30 + dv.getUint16(lho + 26, true) + dv.getUint16(lho + 28, true);
    entries.set(name, { method, raw: u8.subarray(start, start + csize) });
  }
  return {
    has: n => entries.has(n),
    async text(n) {
      const e = entries.get(n);
      if (!e) return null;
      const data = e.method === 0 ? e.raw : e.method === 8 ? await inflateRaw(e.raw) : null;
      if (!data) throw new Error('The workbook uses a compression this page can’t read.');
      return dec.decode(data);
    },
  };
}
function parseXml(text) {
  const doc = new DOMParser().parseFromString(text, 'application/xml');
  if (doc.getElementsByTagName('parsererror').length) throw new Error('Part of the workbook couldn’t be read.');
  return doc;
}
const byTag = (node, tag) => Array.from(node.getElementsByTagNameNS('*', tag));
const colIndex = ref => { let n = 0; for (const ch of ref) { const c = ch.charCodeAt(0); if (c >= 65 && c <= 90) n = n * 26 + (c - 64); else if (c >= 97 && c <= 122) n = n * 26 + (c - 96); else break; } return n - 1; };
async function readXlsx(buf) {
  const z = unzip(buf);
  const wbText = await z.text('xl/workbook.xml');
  if (!wbText) throw new Error('This file isn’t an Excel workbook (.xlsx).');
  const wb = parseXml(wbText);
  const relsText = await z.text('xl/_rels/workbook.xml.rels');
  const rels = new Map();
  if (relsText) for (const r of byTag(parseXml(relsText), 'Relationship')) rels.set(r.getAttribute('Id'), r.getAttribute('Target'));
  const sst = [];
  const sstText = await z.text('xl/sharedStrings.xml');
  if (sstText) {
    for (const si of byTag(parseXml(sstText), 'si')) {
      let s = '';
      for (const t of byTag(si, 't')) if (!(t.parentNode && t.parentNode.localName === 'rPh')) s += t.textContent;
      sst.push(s);
    }
  }
  const sheets = [];
  for (const sh of byTag(wb, 'sheet')) {
    const name = sh.getAttribute('name') || '';
    const rid = sh.getAttributeNS('http://schemas.openxmlformats.org/officeDocument/2006/relationships', 'id') || sh.getAttribute('r:id');
    let target = rels.get(rid);
    if (!target) continue;
    target = target.startsWith('/') ? target.slice(1) : 'xl/' + target.replace(/^\.\//, '');
    const text = await z.text(target);
    if (!text) continue;
    const doc = parseXml(text);
    const rows = [];
    for (const row of byTag(doc, 'row')) {
      const rn = parseInt(row.getAttribute('r'), 10);
      const ri = Number.isFinite(rn) ? rn - 1 : rows.length;
      const arr = rows[ri] || (rows[ri] = []);
      let ci = 0;
      for (const c of Array.from(row.children)) {
        if (c.localName !== 'c') continue;
        const ref = c.getAttribute('r');
        if (ref) ci = colIndex(ref);
        const t = c.getAttribute('t');
        const vEl = Array.from(c.children).find(x => x.localName === 'v');
        const v = vEl ? vEl.textContent : null;
        let val = '';
        if (t === 's') val = v != null ? (sst[Number(v)] ?? '') : '';
        else if (t === 'inlineStr') { const is = Array.from(c.children).find(x => x.localName === 'is'); val = is ? byTag(is, 't').map(x => x.textContent).join('') : ''; }
        else if (t === 'b') val = v === '1';
        else if (t === 'str' || t === 'e' || t === 'd') val = v ?? '';
        else val = v != null && v !== '' ? Number(v) : '';
        arr[ci] = val;
        ci++;
      }
    }
    for (let i = 0; i < rows.length; i++) { const r = rows[i] || []; for (let j = 0; j < r.length; j++) if (r[j] === undefined) r[j] = ''; rows[i] = r; }
    sheets.push({ name, rows });
  }
  return sheets;
}

// ---------- mapping workbook rows to planner records ----------
const normKey = s => String(s ?? '').toLowerCase().replace(/[^a-z0-9]/g, '');
const SYN = {
  people: { id: ['id', 'personid'], name: ['name', 'fullname', 'person'], role: ['role', 'title', 'jobtitle', 'position'], home: ['capabilityhome', 'home', 'homearea'], team: ['team', 'department', 'group'], location: ['location', 'office', 'site'], email: ['email', 'emailaddress', 'mail'], type: ['type', 'employmenttype', 'contracttype'], fte: ['fte', 'ftepercent', 'ftepct', 'contractfte', 'workingtime'], hours: ['hoursweek', 'hoursperweek', 'weeklyhours', 'hours'], start: ['startdate', 'start'], end: ['enddate', 'end', 'contractend'], notes: ['notes', 'note', 'comments'] },
  skills: { id: ['id', 'skillid'], name: ['skill', 'name', 'skillname'], category: ['category', 'area', 'group'], critical: ['critical', 'businesscritical'] },
  projects: { id: ['id', 'projectid', 'activityid'], code: ['code', 'projectcode'], name: ['name', 'activity', 'activityname', 'project', 'projectname', 'outcome', 'outcomename'], kind: ['type', 'activitytype', 'impactscaletype', 'impactatscaletype', 'element'], area: ['focusarea', 'area'], focus: ['focussubcategory', 'subcategory', 'activitysubcategory', 'focus', 'typeofwork'], focusId: ['focusid'], sponsor: ['sponsor', 'businessunit', 'client', 'owner'], status: ['status'], priority: ['priority'], lead: ['lead', 'outcomelead', 'steward', 'teamlead', 'projectlead', 'projectmanager', 'manager'], leadId: ['leadid'], start: ['startdate', 'start'], end: ['enddate', 'end', 'targetenddate'], purpose: ['intendedresultorpurpose', 'intendedresult', 'purpose', 'result'], why: ['whyanoutcomeratherthanbau', 'whyanoutcome', 'why'], deprio: ['capacityreleased', 'deprioritized', 'deprioritised', 'pausedordeprioritized'], review: ['reviewdate', 'forumreviewdate', 'review'], decision: ['forumdecision', 'lastforumdecision', 'decision'], description: ['notes', 'description', 'summary'] },
  bookings: { id: ['id', 'bookingid', 'roleid'], projectId: ['activityid', 'projectid'], project: ['activity', 'activityname', 'project', 'projectname'], personId: ['personid'], person: ['person', 'name', 'assignee', 'resource'], role: ['role', 'roletitle', 'title'], skill: ['skill', 'mainskill'], minLevel: ['minlevel', 'minimumlevel', 'requiredlevel'], allocation: ['allocationfte', 'allocation', 'allocationpercent', 'percent', 'load'], focus: ['focussubcategory', 'subcategory', 'focus', 'typeofwork'], focusOverride: ['focusoverride'], start: ['startdate', 'start'], end: ['enddate', 'end'], booking: ['booking', 'bookingtype'] },
  timeoff: { id: ['id'], personId: ['personid'], person: ['person', 'name', 'who'], type: ['type', 'reason'], start: ['startdate', 'start', 'firstday', 'from'], end: ['enddate', 'end', 'lastday', 'to'], note: ['note', 'notes', 'comment'] },
};
function tableOf(sheet, syn, key) {
  if (!sheet) return null;
  for (let r = 0; r < Math.min(10, sheet.rows.length); r++) {
    const head = (sheet.rows[r] || []).map(normKey);
    if (!syn[key].some(k => head.includes(k))) continue;
    const idx = {};
    for (const [f, names] of Object.entries(syn)) { const i = head.findIndex(h => names.includes(h)); if (i >= 0) idx[f] = i; }
    const rows = [];
    for (let i = r + 1; i < sheet.rows.length; i++) { const row = sheet.rows[i] || []; if (row.some(v => v !== '' && v != null)) rows.push({ n: i + 1, get: f => (idx[f] == null ? '' : row[idx[f]]) }); }
    return { head, headerRow: r, rows, sheet };
  }
  return null;
}
function toISO(v) {
  if (v == null || v === '') return '';
  if (typeof v === 'number' && Number.isFinite(v)) return v > 20000 && v < 80000 ? iso(Date.UTC(1899, 11, 30) + Math.round(v) * DAY) : '';
  const s = String(v).trim();
  let m = /^(\d{4})-(\d{1,2})-(\d{1,2})/.exec(s);
  if (m) return iso(Date.UTC(+m[1], +m[2] - 1, +m[3]));
  m = /^(\d{1,2})[./-](\d{1,2})[./-](\d{2,4})$/.exec(s);
  if (m) { let y = +m[3]; if (y < 100) y += 2000; return iso(Date.UTC(y, +m[2] - 1, +m[1])); }
  m = /^(\d{1,2})\s+([A-Za-z]{3})[A-Za-z]*\.?,?\s+(\d{4})$/.exec(s);
  if (m) { const mi = MON.findIndex(x => x.toLowerCase() === m[2].toLowerCase()); if (mi >= 0) return iso(Date.UTC(+m[3], mi, +m[1])); }
  return '';
}
const toNum = v => { if (v === '' || v == null) return null; const n = typeof v === 'number' ? v : parseFloat(String(v).replace('%', '').replace(',', '.')); return Number.isFinite(n) ? n : null; };
const toBool = v => v === true || /^(yes|y|true|1|x|critical)$/i.test(str(v));
function toLevel(v) {
  if (v === '' || v == null) return 0;
  const n = toNum(v);
  if (n != null) return clamp(Math.round(n), 0, 4);
  const i = LEVELS.findIndex(l => l.toLowerCase() === str(v).toLowerCase());
  return i < 0 ? 0 : i;
}
const pickOne = (v, list, dflt) => { const s = str(v).toLowerCase(); return list.find(x => x.toLowerCase() === s) || dflt; };

// ---------- reading Impact@Scale values ----------
const stripNum = v => str(v).replace(/^\d+\s*[·.\-–:)]\s*/, '');
const SUB_KEYS = new Map();
for (const s of SUB.values()) { SUB_KEYS.set(normKey(s.id), s.id); if (!SUB_KEYS.has(normKey(s.name))) SUB_KEYS.set(normKey(s.name), s.id); }
function toFocus(v, areaV) {
  const raw = stripNum(v);
  let id = raw ? SUB_KEYS.get(normKey(raw)) || '' : '';
  if (!id && raw) { const k = normKey(raw); for (const s of SUB.values()) if (k.length > 8 && normKey(s.name).startsWith(k)) { id = s.id; break; } }
  if (!id && str(areaV)) {
    const ak = normKey(stripNum(areaV));
    const a = FOCUS.find(x => normKey(x.name) === ak || x.id === str(areaV));
    if (a && a.subs.length === 1) id = a.subs[0].id;
  }
  return id;
}
function toHome(v) {
  const k = normKey(stripNum(v));
  if (!k) return '';
  const a = HOMES.find(x => x.id === str(v) || normKey(x.name) === k);
  return a ? a.id : '';
}
function toKind(v) {
  const s = str(v).toLowerCase();
  if (!s) return '';
  if (/franchise|network/.test(s)) return 'network';
  if (/outcome|project|temporary/.test(s)) return 'outcome';
  if (/capab|home|bau|enduring|business as usual/.test(s)) return 'home';
  return '';
}

async function parseImport(file) {
  const sheets = await readXlsx(await file.arrayBuffer());
  const find = (...names) => sheets.find(s => names.map(normKey).includes(normKey(s.name)));
  const X = ix();
  const warn = [];
  const res = { people: new Map(), skills: new Map(), projects: new Map(), assignments: new Map(), timeoff: new Map(), present: new Set(), warn };
  const lower = s => str(s).toLowerCase();
  const exPeopleByName = new Map(X.people.map(p => [lower(p.name), p.id]));
  const exSkillByName = new Map(X.skills.map(s => [lower(s.name), s.id]));
  const exProjByName = new Map(X.projects.flatMap(p => [[lower(p.name), p.id], ...(p.code ? [[lower(p.code), p.id]] : [])]));
  const stampNew = (coll, id) => { const ex = S[coll].get(id); return ex && ex.createdAt ? ex.createdAt : new Date().toISOString(); };

  const tSkills = tableOf(find('Skills', 'Skill catalogue', 'Skill list'), SYN.skills, 'name');
  if (tSkills) {
    res.present.add('skills');
    for (const r of tSkills.rows) {
      const name = str(r.get('name'));
      if (!name) { warn.push(`Skills row ${r.n}: no skill name, skipped.`); continue; }
      const id = cleanId(r.get('id')) || exSkillByName.get(lower(name)) || uid('sk_');
      res.skills.set(id, { name, category: str(r.get('category')) || 'Other', critical: toBool(r.get('critical')), createdAt: stampNew('skills', id) });
    }
  }
  const skillByName = new Map([...exSkillByName, ...[...res.skills].map(([id, s]) => [lower(s.name), id])]);

  const tPeople = tableOf(find('People', 'Staff', 'Team members', 'Resources'), SYN.people, 'name');
  if (tPeople) {
    res.present.add('people');
    for (const r of tPeople.rows) {
      const name = str(r.get('name'));
      if (!name) { warn.push(`People row ${r.n}: no name, skipped.`); continue; }
      const id = cleanId(r.get('id')) || exPeopleByName.get(lower(name)) || uid('p_');
      const ex = S.people.get(id);
      let fte = toNum(r.get('fte'));
      if (fte != null && fte > 0 && fte <= 1 && !String(r.get('fte')).includes('%')) fte *= 100;
      if (fte == null) { const h = toNum(r.get('hours')); if (h != null && h > 0) fte = h / STD * 100; }
      if (fte == null) fte = ex ? fteOf(ex) : 100;
      const homeRaw = r.get('home');
      const home = toHome(homeRaw);
      if (str(homeRaw) && !home) warn.push(`People row ${r.n}: Capability Home “${str(homeRaw)}” not recognised, left empty.`);
      res.people.set(id, {
        name, role: str(r.get('role')), home, team: str(r.get('team')), location: str(r.get('location')), email: str(r.get('email')),
        type: /contract|freelance|external/i.test(str(r.get('type'))) ? 'Contractor' : 'Employee',
        fte: clamp(Math.round(fte), 5, 100),
        startDate: toISO(r.get('start')), endDate: toISO(r.get('end')), notes: str(r.get('notes')),
        skills: ex && ex.skills ? Object.assign({}, ex.skills) : {}, createdAt: stampNew('people', id),
      });
    }
  }
  const personByName = new Map([...exPeopleByName, ...[...res.people].map(([id, p]) => [lower(p.name), id])]);
  const personExists = id => res.people.has(id) || S.people.has(id);

  const mxSheet = find('Skills matrix', 'Skill matrix', 'Matrix');
  if (mxSheet) {
    let hr = -1;
    for (let r = 0; r < Math.min(10, mxSheet.rows.length); r++) if ((mxSheet.rows[r] || []).map(normKey).includes('name')) { hr = r; break; }
    if (hr >= 0) {
      const head = mxSheet.rows[hr];
      const keys = head.map(normKey);
      const iId = keys.indexOf('id'), iName = keys.indexOf('name');
      const fixed = new Set(['id', 'name', 'team', 'role', 'personid']);
      const cols = [];
      head.forEach((h, i) => {
        if (fixed.has(keys[i]) || !str(h)) return;
        let sid = skillByName.get(lower(h));
        if (!sid) { sid = uid('sk_'); res.skills.set(sid, { name: str(h), category: 'Other', critical: false, createdAt: new Date().toISOString() }); skillByName.set(lower(h), sid); res.present.add('skills'); warn.push(`Added the skill “${str(h)}” from the Skills matrix sheet.`); }
        cols.push([i, sid]);
      });
      for (let r = hr + 1; r < mxSheet.rows.length; r++) {
        const row = mxSheet.rows[r] || [];
        if (!row.some(v => v !== '' && v != null)) continue;
        let pid = iId >= 0 ? cleanId(row[iId]) : '';
        if (!pid || !personExists(pid)) pid = personByName.get(lower(iName >= 0 ? row[iName] : '')) || '';
        if (!pid) { warn.push(`Skills matrix row ${r + 1}: person not found, skipped.`); continue; }
        let rec = res.people.get(pid);
        if (!rec) { rec = Object.assign({}, S.people.get(pid)); rec.skills = Object.assign({}, rec.skills || {}); res.people.set(pid, rec); res.present.add('people-skills'); }
        for (const [i, sid] of cols) { const l = toLevel(row[i]); if (l > 0) rec.skills[sid] = l; else delete rec.skills[sid]; }
      }
    }
  }

  const tProj = tableOf(find('Activities', 'Projects', 'Project list', 'Portfolio', 'Outcome Register'), SYN.projects, 'name');
  if (tProj) {
    res.present.add('projects');
    for (const r of tProj.rows) {
      const name = str(r.get('name'));
      if (!name) { warn.push(`Activities row ${r.n}: no name, skipped.`); continue; }
      const id = cleanId(r.get('id')) || exProjByName.get(lower(name)) || (str(r.get('code')) && exProjByName.get(lower(r.get('code')))) || uid('pr_');
      let leadId = cleanId(r.get('leadId'));
      if (!leadId || !personExists(leadId)) leadId = personByName.get(lower(r.get('lead'))) || '';
      if (!leadId && str(r.get('lead'))) warn.push(`Activities row ${r.n}: lead “${str(r.get('lead'))}” not found, left empty.`);
      const kind = toKind(r.get('kind')) || (S.projects.get(id) || {}).kind || 'outcome';
      let focus = SUB.has(str(r.get('focusId'))) ? str(r.get('focusId')) : toFocus(r.get('focus'), r.get('area'));
      if (!focus && (str(r.get('focus')) || str(r.get('area')))) warn.push(`Activities row ${r.n}: focus “${str(r.get('focus')) || str(r.get('area'))}” not recognised, left empty.`);
      const s = toISO(r.get('start')), e = toISO(r.get('end'));
      if (!s) warn.push(`Activities row ${r.n}: “${name}” has no start date.`);
      if (kind === 'outcome' && !e) warn.push(`Activities row ${r.n}: Outcome Team “${name}” has no target end date.`);
      res.projects.set(id, {
        name, kind, focus, code: str(r.get('code')), sponsor: str(r.get('sponsor')), status: pickOne(r.get('status'), STATUSES, 'Planned'), priority: pickOne(r.get('priority'), PRIORITIES, 'Medium'), leadId,
        startDate: s, endDate: e, purpose: str(r.get('purpose')), why: str(r.get('why')), deprio: str(r.get('deprio')), reviewDate: toISO(r.get('review')), decision: pickOne(r.get('decision'), DECISIONS, ''),
        description: str(r.get('description')), createdAt: stampNew('projects', id),
      });
    }
  }
  const projByName = new Map([...exProjByName, ...[...res.projects].flatMap(([id, p]) => [[lower(p.name), id], ...(p.code ? [[lower(p.code), id]] : [])])]);
  const projOf = id => res.projects.get(id) || S.projects.get(id) || {};

  const bkSheet = find('Bookings', 'Assignments', 'Roles', 'Allocations');
  const tBk = tableOf(bkSheet, SYN.bookings, 'role') || tableOf(bkSheet, SYN.bookings, 'project');
  if (tBk) {
    res.present.add('assignments');
    const hasOverride = tBk.head.includes('focusoverride');
    for (const r of tBk.rows) {
      let projectId = cleanId(r.get('projectId'));
      if (!projectId || !(res.projects.has(projectId) || S.projects.has(projectId))) projectId = projByName.get(lower(r.get('project'))) || '';
      if (!projectId) { warn.push(`Bookings row ${r.n}: activity “${str(r.get('project'))}” not found, skipped.`); continue; }
      let personId = cleanId(r.get('personId'));
      const pname = str(r.get('person'));
      if (!personId || !personExists(personId)) personId = '';
      if (!personId && pname && !/^(open( role)?|tbd|unassigned|-|—)$/i.test(pname)) {
        personId = personByName.get(lower(pname)) || '';
        if (!personId) warn.push(`Bookings row ${r.n}: “${pname}” not found, kept as an open role.`);
      }
      const pj = projOf(projectId);
      const s = toISO(r.get('start')) || pj.startDate || '';
      const e = toISO(r.get('end'));
      if (!s) { warn.push(`Bookings row ${r.n}: no start date, skipped.`); continue; }
      let alloc = toNum(r.get('allocation'));
      if (alloc != null && alloc > 0 && alloc <= 1 && !String(r.get('allocation')).includes('%')) alloc *= 100;
      const skillName = str(r.get('skill'));
      const skillId = skillName ? (skillByName.get(lower(skillName)) || '') : '';
      if (skillName && !skillId) warn.push(`Bookings row ${r.n}: skill “${skillName}” not found, left empty.`);
      let focus = '';
      if (hasOverride) focus = toFocus(r.get('focusOverride'));
      else { const f = toFocus(r.get('focus')); if (f && f !== pj.focus) focus = f; }
      const id = cleanId(r.get('id')) || uid('a_');
      res.assignments.set(id, { projectId, personId, role: str(r.get('role')) || skillName || 'Role', focus, skillId, minLevel: toLevel(r.get('minLevel')), allocation: clamp(Math.round(alloc ?? 20), 1, 100), startDate: s, endDate: e && e < s ? s : e, booking: /tent|soft|pencil/i.test(str(r.get('booking'))) ? 'Tentative' : 'Confirmed', createdAt: stampNew('assignments', id) });
    }
  }

  const tOff = tableOf(find('Time off', 'Timeoff', 'Absences', 'Leave', 'Holidays'), SYN.timeoff, 'start');
  if (tOff) {
    res.present.add('timeoff');
    for (const r of tOff.rows) {
      let personId = cleanId(r.get('personId'));
      const pname = str(r.get('person'));
      if (personId !== ALL && (!personId || !personExists(personId))) personId = /^(everyone|all|all staff|company)$/i.test(pname) ? ALL : (personByName.get(lower(pname)) || '');
      if (!personId) { warn.push(`Time off row ${r.n}: “${pname}” not found, skipped.`); continue; }
      const s = toISO(r.get('start'));
      if (!s) { warn.push(`Time off row ${r.n}: no start date, skipped.`); continue; }
      const e = toISO(r.get('end')) || s;
      const id = cleanId(r.get('id')) || uid('t_');
      res.timeoff.set(id, { personId, type: pickOne(r.get('type'), OFFTYPES, personId === ALL ? 'Public holiday' : 'Other'), startDate: s, endDate: e < s ? s : e, note: str(r.get('note')), createdAt: stampNew('timeoff', id) });
    }
  }
  return res;
}
function planImport(res, mode) {
  const ops = [];
  const summary = [];
  for (const c of COLLS) {
    const inc = res[c];
    const present = res.present.has(c);
    if (!inc.size && !(mode === 'replace' && present)) continue;
    let added = 0, updated = 0, removed = 0;
    for (const [id, body] of inc) {
      const ex = S[c].get(id);
      if (ex) updated++; else added++;
      ops.push({ coll: c, id, body: Object.assign({}, body, { sample: false }) });
    }
    if (mode === 'replace' && present) for (const id of S[c].keys()) if (!inc.has(id)) { ops.push({ coll: c, id, del: true }); removed++; }
    summary.push({ c, added, updated, removed });
  }
  return { ops, summary };
}
const COLL_LABEL = { people: 'People', skills: 'Skills', projects: 'Activities', assignments: 'Bookings and roles', timeoff: 'Time off' };
let importState = null;
function openImport() {
  importState = null;
  openModal(`<div class="md-head"><div><h2 id="modalTitle">Import from Excel</h2><p>Use a workbook exported from this planner, edited in Excel. The People, Skills, Skills matrix, Activities, Bookings and Time off sheets are read. Other sheets are ignored.</p></div><button type="button" class="btn icon-btn ghost" data-act="close-modal" aria-label="Close">${icon('x')}</button></div>
    <input type="file" id="importFile" accept=".xlsx,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" hidden>
    <div class="md-body" id="importBody">
      <p class="muted">Tip: export first to get a workbook with the right columns. Rows keep their ID, so edits update the same records. Rows without an ID are added as new, or matched by name. Type and focus can be typed as in the export, for example “Outcome Team” and “Product Events Implementation”.</p>
    </div>
    <div class="md-foot"><button type="button" class="btn" data-act="close-modal">Cancel</button><button type="button" class="btn primary" data-act="pick-file">${icon('upload')}Choose .xlsx file</button></div>`, { kind: 'import' });
}
async function onImportFile(file) {
  const body = $('#importBody');
  if (!body) return;
  body.innerHTML = `<p class="muted">Reading ${esc(file.name)}…</p>`;
  let res;
  try { res = await parseImport(file); } catch (e) { console.warn(e); body.innerHTML = `<div class="banner warn">${icon('alert')}<p>${esc(e && e.message ? e.message : 'The workbook couldn’t be read.')}</p></div>`; return; }
  importState = { res, mode: 'merge', file: file.name };
  renderImportPreview();
}
function renderImportPreview() {
  const body = $('#importBody');
  if (!body || !importState) return;
  const { res, mode } = importState;
  const plan = planImport(res, mode);
  const total = plan.ops.length;
  body.innerHTML = `<p><strong>${esc(importState.file)}</strong></p>
    ${plan.summary.length ? `<div class="table-wrap" style="margin:0"><table class="data"><thead><tr><th scope="col">Records</th><th scope="col">New</th><th scope="col">Updated</th>${mode === 'replace' ? '<th scope="col">Deleted</th>' : ''}</tr></thead><tbody>${plan.summary.map(s => `<tr><td>${COLL_LABEL[s.c]}</td><td>${s.added}</td><td>${s.updated}</td>${mode === 'replace' ? `<td>${s.removed}</td>` : ''}</tr>`).join('')}</tbody></table></div>` : '<p class="empty-note">No planner sheets were found in this file.</p>'}
    <div class="radio-cards" role="radiogroup" aria-label="Import mode">
      <label><input type="radio" name="impmode" value="merge"${mode === 'merge' ? ' checked' : ''}><span><strong>Add and update</strong><small>Rows with a matching ID update that record and new rows are added. Nothing is deleted.</small></span></label>
      <label><input type="radio" name="impmode" value="replace"${mode === 'replace' ? ' checked' : ''}><span><strong>Replace</strong><small>For each sheet in the file, records that aren’t in the file are deleted. Sheets that are missing leave their records as they are.</small></span></label>
    </div>
    ${res.warn.length ? `<div><p class="field-label" style="margin-bottom:4px">${plural(res.warn.length, 'note')}</p><ul class="warnlist">${res.warn.slice(0, 8).map(w => `<li>${esc(w)}</li>`).join('')}${res.warn.length > 8 ? `<li>…and ${res.warn.length - 8} more</li>` : ''}</ul></div>` : ''}
    <div id="importProgress" hidden><div class="progress"><i></i></div><p class="muted" style="margin-top:6px" id="importProgressText"></p></div>`;
  const foot = $('#modal .md-foot');
  foot.innerHTML = `<button type="button" class="btn left" data-act="pick-file">Choose another file</button><button type="button" class="btn" data-act="close-modal">Cancel</button><button type="button" class="btn primary" data-act="run-import"${total ? '' : ' disabled'}>Import ${plural(total, 'change')}</button>`;
}
async function runImport() {
  if (!importState) return;
  const plan = planImport(importState.res, importState.mode);
  if (!plan.ops.length) return;
  const pr = $('#importProgress'), bar = pr && pr.querySelector('i'), txt = $('#importProgressText');
  if (pr) pr.hidden = false;
  for (const b of $$('#modal .md-foot .btn')) b.disabled = true;
  const res = await bulk(plan.ops, (d, n) => { if (bar) bar.style.width = (d / n * 100).toFixed(1) + '%'; if (txt) txt.textContent = `Saving ${d} of ${n}…`; });
  for (const b of $$('#modal .md-foot .btn')) b.disabled = false;
  if (res.failed.length) { failWrite(res.failed[0].e); if (txt) txt.textContent = `${res.ok} saved, ${res.failed.length} not saved.`; return; }
  importState = null;
  closeModal();
  toast(`Import finished: ${plural(res.ok, 'change')} saved.`);
}

// ===================================================================
// Rendering orchestration
// ===================================================================
const viewKey = () => app.view + '|' + canEdit() + '|' + app.ready;
function renderAll() {
  renderChrome();
  const view = $('#view');
  if (view.dataset.key !== viewKey()) renderView();
  else { syncSelects(view); renderBody(); }
  if (app.drawer && $('#drawer').open) renderDrawer();
  if (modalState && modalState.kind === 'finder') renderCands();
}
function renderView() {
  const view = $('#view');
  view.dataset.key = viewKey();
  view.innerHTML = VIEWS[app.view].shell();
  syncSelects(view);
  renderBody();
}
function renderBody() {
  const vb = $('#vb');
  if (!vb) return;
  hideTip();
  closePop();
  if (!app.ready) { vb.innerHTML = loadingState(); return; }
  const fa = document.activeElement;
  let key = null;
  if (fa && vb.contains(fa) && fa.dataset) {
    if (fa.dataset.bind) key = `[data-bind="${fa.dataset.bind}"]`;
    else if (fa.dataset.act || fa.dataset.tip) key = (fa.dataset.act ? `[data-act="${fa.dataset.act}"]` : '') + (fa.dataset.id ? `[data-id="${CSS.escape(fa.dataset.id)}"]` : '') + (fa.dataset.v != null ? `[data-v="${CSS.escape(fa.dataset.v)}"]` : '') + (fa.dataset.tip ? `[data-tip="${CSS.escape(fa.dataset.tip)}"]` : '');
  }
  VIEWS[app.view].body(vb);
  if (key) { const el = vb.querySelector(key); if (el) el.focus({ preventScroll: true }); }
}
function readHash() {
  const h = (location.hash || '').replace(/^#/, '');
  app.view = VIEWS[h] ? h : h === 'projects' ? 'activities' : 'dashboard';
}
function segPress(btn) { for (const b of btn.parentElement.querySelectorAll('button[aria-pressed]')) b.setAttribute('aria-pressed', String(b === btn)); }
function floatersOut(container) {
  for (const id of ['tip', 'toast']) { const el = document.getElementById(id); if (el && container.contains(el)) document.body.appendChild(el); }
}
function placeToast() {
  const t = $('#toast');
  if (!t) return;
  const host = $('#modal').open ? $('#modal') : $('#drawer').open ? $('#drawer') : document.body;
  if (t.parentNode !== host) host.appendChild(t);
}
function goView(v) {
  if (location.hash !== '#' + v) location.hash = '#' + v;
  else renderView();
}

// ===================================================================
// Events
// ===================================================================
function onClick(e) {
  const t = e.target.closest ? e.target.closest('[data-act]') : null;
  if (popEl && !(t && (popEl.contains(t) || t.dataset.act === 'lvl'))) closePop();
  if (!t) return;
  const act = t.dataset.act, id = t.dataset.id;
  switch (act) {
    case 'export': exportExcel(); break;
    case 'import': openImport(); break;
    case 'pick-file': { const inp = $('#importFile'); if (inp) { inp.value = ''; inp.click(); } break; }
    case 'run-import': runImport(); break;
    case 'remove-samples': removeSamples(); break;
    case 'load-samples': loadSamples(); break;
    case 'guide': openGuide(); break;
    case 'att-all': app.f.dash.allAlerts = true; renderBody(); break;
    case 'dash-area': {
      const v = t.dataset.v;
      const fromAlert = !!t.closest('.alerts');
      app.f.dash.area = fromAlert ? v : (app.f.dash.area === v ? '' : v);
      renderBody();
      if (fromAlert) { const s = $('#focusSec'); if (s) s.scrollIntoView({ block: 'start' }); }
      break;
    }
    case 'dash-clear': app.f.dash.kind = ''; app.f.dash.area = ''; if (app.f.dash.psort === 'sel') app.f.dash.psort = 'team'; renderBody(); break;
    case 'dash-psort': app.f.dash.psort = t.dataset.v; renderBody(); break;
    case 'act-kind': app.f.activities.kind = t.dataset.v; segPress(t); renderChrome(); renderBody(); break;
    case 'act-status': app.f.activities.status = t.dataset.v; segPress(t); renderBody(); break;
    case 'go-unclassified': Object.assign(app.f.activities, { kind: '', status: 'all', area: '-', q: '' }); goView('activities'); break;
    case 'skills-tab': app.f.skills.tab = t.dataset.v; segPress(t); renderBody(); break;
    case 'avail-metric': app.f.avail.metric = t.dataset.v; segPress(t); renderBody(); break;
    case 'avail-shift': {
      const v = Number(t.dataset.v);
      app.f.avail.offset = v === 0 ? 0 : app.f.avail.offset + v * Math.max(4, Math.round(app.f.avail.weeks / 2));
      renderChrome(); renderBody();
      break;
    }
    case 'toggle-table': {
      const el = document.getElementById(t.dataset.target);
      if (el) { el.hidden = !el.hidden; t.setAttribute('aria-expanded', String(!el.hidden)); t.textContent = el.hidden ? 'Show as table' : 'Hide table'; }
      break;
    }
    case 'open-person': if ($('#modal').open) closeModal(); openDrawer('person', id); break;
    case 'open-project': if ($('#modal').open) closeModal(); openDrawer('project', id); break;
    case 'close-drawer': $('#drawer').close(); break;
    case 'close-modal': closeModal(); break;
    case 'confirm-yes': settleConfirm(true); break;
    case 'confirm-no': settleConfirm(false); break;
    case 'add-person': personForm(); break;
    case 'edit-person': personForm(id); break;
    case 'del-person': deletePerson(id); break;
    case 'add-project': projectForm(); break;
    case 'edit-project': projectForm(id); break;
    case 'del-project': deleteProject(id); break;
    case 'add-role': asgForm({ projectId: id }); break;
    case 'book-person': asgForm({ personId: id }); break;
    case 'edit-asg': asgForm({ id }); break;
    case 'del-asg': deleteAsg(id); break;
    case 'add-off': offForm(null, t.dataset.person || ''); break;
    case 'edit-off': offForm(id); break;
    case 'del-off': deleteOff(id); break;
    case 'add-skill': skillForm(); break;
    case 'edit-skill': skillForm(id); break;
    case 'del-skill': deleteSkill(id); break;
    case 'lvl': if (popEl && popAnchor === t) closePop(); else openLevelPop(t); break;
    case 'set-lvl': {
      const pid = t.dataset.pid, sid = t.dataset.sid, v = Number(t.dataset.v);
      closePop(true);
      const p = ix().P.get(pid);
      if (p && (p.skills[sid] || 0) !== v) run(() => mergeDoc('people', pid, { skills: { [sid]: v } }));
      break;
    }
    case 'finder': openFinder(null); break;
    case 'find-for': openFinder(id); break;
    case 'assign': {
      const pid = t.dataset.person;
      const p = ix().P.get(pid);
      closeModal();
      run(() => mergeDoc('assignments', id, { personId: pid }), p ? `${p.name} assigned to the role` : 'Assigned');
      break;
    }
    case 'book-found': {
      const f = finder;
      closeModal();
      setTimeout(() => asgForm({ personId: t.dataset.person, preset: { startDate: f.s, endDate: f.e, allocation: clamp(Math.round(num(f.need, 20)), 1, 100), skillId: f.skillId || '', minLevel: String(f.skillId ? f.min : 0) } }), 0);
      break;
    }
    case 'go-skill': {
      const s = ix().K.get(id);
      Object.assign(app.f.skills, { tab: 'catalogue', q: s ? s.name : '', cat: '' });
      goView('skills');
      break;
    }
    default: break;
  }
}
const debouncedBody = debounce(() => renderBody(), 160);
function onInput(e) {
  const el = e.target;
  if (!el || !el.dataset) return;
  if (el.id === 'importFile') {
    if (e.type === 'change' && el.files && el.files[0]) onImportFile(el.files[0]);
    return;
  }
  if (el.dataset.fbind) {
    if (finder) { const k = el.dataset.fbind; finder[k] = k === 'min' ? Number(el.value) : el.value; renderCands(); }
    return;
  }
  if (el.name === 'impmode') {
    if (importState && importState.mode !== el.value) { importState.mode = el.value; renderImportPreview(); }
    return;
  }
  const b = el.dataset.bind;
  if (!b) return;
  const [g, k] = b.split('.');
  const cur = app.f[g][k];
  const v = typeof cur === 'number' ? Number(el.value) : el.value;
  if (cur === v) return;
  app.f[g][k] = v;
  if (g === 'dash') { app.f.dash.allAlerts = false; if (!app.f.dash.kind && !app.f.dash.area && app.f.dash.psort === 'sel') app.f.dash.psort = 'team'; }
  syncSelects($('#view'));
  if (g === 'avail' || g === 'dash') renderChrome();
  if (el.tagName === 'INPUT' && e.type === 'input') debouncedBody(); else renderBody();
}
function onKey(e) {
  if (!popEl) return;
  if (e.key === 'Escape') { e.preventDefault(); e.stopPropagation(); closePop(true); return; }
  if (e.key === 'ArrowDown' || e.key === 'ArrowUp') {
    const items = $$('button', popEl);
    const i = items.indexOf(document.activeElement);
    if (i < 0) return;
    e.preventDefault();
    items[(i + (e.key === 'ArrowDown' ? 1 : items.length - 1)) % items.length].focus();
  }
}
function bindEvents() {
  window.addEventListener('hashchange', () => { readHash(); closePop(); hideTip(); renderAll(); window.scrollTo(0, 0); });
  document.addEventListener('click', onClick);
  document.addEventListener('input', onInput);
  document.addEventListener('change', onInput);
  document.addEventListener('keydown', onKey, true);
  document.addEventListener('pointerover', e => {
    if (e.pointerType === 'touch') return;
    const el = e.target.closest ? e.target.closest('[data-tip]') : null;
    if (el) { if (el !== tipFor) showTip(el); } else if (tipFor) hideTip();
  });
  document.addEventListener('pointerout', e => {
    if (!tipFor) return;
    const to = e.relatedTarget && e.relatedTarget.closest ? e.relatedTarget.closest('[data-tip]') : null;
    if (!to) hideTip();
  });
  document.addEventListener('focusin', e => { const el = e.target; if (el && el.dataset && el.dataset.tip) showTip(el); });
  document.addEventListener('focusout', () => hideTip());
  window.addEventListener('scroll', () => { hideTip(); if (popEl) positionPop(); }, true);
  let lastW = innerWidth;
  window.addEventListener('resize', debounce(() => { if (innerWidth !== lastW) { lastW = innerWidth; drawCharts(); } }, 150));
  const drawer = $('#drawer'), modal = $('#modal');
  drawer.addEventListener('click', e => { if (e.target === drawer) drawer.close(); });
  drawer.addEventListener('close', () => { if (!drawer.open) { app.drawer = null; floatersOut(drawer); placeToast(); hideTip(); } });
  modal.addEventListener('close', () => {
    if (modal.open) return;
    if (modalState && modalState.resolve) { const r = modalState.resolve; modalState.resolve = null; r(false); }
    modalState = null; finder = null; importState = null;
    floatersOut(modal); placeToast(); hideTip();
  });
}

// ===================================================================
// Start
// ===================================================================
async function connect() {
  const C = window.claude;
  if (!C || typeof C.use !== 'function') { startLocal(); return; }
  let db = null;
  try { db = await C.use('db'); } catch (e) { db = null; }
  if (!db) { startLocal(); return; }
  startShared(db);
  try {
    const user = await C.use('user');
    if (user) {
      const w = await user.can('data.write');
      if (w === false || w === true) { if (app.canWrite !== false) app.canWrite = w; changed(); }
    }
  } catch (e) { /* not told: keep the controls and let a refused write decide */ }
}
function init() {
  $('#nav').innerHTML = VIEW_LIST.map(([v, label, ic]) => `<a href="#${v}" data-nav="${v}">${icon(ic)}<span>${label}</span></a>`).join('');
  $('.brand-name').textContent = APP_NAME;
  readHash();
  bindEvents();
  renderAll();
  connect();
}
init();

})();
</script>

</body></html>
