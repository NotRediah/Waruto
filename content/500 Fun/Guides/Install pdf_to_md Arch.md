---
dg-publish: true
source: https://chatgpt.com/c/690c2f9b-c910-8322-8f05-6ef1f87cdb3b
tags:
  - guide
  - linux
---
://github.com/M1ck4/pdf\_to\_md i am trying to install this on arch linux these are the steps i followed pipx install pymupdf # Clone the repository git clone https://github.com/M1ck4/pdf\_to\_md.git cd pdf\_to\_md and this is the error i get when i try to run it via this command ( python pdf\_to\_md.py ) ◎ python pdf\_to\_md.py □ pdf\_to\_md △⎪●◦⎥ py ⌉⌊ 3.13.7 10:17 Traceback (most recent call last): File "/home/zg/pdf\_to\_md/pdf\_to\_md.py", line 39, in <module> import tkinter as tk File "/usr/lib/python3.13/tkinter/\_\_init\_\_.py", line 38, in <module> import \_tkinter # If this fails your Python may not be configured for Tk ^^^^^^^^^^^^^^^ ImportError: libtk8.6.so: cannot open shared object file: No such file or directory

2/2

---

That error means your **Python installation doesn’t have Tkinter’s C library (libtk8.6)** available — it’s missing the system-level **Tk and Tcl** packages that provide the GUI backend.

On **Arch Linux**, Tkinter support isn’t bundled by default, so you need to install the correct system packages.

---

### 🧰 Fix: Install Tk and Tcl

Run this in your terminal:

This installs both `tk` and its dependency `tcl`, which includes the `libtk8.6.so` shared library that Tkinter needs.

---

### ✅ Then test again:

After installation, verify Tkinter works:

If a small empty GUI window appears, Tkinter is now working.

---

### 💡 Then re-run your script:

It should now start without the import error.

---

Would you like me to show you how to install it **system-wide** (so you can just run `pdf_to_md` from anywhere) instead of using `python pdf_to_md.py` each time?

---

Input: /home/zg/Downloads/ntsamplepaper-nat-IM.pdf Output: /home/zg/Downloads/test.md Options → CAPS→Headings=True, Defragment=True, HeadingRatio=1.15, OrphanLen=45, PageBreaks=False, RemoveHF=True, ExportImages=False, PreviewOnly=False ✖ Error: PyMuPDF (fitz) is not installed. Install with: pip install pymupdf getting this error in the app even though i installed it with pipx here is proof ○ pymupdf ⌂ 10:25 usage: pymupdf \[-h\] {show,clean,join,extract,embed-info,embed-add,embed-del,embed-upd,embed-extract,embed-copy,gettext,internal}... ------------------------- Basic PyMuPDF Functions ------------------------- options: -h, --help show this help message and exit Subcommands: {show,clean,join,extract,embed-info,embed-add,embed-del,embed-upd,embed-extract,embed-copy,gettext,internal} Enter 'command -h' for subcommand specific help ◎

---

Good — that tells us exactly what’s going on.  
The issue isn’t with **PyMuPDF itself**, but **where** it’s installed.

Let’s unpack this:

---

### 🧩 What’s happening

- You installed `pymupdf` with **pipx** → that means it lives in an *isolated environment*, not in your main Python interpreter.
- When you run:
	it uses your **system Python (3.13)** — which **does not have pymupdf installed**.

So the script doesn’t see it.

---

### ✅ Fix Options

#### Option 1 — Install pymupdf into your system Python

This is the simplest fix:

If you’re on Arch and using Python 3.13, you can verify pip matches your version:

Then rerun:

---

#### Option 2 — Run it inside pipx (less ideal here)

Since `pdf_to_md.py` isn’t itself installed as a pip package, `pipx` isolation doesn’t help much — it’s meant for full tools, not local scripts.  
So, **Option 1 is better.**

---

#### Option 3 — (Optional) Use a virtual environment

If you want to keep things clean:

---

### 💡 Quick sanity check

After installing, test PyMuPDF manually:

If it prints a short description, you’re good.

---

Would you like me to show how to add a simple `pdf_to_md` **CLI wrapper** so you can just run:

from anywhere, instead of `python pdf_to_md.py`?

---

i don't have pip

---

Got it 👍 — that’s easy to fix on **Arch Linux**.  
Python comes preinstalled, but `pip` is often a separate package.

---

### 🧰 Step 1 — Install pip

Run this:

That gives you the correct version of `pip` for your Python (3.13).

---

### 🧩 Step 2 — Verify pip works

Check it with:

or safer:

You should see something like:

---

### 🧠 Step 3 — Install PyMuPDF for system Python

Now install the missing dependency:

You can confirm it’s installed:

---

### ✅ Step 4 — Run your tool again

It should now detect `PyMuPDF (fitz)` correctly and run.

---

Would you like me to make it so you can run the script just by typing `pdf_to_md` (without needing to cd into the folder)?

---

◄ 2s ⋈┈○ pip install pymupdf ⌂ 10:27 error: externally-managed-environment × This environment is externally managed ╰─> To install Python packages system-wide, try 'pacman -S python-xyz', where xyz is the package you are trying to install. If you wish to install a non-Arch-packaged Python package, create a virtual environment using 'python -m venv path/to/venv'. Then use path/to/venv/bin/python and path/to/venv/bin/pip. If you wish to install a non-Arch packaged Python application, it may be easiest to use 'pipx install xyz', which will manage a virtual environment for you. Make sure you have python-pipx installed via pacman. note: If you believe this is a mistake, please contact your Python installation or OS distribution provider. You can override this, at the risk of breaking your Python installation or OS, by passing --break-system-packages. hint: See PEP 668 for the detailed specification. ◄ 6s ⋈┈○

---

Perfect — that’s Arch Linux doing its job 👏

Arch enforces **PEP 668**, which protects system Python from being modified by `pip`.  
You have **three clean options** to fix this — here’s the breakdown:

---

### 🩵 Option 1 — Use a Virtual Environment (Recommended)

This keeps things clean and avoids touching system Python.

✅ Advantages

- No root needed
- Safe from Arch package conflicts
- Works exactly like a normal Python environment

Each time you want to use it:

You can exit the venv anytime with:

---

### 🩶 Option 2 — Use pip with --break-system-packages (Not ideal)

If you really want to install globally:

⚠️ Warning: This modifies the Arch-managed Python install.  
Only do this if you understand the risks (it can interfere with pacman-managed Python packages).

---

### 🩷 Option 3 — Use pipx properly

You can install `pdf_to_md` itself via `pipx` and let it handle isolation automatically:

Then you’ll be able to just run:

from anywhere on your system.

---

💡 **Recommended for you:**  
Since you already cloned the repo and are testing it manually, **Option 1 (virtual environment)** is the cleanest, most Arch-friendly approach.

Would you like me to make a one-liner script (`run_pdf_to_md.sh`) that automatically activates the venv and runs the converter with your input/output paths?