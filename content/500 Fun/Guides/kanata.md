---
aliases:
  - Kanata
---

> [!Warning] Note
> [[Kanata config]]


# Linux
## Issues 
### Not using second keyboard 
you need to defien the other keyboard as input in the defsrc
```
defcfg
  process-unmapped-keys yes
  linux-dev (/dev/input/event4 /dev/input/event5)
)
```
you to find out what your keyboard is initially called aswell via grep

## Setup(via systemd)
Launch:

```bash
sudo kanata --cfg ~/.config/kanata/config.kbd
```

For autostart, create a systemd service:

```bash
sudo nano /etc/systemd/system/kanata.service
```

```ini
[Unit]
Description=Kanata keyboard remapper
After=local-fs.target

[Service]
Type=simple
ExecStart=/usr/bin/kanata --cfg /home/zg/.config/kanata/config.kbd
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl enable --now kanata
```
