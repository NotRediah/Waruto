---
dg-publish: true
---
- [ ] Sent email to takahashi with haiderwantstokhs@gmail.com 
- [ ] reddit posts on arch linux and linux hardware
# Claude chat summary
**The Problem** Your HP EliteBook 845 G10 has an internal microphone that doesn't work on Linux (Arch). The internal mic works fine on Windows. When headphones are plugged in, both the "Internal Microphone" and "Microphone" ports in pavucontrol actually capture from the same source — the headphone jack mic (pin 0x19). The real internal mic (pin 0x12, physically soldered inside the laptop) captures nothing.

**What We Discovered Through Diagnosis**

- Codec: Realtek ALC245, Subsystem ID 103c:8b72
- The kernel correctly detects pin 0x12 as "Internal Mic" in autoconfig
- Pin 0x12 has `Misc = NO_PRESENCE` meaning it should always be available regardless of jack state
- Node 0x23 is the ADC mixer feeding ADC 0x08 (the active capture path). Its connections are: 0x19, 0x1a, 0x1b, 0x1d, 0x12 — with 0x19 unmuted and 0x12 muted at hardware level
- The existing kernel fixup for 103c:8b72 is `ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED` which only handles the CS35L41 speaker amplifier and the mute/micmute LEDs — no mic routing fixup exists for this model
- The CS35L41 amp was causing codec reconfigurations that reset any manual hda-verb changes we tried to make, which is why nothing stuck

**Everything We Tried That Failed**

- WirePlumber rules (`api.acp.auto-port = false`, `api.acp.auto-profile = false`) — didn't override port availability
- hdajackretask pin override on 0x12 — showed up in pavucontrol but no audio
- `dell-headset-multi` modprobe quirk — changed availability groups but broke the CS35L41 amp binding and caused reconfig loops, no mic fix
- Switching to Pro Audio profile — broke speakers
- Multiple hda-verb commands to unmute 0x12 on node 0x23 and set amp gain — values didn't stick due to wireplumber and codec reconfig overriding them
- Brute forcing coeff register 0x45 with values `0xd029`, `0xd019`, `0xc429`, `0xc419`, `0x5029`, `0x5019`, `0xd429`, `0xd419`, `0x4a29`, `0x4a19` — none worked
- Setting coeff 0x45 to `0xd029` (jack detection control) — no effect
- Stopping wireplumber before applying verbs — verbs still didn't change hardware state, `/proc` output was stale

**Root Cause** The kernel's fixup for your exact laptop model (`103c:8b72`) has never had an internal mic routing fixup added. The Windows Realtek driver handles this with hardcoded routing logic that the generic Linux HDA driver doesn't replicate. This is a kernel-level bug that cannot be fixed from userspace — it needs a patch in `sound/pci/hda/patch_realtek.c`.

**Other HP laptops that have gotten fixes this way**

- HP EliteBook 855 G8 — got `ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED` which fixed internal mic, submitted by a regular user
- HP EliteBook 845 G8 — got `ALC285_FIXUP_HP_LIMIT_INT_MIC_BOOST`
- HP EliteBook 840 G9, HP ZBook Fury, HP ProBook 445 G7, HP Spectre x360, and many others

**What We Did About It**

- Generated a full alsa-info dump
- Wrote and sent a detailed bug report to `alsa-devel@alsa-project.org` CC'd to Takashi Iwai (`tiwai@suse.de`), the primary ALSA kernel maintainer
- Posted on r/linuxhardware and r/archlinux

**Temporary Workarounds Identified**

- Use the headphone jack mic (works fine, but you hate the quality)
- Get a TRS (2-ring, no mic) extension cable — since it has no 4th mic ring, jack detection won't trigger headset mic mode, potentially leaving the internal mic path alone. Costs 200-300 PKR at Saddar/Raja Bazaar
- USB-C audio dongle (~500-1000 PKR) for a clean external mic input

**Probability of Fix** 60-70% chance of a fix within a few months. Takashi is very active and responsive. The main uncertainty is whether he can figure out the correct coef/verb sequence for your specific model without having the hardware himself. Your detailed report with the full codec dump gives him the best possible starting point.

**What a Fix Would Look Like** A kernel developer needs to add a new fixup entry in `patch_realtek.c` that correctly routes pin 0x12 into the ADC capture path for subsystem ID 103c:8b72, chained on top of the existing CS35L41 fixup. Once merged it would ship via a normal Arch kernel update and just work automatically, permanently, for you and every other EliteBook 845 G10 user on Linux.