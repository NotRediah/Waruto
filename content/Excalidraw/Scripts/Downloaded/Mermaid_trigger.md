const moreTools = document.querySelector('[title="More tools"]');
if (moreTools) {
  moreTools.click();
  setTimeout(() => {
    const buttons = document.querySelectorAll('button');
    const mermaid = Array.from(buttons).find(b => b.textContent.trim() === 'Mermaid to Excalidraw');
    if (mermaid) mermaid.click();
    else new Notice("Mermaid button not found");
  }, 300);
} else new Notice("More tools button not found");