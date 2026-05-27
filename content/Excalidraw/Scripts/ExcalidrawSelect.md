/*

- ExcalidrawSelect
- ---
    
- Shows a Vimium-style hint overlay over every element.
- Type the combo to select it. Then use arrow keys / hjkl to move it.
- Press Escape to dismiss.

- Assign a hotkey to this script in Obsidian settings for best results. */

ea.reset(); ea.setView("first");

const STEP = 10; // px per keypress const STEP_BIG = 50; // px with Shift held

// ── 1. Get all non-arrow elements ────────────────────────────────────────────

const allElements = ea.getViewElements().filter(el => el.type !== "arrow" && el.type !== "line" && !el.isDeleted );

if (allElements.length === 0) { new Notice("No elements on canvas.", 3000); return; }

// ── 2. Generate hint combos ───────────────────────────────────────────────────

const CHARS = "asdfghjklqwertyuiopzxcvbnm";

function generateHints(count) { const hints = []; if (count <= CHARS.length) { for (let i = 0; i < count; i++) hints.push(CHARS[i]); } else { for (let i = 0; i < CHARS.length; i++) for (let j = 0; j < CHARS.length && hints.length < count; j++) hints.push(CHARS[i] + CHARS[j]); } return hints; }

const hints = generateHints(allElements.length); const hintMap = {}; // combo → element allElements.forEach((el, i) => { hintMap[hints[i]] = el; });

// ── 3. Get canvas container to overlay hints ──────────────────────────────────

const canvasEl = ea.targetView.containerEl; const canvasRect = canvasEl.getBoundingClientRect();

// Get the Excalidraw API to convert scene coords to screen coords const api = ea.getExcalidrawAPI(); const appState = api.getAppState(); const { scrollX, scrollY, zoom } = appState;

function sceneToScreen(x, y) { // Find the actual <canvas> element inside containerEl to get its offset const cvs = canvasEl.querySelector("canvas"); const offsetLeft = cvs ? cvs.offsetLeft : 0; const offsetTop = cvs ? cvs.offsetTop : 0; return { sx: (x + scrollX) * zoom.value + offsetLeft, sy: (y + scrollY) * zoom.value + offsetTop, }; }

// ── 4. Render hint overlay ────────────────────────────────────────────────────

const overlay = document.createElement("div"); overlay.style.cssText = `position: absolute; top: 0; left: 0; width: 100%; height: 100%; pointer-events: none; z-index: 9999; font-family: monospace;`; canvasEl.style.position = "relative"; canvasEl.appendChild(overlay);

function renderHints(typed) { overlay.innerHTML = ""; for (const [combo, el] of Object.entries(hintMap)) { if (!combo.startsWith(typed)) continue; const { sx, sy } = sceneToScreen(el.x + (el.width ?? 0) / 2, el.y); const badge = document.createElement("div"); const remaining = combo.slice(typed.length); badge.innerHTML = `<span style="color:#aaa">${typed}</span><span style="color:#ffdd57;font-weight:bold">${remaining}</span>`; badge.style.cssText = `position: absolute; left: ${sx}px; top: ${sy - 22}px; background: rgba(0,0,0,0.85); color: #ffdd57; padding: 1px 5px; border-radius: 3px; font-size: 12px; font-weight: bold; pointer-events: none; transform: translateX(-50%); white-space: nowrap;` ; overlay.appendChild(badge); } }

renderHints("");

// ── 5. Listen for keystrokes ──────────────────────────────────────────────────

let typed = ""; let selectedEl = null;

function cleanup() { overlay.remove(); document.removeEventListener("keydown", onKeyDown, true); }

function onKeyDown(e) { // ── Move mode (element already selected) ─────────────────────────────────── if (selectedEl) { const step = e.shiftKey ? STEP_BIG : STEP; let dx = 0, dy = 0;

```
switch (e.key) {
  case "ArrowLeft":  case "h": dx = -step; break;
  case "ArrowRight": case "l": dx =  step; break;
  case "ArrowUp":    case "k": dy = -step; break;
  case "ArrowDown":  case "j": dy =  step; break;
  case "Escape": cleanup(); return;
  default: return;
}

e.preventDefault();
e.stopPropagation();

// Move via the Excalidraw API directly
api.updateScene({
  elements: api.getSceneElements().map(el =>
    el.id === selectedEl.id
      ? { ...el, x: el.x + dx, y: el.y + dy }
      : el
  )
});
return;
```

}

// ── Hint mode ────────────────────────────────────────────────────────────── if (e.key === "Escape") { e.preventDefault(); cleanup(); return; }

if (e.key === "Backspace") { e.preventDefault(); typed = typed.slice(0, -1); renderHints(typed); return; }

if (e.key.length !== 1) return; e.preventDefault(); e.stopPropagation();

typed += e.key.toLowerCase(); renderHints(typed);

// Check for exact match if (hintMap[typed]) { selectedEl = hintMap[typed]; ea.selectElementsInView([selectedEl]); overlay.innerHTML = `<div style=" position:absolute; bottom:16px; left:50%; transform:translateX(-50%); background:rgba(0,0,0,0.8); color:#ffdd57; padding:4px 12px; border-radius:4px; font-size:13px; font-family:monospace; pointer-events:none; ">Selected: ${selectedEl.type} — arrow keys / hjkl to move · Esc to exit</div>`; return; }

// No combos left — reset if (!Object.keys(hintMap).some(c => c.startsWith(typed))) { typed = ""; renderHints(typed); } }

document.addEventListener("keydown", onKeyDown, true);

// Auto-cleanup after 30s in case user forgets setTimeout(cleanup, 30000);