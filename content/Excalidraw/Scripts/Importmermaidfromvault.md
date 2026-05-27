/*
 * ImportMermaidFromVault
 * ----------------------
 * Scans your Obsidian vault for ```mermaid blocks, lets you pick one
 * via a fuzzy suggest, then imports it into the current Excalidraw drawing
 * as native elements plus a [[note#^block-id]] link underneath.
 *
 * Block ID is inserted BEFORE the opening ```mermaid fence so it doesn't
 * interfere with external renderers (e.g. Digital Garden / Eleventy).
 *
 * A collapsible callout linking back to the Excalidraw drawing is inserted
 * on the line immediately after the block ID.
 *
 * Exception handling:
 * - Reuses existing ^block-id if found on any non-blank line before the fence
 * - Skips callout insertion if a link to this drawing already exists nearby
 * - Handles blank lines between ^block-id and the fence correctly
 * - Safe to run multiple times on the same diagram
 */

ea.reset();
ea.setView("first");

// ── 1. Scan vault for mermaid blocks ────────────────────────────────────────

const mermaidEntries = [];
const mdFiles = app.vault.getMarkdownFiles();

for (const file of mdFiles) {
  const content = await app.vault.cachedRead(file);
  const lines = content.split("\n");

  let idx = 0;
  for (let i = 0; i < lines.length; i++) {
    if (!lines[i].trimEnd().match(/^```mermaid\s*$/)) continue;

    // Collect mermaid code until closing ```
    let j = i + 1;
    while (j < lines.length && !lines[j].trimEnd().match(/^```\s*$/)) j++;
    const mermaidCode = lines.slice(i + 1, j).join("\n").trim();
    if (!mermaidCode) { idx++; continue; }

    // Walk backwards from the fence skipping blank lines to find a ^block-id
    let existingBlockId = null;
    let blockIdLineIdx = null;
    for (let k = i - 1; k >= 0 && k >= i - 5; k--) {
      const trimmed = lines[k].trim();
      if (trimmed === "") continue; // skip blank lines
      if (trimmed.match(/^\^[\w-]+$/)) {
        existingBlockId = trimmed.slice(1);
        blockIdLineIdx = k;
      }
      break; // stop at first non-blank line regardless
    }

    const slug = file.basename
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, "-")
      .replace(/^-|-$/g, "");
    const autoBlockId = `mermaid-${slug}-${idx + 1}`;
    const firstLine = mermaidCode.split("\n").find(l => l.trim()) || "diagram";

    mermaidEntries.push({
      notePath: file.path,
      noteName: file.basename,
      mermaidCode,
      existingBlockId,   // null if none found
      blockIdLineIdx,    // line index of existing ^id, null if none
      autoBlockId,
      fenceLineIndex: i,
      closingLineIndex: j,
      label: `${file.basename}${idx > 0 ? ` [${idx + 1}]` : ""} — ${firstLine.trim().slice(0, 60)}`,
      index: idx,
    });
    idx++;
    i = j;
  }
}

if (mermaidEntries.length === 0) {
  new Notice("No ```mermaid blocks found in your vault.", 5000);
  return;
}

// ── 2. Fuzzy-suggest picker ──────────────────────────────────────────────────

const chosen = await utils.suggester(
  mermaidEntries.map(e => e.label),
  mermaidEntries,
  "Pick a Mermaid diagram to import"
);

if (!chosen) return;

// ── 3. Get current Excalidraw drawing path ───────────────────────────────────

const drawingPath = ea.targetView.file.path;
const drawingName = ea.targetView.file.basename;
const drawingLinkPath = drawingPath.replace(/\.md$/, "");

// ── 4. Resolve block ID and insert callout into source note ─────────────────

let blockId;

const file = app.vault.getAbstractFileByPath(chosen.notePath);
let lines = (await app.vault.read(file)).split("\n");

const calloutHeader = `> [!info]- Excalidraw`;
const calloutBody   = `> [[${drawingLinkPath}|${drawingName}]]`;

// Helper: check if a link to this specific drawing already exists
// in a window of lines around a given index
function hasDrawingLink(lines, fromIdx, windowSize = 6) {
  return lines
    .slice(fromIdx, fromIdx + windowSize)
    .some(l => l.includes(drawingLinkPath) || l.includes(drawingName));
}

if (chosen.existingBlockId) {
  // ── Case A: block ID already exists ────────────────────────────────────────
  blockId = chosen.existingBlockId;
  const bidx = chosen.blockIdLineIdx;

  // Check if callout for THIS drawing already present right after block ID
  if (!hasDrawingLink(lines, bidx + 1)) {
    // Find first non-blank line after block ID to insert before it
    let insertAt = bidx + 1;
    // Insert callout between block ID and whatever follows
    lines.splice(insertAt, 0, calloutHeader, calloutBody);
  }
  // else: callout already there, nothing to do

} else {
  // ── Case B: no block ID yet — insert everything before the fence ───────────
  blockId = chosen.autoBlockId;

  // Insert: ^block-id, callout header, callout body, blank line, then fence follows
  lines.splice(chosen.fenceLineIndex, 0,
    `^${blockId}`,
    calloutHeader,
    calloutBody,
    ""
  );
}

await app.vault.modify(file, lines.join("\n"));

// ── 5. Import the mermaid diagram ────────────────────────────────────────────

let importedIds = [];

try {
  importedIds = await ea.addMermaid(chosen.mermaidCode);
} catch (err) {
  new Notice(`Failed to parse Mermaid diagram:\n${err.message}`, 8000);
  return;
}

// ── 6. Bounding box of imported elements ─────────────────────────────────────

const elements = ea.getElements().filter(el => importedIds.includes(el.id));

let minX = Infinity, maxX = -Infinity, maxY = -Infinity;

for (const el of elements) {
  minX = Math.min(minX, el.x);
  maxX = Math.max(maxX, el.x + (el.width ?? 0));
  maxY = Math.max(maxY, el.y + (el.height ?? 0));
}

if (!isFinite(minX)) { minX = 0; maxX = 400; maxY = 300; }

// ── 7. Add [[note#^block-id]] link below the diagram ─────────────────────────

const GAP = 24;
const noteLinkPath = chosen.notePath.replace(/\.md$/, "");
const linkText = `[[${noteLinkPath}#^${blockId}|↩ ${chosen.noteName}]]`;

ea.style.strokeColor = "#6c757d";
ea.style.fontSize = 16;
ea.style.fontFamily = 1;

const textId = ea.addText(
  minX,
  maxY + GAP,
  linkText,
  { width: maxX - minX, textAlign: "center" }
);

// ── 8. Group and commit ───────────────────────────────────────────────────────

ea.addToGroup([...importedIds, textId]);
await ea.addElementsToView(true, true, true);

new Notice(`Imported "${chosen.noteName}" → #^${blockId} ✓`, 4000);
