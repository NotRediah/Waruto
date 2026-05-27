---
tags:
  - guide
  - windows
---
# autostart
### The "One-Command" Method (Recommended)

Komorebi has a built-in tool that creates a shortcut in your Windows Startup folder. Open your terminal (PowerShell) and run:

PowerShell

```
komorebic enable-autostart --whkd
```

**What this does:**

- It creates a special shortcut in your `shell:startup` folder.
    
- The `--whkd` flag ensures your **hotkeys** start at the same time.
    
- It tells Komorebi to run in the background without opening a visible terminal window.
    

---

### The Manual Method (If the command fails)

If the command above doesn't work for some reason, you can do it yourself:

1. Press `Win + R`, type **`shell:startup`**, and hit Enter. This opens the folder where Windows looks for startup apps.
    
2. Right-click inside the folder and select **New > Shortcut**.
    
3. For the location, type: `komorebic.exe start --whkd`
    
4. Name it "Komorebi" and finish.
# other shit
small hud for workspace indication (wit fh ahk) instead of the fucking stupid shitty ass top bar
- i used the hp custom key to start komorebi and ahk stuff
# config