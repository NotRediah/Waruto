---
aliases:
  - Sway-scroll
  - Scrollwm
---

> Cool scrolling window manager
- [[scoll config]]

# TODO's
- [ ] scroll keyboard shortcut chart popup or something
- [x] Making a spaces list ( do spaces persist) ✅ 2026-05-21 [taskforgePending:: recurrence]
# Features to explore
## Trails / Trailmarks
To mark windows by default in **scrollwm** (Sway), you can use a `for_window` rule with a wildcard. This will automatically apply a mark to every new window that opens.

### 1. The Config Rule

Add this to your `scrollwm` (Sway) config:

Bash

```
# This marks every new window with the name "new"
for_window [class=".*"] mark "spawned"
for_window [app_id=".*"] mark "spawned"
```

- **Why two lines?** Wayland apps use `app_id`, and XWayland apps use `class`. Using both ensures every window gets hit.
    
- **The Mark Name:** I used `"spawned"`, but you can change that to whatever you like.
    

---

### 2. Making the Marks Useful (Visuals)

By default, marks are hidden. To actually see them (like a label on the title bar), add this to your config:

Bash

```
# Show the mark in the window title bar
show_marks yes
```

If you want the marks to have a specific color so they stand out:

Bash

```
# syntax: client.<class> <border> <bg> <text> <indicator> <child_border>
client.focused #4c7899 #285577 #ffffff #2e9ef4 #285577
```

---

### 3. A Better Way: Dynamic Marks

If you want each window to have a **unique** mark (like `win1`, `win2`, etc.), Sway doesn't do that natively with just a config line. You would need a small script.

However, if you just want to **select** or **jump** to windows easily, **scrollwm** has a built-in "Jump Mode" (like Easymotion) that is much better than manual marks.

**Try this binding if you haven't yet:**

Bash

```
# Built-in scrollwm jump mode (Better than manual marks)
bindsym $mod+g scrollmsg "jump"
```
## Spaces
Remembering spaces

# Issues
- [[gammastep issue|nightlight not working]]
- [[scroll fullscreen]]
- [[Vesktop screensharing]]