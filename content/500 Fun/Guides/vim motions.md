---
dg-publish: true
tags:
  - guide
  - linux
---


> Normal mode navigation 

hjkl movement
i insert
takes you into insert mode at the start of a line
a get out of insert ahead of cursor
A starts writing after the line instead of the a word
w forward a word(start of word)
b back a word
e forward a word (end of word)

$ end of line ( normal mode ) 0 start of line (doesn't consider indents starts behind indents)(normal mode)
^ start of line (considers indents at start of indent)
f key is dogshit / key as search is significantly better ( n for next entry)
f find key
	f shit (finds every occurence of shit then; goes forward , goes backward)
gg goes to top 
G goes to bottom of document
M goes to middle of screen
zz  makes current line center of screen
d delete (cut)
dw deltes word
dd deltes line
u undo
p paste (like a insert after the caret)
P pastes like i insert before caret
y yanking(copying)

Ctrl r redo
d i w deletes whole word
. repeats last command
Ctrl r redo
yy yanks line
# Visual Mode
v visual mode
V goes into visual mode and selets current line
w forward and other vim motions work aswell

# Macros