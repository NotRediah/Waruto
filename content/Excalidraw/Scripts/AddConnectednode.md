const ea = ExcalidrawAutomate;
ea.reset();
ea.setView("first");

const selected = ea.getViewSelectedElements().filter(e => e.type !== "arrow");

if (selected.length === 0) {
  // Nothing selected — just drop a plain text element at center of view
  const { x, y } = ea.targetView.excalidrawAPI.getAppState();
  const id = ea.addText(x, y, "", { width: 200 });
  await ea.addElementsToView(false, true);
  return;
}

const source = selected[0];
const label = await utils.inputPrompt("Node label", "text");
if (!label) return;

// Position new node below the source
const newX = source.x;
const newY = source.y + source.height + 100;

// Add as plain text (no box) — works for both text and shape sources
const newId = ea.addText(newX, newY, label, {
  textAlign: "center",
  width: source.width ?? 200,
});

// Connect source to new node with arrow
ea.connectObjectWithViewSelectedElement(
  newId,
  "top",
  "bottom",
  { numberOfPoints: 2, endArrowHead: "arrow", padding: 5 }
);

await ea.addElementsToView(false, true);