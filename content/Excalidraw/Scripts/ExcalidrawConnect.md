/*
 * ExcalidrawConnect
 * -----------------
 * Shows Vimium-style hints over every element.
 * Type a combo to pick the SOURCE, then type another to pick the TARGET.
 * An arrow is drawn between them using connectObjects.
 *
 * Assign a hotkey to this script in Obsidian settings for best results.
 */

ea.reset();
ea.setView("first");

// ── 1. Get all non-arrow elements ────────────────────────────────────────────

const allElements = ea.getViewElements().filter(el =>
  el.type !== "arrow" && el.type !== "line" && !el.isDeleted
);

if (allElements.length < 2) {
  new Notice("Need at least 2 elements to connect.", 3000);
  return;
}

// ── 2. Generate hint combos ───────────────────────────────────────────────────

const CHARS = "asdfghjklqwertyuiopzxcvbnm";

function generateHints(count) {
  const hints = [];
  if (count <= CHARS.length) {
    for (let i = 0; i < count; i++) hints.push(CHARS[i]);
  } else {
    for (let i = 0; i < CHARS.length; i++)
      for (let j = 0; j < CHARS.length && hints.length < count; j++)
        hints.push(CHARS[i] + CHARS[j]);
  }
  return hints;
}

const hints = generateHints(allElements.length);
const hintMap = {};
allElements.forEach((el, i) => { hintMap[hints[i]] = el; });

// ── 3. Canvas overlay setup ──────────────────────────────────────────────────

const canvasEl = ea.targetView.containerEl;
const api = ea.getExcalidrawAPI();
const appState = api.getAppState();
const { scrollX, scrollY, zoom } = appState;

function sceneToScreen(x, y) {
  return {
    sx: (x + scrollX) * zoom.value,
    sy: (y + scrollY) * zoom.value,
  };
}

const overlay = document.createElement("div");
overlay.style.cssText = `
  position: absolute;
  top: 0; left: 0;
  width: 100%; height: 100%;
  pointer-events: none;
  z-index: 9999;
  font-family: monospace;
`;
canvasEl.style.position = "relative";
canvasEl.appendChild(overlay);

// ── 4. Render hints ───────────────────────────────────────────────────────────

function renderHints(typed, sourceEl, label) {
  overlay.innerHTML = "";

  // Status bar
  const status = document.createElement("div");
  status.style.cssText = `
    position:absolute; bottom:16px; left:50%; transform:translateX(-50%);
    background:rgba(0,0,0,0.85); color:#fff; padding:4px 14px;
    border-radius:4px; font-size:13px; pointer-events:none; white-space:nowrap;
  `;
  status.textContent = label;
  overlay.appendChild(status);

  for (const [combo, el] of Object.entries(hintMap)) {
    if (sourceEl && el.id === sourceEl.id) continue; // hide source in target mode
    if (!combo.startsWith(typed)) continue;

    const { sx, sy } = sceneToScreen(el.x + (el.width ?? 0) / 2, el.y);
    const badge = document.createElement("div");
    const remaining = combo.slice(typed.length);
    badge.innerHTML = `<span style="color:#aaa">${typed}</span><span style="color:#ffdd57;font-weight:bold">${remaining}</span>`;
    badge.style.cssText = `
      position: absolute;
      left: ${sx}px;
      top: ${sy - 22}px;
      background: ${sourceEl ? "rgba(30,90,200,0.9)" : "rgba(0,0,0,0.85)"};
      color: #ffdd57;
      padding: 1px 5px;
      border-radius: 3px;
      font-size: 12px;
      font-weight: bold;
      pointer-events: none;
      transform: translateX(-50%);
      white-space: nowrap;
    `;
    overlay.appendChild(badge);
  }
}

// ── 5. Two-phase hint input ───────────────────────────────────────────────────

let typed = "";
let sourceEl = null;

renderHints("", null, "Connect: type hint for SOURCE element · Esc to cancel");

function cleanup() {
  overlay.remove();
  document.removeEventListener("keydown", onKeyDown, true);
}

function onKeyDown(e) {
  if (e.key === "Escape") {
    e.preventDefault();
    cleanup();
    return;
  }

  if (e.key === "Backspace") {
    e.preventDefault();
    typed = typed.slice(0, -1);
    renderHints(typed, sourceEl,
      sourceEl
        ? "Connect: type hint for TARGET element · Esc to cancel"
        : "Connect: type hint for SOURCE element · Esc to cancel"
    );
    return;
  }

  if (e.key.length !== 1) return;
  e.preventDefault();
  e.stopPropagation();

  typed += e.key.toLowerCase();

  if (!sourceEl) {
    // ── Phase 1: picking source ──────────────────────────────────────────────
    renderHints(typed, null, "Connect: type hint for SOURCE element · Esc to cancel");

    if (hintMap[typed]) {
      sourceEl = hintMap[typed];
      ea.selectElementsInView([sourceEl]);
      typed = "";
      renderHints("", sourceEl, `Source: ${sourceEl.type} selected — now type hint for TARGET · Esc to cancel`);
    } else if (!Object.keys(hintMap).some(c => c.startsWith(typed))) {
      typed = "";
      renderHints("", null, "Connect: type hint for SOURCE element · Esc to cancel");
    }

  } else {
    // ── Phase 2: picking target ──────────────────────────────────────────────
    renderHints(typed, sourceEl, `Source selected — type hint for TARGET · Esc to cancel`);

    if (hintMap[typed] && hintMap[typed].id !== sourceEl.id) {
      const targetEl = hintMap[typed];
      cleanup();

      // Draw arrow using connectObjects
      ea.reset();
      ea.connectObjects(sourceEl.id, null, targetEl.id, null, {
        numberOfPoints: 2,
        startArrowHead: "none",
        endArrowHead: "arrow",
      });
      ea.addElementsToView(false, false, false);

      ea.selectElementsInView([sourceEl, targetEl]);
      new Notice(`Connected ${sourceEl.type} → ${targetEl.type} ✓`, 3000);

    } else if (!Object.keys(hintMap).some(c =>
      c.startsWith(typed) && hintMap[c]?.id !== sourceEl.id
    )) {
      typed = "";
      renderHints("", sourceEl, `Source selected — type hint for TARGET · Esc to cancel`);
    }
  }
}

document.addEventListener("keydown", onKeyDown, true);

// Auto-cleanup after 30s
setTimeout(cleanup, 30000);
