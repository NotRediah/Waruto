---
dg-publish: true
tags:
  - guide
source: https://github.com/M1ck4/pdf_to_md
---
- [x] make a script that does it for you ✅ 2025-11-16

# Create the virtual environment so pip is allowed to run
```
cd ~/pdf_to_md
python -m venv venv
source venv/bin/activate
pip install pymupdf
python pdf_to_md.py
```

>*note pipx doesn't work in this context because it's isolated and pdf_to_md.py is just a file not available on pipx

# Stopping
```
deactivate
```
# Reusing it afterwards
```
cd ~/pdf_to_md
source venv/bin/activate
python pdf_to_md.py
```