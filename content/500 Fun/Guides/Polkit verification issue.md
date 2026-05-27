---
dg-publish: true
tags:
  - guide
  - linux/issue
aliases:
  - drive-mounting-issue
---
## Enable all the required components
```
sudo pacman -S thunar thunar-volman gvfs gvfs-mtp gvfs-gphoto2 gvfs-afc polkit
```

(You may already have some of these — that’s fine.)
## Enable the Polkit authentication agent

Thunar uses polkit to ask for permission when mounting drives.
You need a polkit agent running in your session.

If you don’t have a desktop environment, you can install a lightweight agent:
 
 GNOME agent:
```
sudo pacman -S polkit-gnome
```

Then add this line to your Niri autostart (or startup script):
```
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
```

