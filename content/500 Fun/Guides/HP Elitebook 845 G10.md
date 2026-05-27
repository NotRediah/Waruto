> Things i think are gonna be helpful
# Battery Cycles
|**Cycle Count**|**Battery Health %**|**Light Work (Browsing/Edge/Office)**|**CS/Heavy Load (VS Code/WSL2/Docker)**|
|---|---|---|---|
|**0 – 50**|**98% – 100%**|**7.5 – 9 Hours**|**4 – 5 Hours**|
|**50 – 150**|**93% – 97%**|**6.5 – 8 Hours**|**3.5 – 4.5 Hours**|
|**150 – 300**|**85% – 92%**|**5 – 6.5 Hours**|**2.5 – 3.5 Hours**|
|**300 – 500**|**75% – 84%**|**4 – 5 Hours**|**2 – 2.5 Hours**|
|**500+**|**< 75%**|**2.5 – 3.5 Hours**|**1 – 1.5 Hours**|
# Guide
- mr dickson shitting on the firmware (https://neurrone.com/posts/hp-elitebook-845-g10-laptop-nightmare/#specs)
	- most of these were firmware issues or bios related issues 
	- if you do end up getting this bios update is essential (make sure power doesn't cut out) , so most stuff is fixed besides the idle drain on the usb ports gemini said it's fixable if you switch to arch but i am kinda skeptical
- debloat windows when you get it initially update bios , check for every fucking driver turn off the fucking usb drain and something about aspsm
- install arch and compare
## lazy gemini prompt for optimization
If you take Windows 11 and strip it down to the "bare metal" for your **EliteBook 845 G10**, you can narrow the gap with Arch significantly. An "Optimized" Windows install can drop your idle power usage from the typical **8W–12W** down to a lean **4W–6W**.

Here is how the battery life scales for a "Clean/Optimized" Windows 11 setup on your G10:

### 🪟 Optimized Windows 11 Estimates (The "CS Pro" Build)

_Assumes: Debloated, CPU Boost disabled on battery, and 400-nit low-power screen._

|**Cycle Count**|**Health %**|**Light Work (Edge/PDFs/Notion)**|**CS Load (WSL2/VS Code)**|
|---|---|---|---|
|**0 – 50**|**98% – 100%**|**9.5 – 11 Hours**|**5.5 – 6.5 Hours**|
|**50 – 150**|**93% – 97%**|**8.5 – 10 Hours**|**4.5 – 5.5 Hours**|
|**150 – 300**|**85% – 92%**|**7 – 8.5 Hours**|**3.5 – 4.5 Hours**|
|**300 – 500**|**75% – 84%**|**5.5 – 6.5 Hours**|**2.5 – 3.5 Hours**|
|**500+**|**< 75%**|**3.5 – 4.5 Hours**|**~1.5 Hours**|

---

### 🛠️ How to get these numbers (The "Unc" Guide to Windows)

To hit these marks, you can't just use Windows as-is. You need to do three specific "technical" things:

#### 1. The "Registry Hack" (Disable CPU Boost)

The Ryzen 7 processor in the G10 is aggressive. It will "boost" to 4.5GHz just to open a Chrome tab, which causes a massive power spike.

- **The Trick:** You can unhide a setting in Power Options called **"Processor performance boost mode."** Set this to **Disabled** when on battery.
    
- **The Result:** The laptop stays at its base clock (e.g., 3.3GHz). You won't feel any lag in coding, but your battery life will jump by **1.5 to 2 hours** instantly.
    

#### 2. The "Chris Titus" Debloat

Don't use "Ghost Spectre" or unofficial ISOs—they are risky for a CS student. Instead, install a clean Windows 11 Pro and run the **Chris Titus Tech Windows Utility** (via PowerShell).

- **What it does:** It kills Telemetry, stops "Microsoft Teams" from starting automatically, and disables the "Search Indexer" that usually grinds your SSD in the background.
    
- **Process Count:** A standard Windows install has ~180-200 processes. An optimized one has ~130.
    

#### 3. Manage "Modern Standby"

Windows 11 loves to stay "half-awake" (Modern Standby) to check for emails while in your bag.1 This is what caused the "15% drain" in the blog you read.

- **The Fix:** In your Power Plan settings, look for **"Network Connectivity in Standby."** Set it to **Disabled**. This forces the laptop to actually stop talking to the Wi-Fi card when the lid is closed.
    

---

### ⚖️ The Final "Windows vs. Linux" Reality

If you do all of the above:

- **Windows 11 Optimized:** You get about **10 hours** of browsing.
    
- **Arch Linux Optimized:** You get about **12 hours** of browsing.
    

**Frankly speaking:** The **2-hour difference** is the "Windows tax." On Windows, the OS will always be slightly heavier. However, for your CS degree, Windows might be "safer" for certain proprietary software your professors might require (though 99% of COMSATS stuff works on Linux).

**Would you like me to find the specific PowerShell command for that Chris Titus debloat tool so you can run it as soon as you get home from Saddar?**

# Switching to Linux
- Assembly is taught you need windows ( vm might work idk )
- linux is fucky ut battery liife is pretty good 
[[Lappy starter kit]]
[[Internal mic not working with headphone plugged in ]]