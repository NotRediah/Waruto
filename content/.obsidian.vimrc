" ============================================================
"  .obsidian.vimrc — Obsidian Vim Config
"  Requires: Obsidian Vimrc Support plugin
"  https://github.com/esm7/obsidian-vimrc-support
"
"  Place this file at the ROOT of your vault (not inside .obsidian/)
" ============================================================


" ────────────────────────────────────────────────────────────
"  CORE SETTINGS
" ────────────────────────────────────────────────────────────

" Use space as leader key
let mapleader = " "

" Yank to system clipboard
set clipboard=unnamed


" ────────────────────────────────────────────────────────────
"  NAVIGATION — Moving Around Notes
" ────────────────────────────────────────────────────────────

" Move to start / end of line more naturally
nmap H ^
nmap L $
vmap H ^
vmap L $

" Center screen after search jumps (reduces disorientation)
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz

" Navigate between Obsidian panes
exmap focusLeft obcommand editor:focus-left
exmap focusRight obcommand editor:focus-right
exmap focusTop obcommand editor:focus-top
exmap focusBottom obcommand editor:focus-bottom

nmap <C-h> :focusLeft
nmap <C-l> :focusRight
nmap <C-k> :focusTop
nmap <C-j> :focusBottom

" Navigate back / forward in file history (use leader to avoid
" clobbering Vim's native jump list on <C-o> / <C-i>)
exmap goBack obcommand app:go-back
exmap goForward obcommand app:go-forward
nmap <leader><Left> :goBack
nmap <leader><Right> :goForward

" Go back after following a link
nmap gb :goBack


" ────────────────────────────────────────────────────────────
"  FILE & PANE MANAGEMENT
" ────────────────────────────────────────────────────────────

" Open Quick Switcher
exmap quickSwitcher obcommand switcher:open
nmap <leader>o :quickSwitcher

" Open command palette
exmap commandPalette obcommand command-palette:open
nmap <leader>p :commandPalette

" New note
exmap newNote obcommand file-explorer:new-file
nmap <leader>n :newNote

" Close current pane
exmap closePane obcommand workspace:close
nmap <leader>w :closePane

" Split pane right / down
exmap splitRight obcommand workspace:split-vertical
exmap splitDown obcommand workspace:split-horizontal
nmap <leader>v :splitRight
nmap <leader>s :splitDown

" Toggle left sidebar
exmap toggleSidebar obcommand app:toggle-left-sidebar
nmap <leader>e :toggleSidebar


" ────────────────────────────────────────────────────────────
"  SEARCH
" ────────────────────────────────────────────────────────────

" In-file search: native Vim / and ? — works out of the box

" Global search across vault
exmap globalSearch obcommand global-search:open
nmap <leader>f :globalSearch

" Clear search highlight
nmap <leader><Space> :nohl


" ────────────────────────────────────────────────────────────
"  LINKS & WIKI NAVIGATION
" ────────────────────────────────────────────────────────────

" Follow wiki link under cursor
exmap followLink obcommand editor:follow-link
nmap gf :followLink

" Open link in new pane
exmap openLinkNewPane obcommand editor:open-link-in-new-leaf
nmap gF :openLinkNewPane


" ────────────────────────────────────────────────────────────
"  MARKDOWN FORMATTING
" ────────────────────────────────────────────────────────────

" Toggle checkbox [ ] <-> [x]
exmap toggleCheckbox obcommand editor:toggle-checklist-status
nmap <leader>x :toggleCheckbox

" Bold
exmap toggleBold obcommand editor:toggle-bold
nmap <leader>b :toggleBold
vmap <leader>b :toggleBold

" Italic
exmap toggleItalic obcommand editor:toggle-italics
nmap <leader>i :toggleItalic
vmap <leader>i :toggleItalic

" Inline code
exmap toggleCode obcommand editor:toggle-code
nmap <leader>` :toggleCode
vmap <leader>` :toggleCode

" Strikethrough
exmap toggleStrike obcommand editor:toggle-strikethrough
nmap <leader>~ :toggleStrike
vmap <leader>~ :toggleStrike

" Highlight
exmap toggleHighlight obcommand editor:toggle-highlight
nmap <leader>h :toggleHighlight
vmap <leader>h :toggleHighlight

" Insert / wrap link
exmap insertLink obcommand editor:insert-link
nmap <leader>k :insertLink
vmap <leader>k :insertLink

" Indent / unindent list items
exmap indentList obcommand editor:indent-list
exmap unindentList obcommand editor:unindent-list
nmap <Tab> :indentList
nmap <S-Tab> :unindentList


" ────────────────────────────────────────────────────────────
"  HEADINGS
"  Correct command IDs: editor:toggle-heading-N
" ────────────────────────────────────────────────────────────

exmap h1 obcommand editor:toggle-heading-1
exmap h2 obcommand editor:toggle-heading-2
exmap h3 obcommand editor:toggle-heading-3
exmap h4 obcommand editor:toggle-heading-4

nmap <leader>1 :h1
nmap <leader>2 :h2
nmap <leader>3 :h3
nmap <leader>4 :h4


" ────────────────────────────────────────────────────────────
"  VIEW MODES
" ────────────────────────────────────────────────────────────

" Toggle between editing and reading (preview) mode
exmap toggleReadMode obcommand editor:toggle-source
nmap <leader>m :toggleReadMode

" Focus / Zen mode
" NOTE: requires the "Focus Mode" community plugin
" Comment out if you don't have it installed
exmap focusMode obcommand obsidian-focus-mode:toggle-focus-mode
nmap <leader>z :focusMode


" ────────────────────────────────────────────────────────────
"  DAILY NOTES & TEMPLATES
" ────────────────────────────────────────────────────────────

exmap openDailyNote obcommand daily-notes
exmap insertTemplate obcommand insert-template

nmap <leader>d :openDailyNote
nmap <leader>t :insertTemplate


" ────────────────────────────────────────────────────────────
"  SURROUND — Wrap words / selections without a plugin
" ────────────────────────────────────────────────────────────

" Wrap word under cursor in [[ ]] (create wiki link)
nmap <leader>[ ciw[[<C-r>"]]<Esc>

" Wrap word under cursor in backticks (inline code)
nmap <leader>c ciw`<C-r>"`<Esc>

" Wrap visual selection in ** (bold)
" Select text first, then press <leader>B
vmap <leader>B <Esc>`>a**<Esc>`<i**<Esc>


" ────────────────────────────────────────────────────────────
"  QUALITY OF LIFE
" ────────────────────────────────────────────────────────────

" Redo with U (ergonomic alternative to <C-r>)
nmap U <C-r>

" Move line up / down in normal mode
" Note: == (auto-indent) is not supported in Obsidian Vim — omitted
nmap <A-j> :m .+1<CR>
nmap <A-k> :m .-2<CR>

" Move selected lines up / down in visual mode
vmap <A-j> :m '>+1<CR>gv
vmap <A-k> :m '<-2<CR>gv

" Select all
nmap <C-a> ggVG

" Duplicate current line
nmap <leader>dd yyp

" Delete line without yanking to clipboard
nmap <leader>D "_dd

" Paste over selection without overwriting clipboard
vmap <leader>P "_dP


" ────────────────────────────────────────────────────────────
"  GRAPH, BACKLINKS & TAGS
" ────────────────────────────────────────────────────────────

exmap openGraph obcommand graph:open
exmap openLocalGraph obcommand graph:open-local
exmap openBacklinks obcommand backlink:open
exmap openTags obcommand tag-pane:open

nmap <leader>G :openGraph
nmap <leader>gl :openLocalGraph
nmap <leader>bl :openBacklinks
nmap <leader>T :openTags


" ────────────────────────────────────────────────────────────
"  QUICK REFERENCE  (Leader = Space)
" ────────────────────────────────────────────────────────────
"
"  NAVIGATION
"   H / L                Start / end of line
"   gf                   Follow link under cursor
"   gF                   Open link in new pane
"   gb                   Go back (after following link)
"   <leader><Left/Right> Navigate file history
"   <C-h/j/k/l>          Move between panes
"
"  FILES & PANES
"   <leader>o            Quick switcher
"   <leader>p            Command palette
"   <leader>f            Global search
"   <leader>n            New note
"   <leader>w            Close pane
"   <leader>v            Split right
"   <leader>s            Split down
"   <leader>e            Toggle sidebar
"   <leader><Space>      Clear search highlight
"
"  FORMATTING
"   <leader>b            Bold (normal + visual)
"   <leader>i            Italic (normal + visual)
"   <leader>`            Inline code (normal + visual)
"   <leader>~            Strikethrough (normal + visual)
"   <leader>h            Highlight (normal + visual)
"   <leader>k            Insert/wrap link (normal + visual)
"   <leader>x            Toggle checkbox
"   <leader>1/2/3/4      Heading H1–H4
"   <Tab> / <S-Tab>      Indent / unindent list
"
"  SURROUND
"   <leader>[            Wrap word in [[ ]] (wiki link)
"   <leader>c            Wrap word in ` (code)
"   <leader>B            Wrap selection in ** (bold, visual mode)
"
"  VIEWS & TOOLS
"   <leader>m            Toggle read / edit mode
"   <leader>z            Focus / Zen mode (requires plugin)
"   <leader>d            Open daily note
"   <leader>t            Insert template
"   <leader>G            Global graph
"   <leader>gl           Local graph
"   <leader>bl           Backlinks panel
"   <leader>T            Tags panel
"
"  MISC
"   <leader>dd           Duplicate line
"   <leader>D            Delete line (no clipboard)
"   <leader>P            Paste over selection (no clipboard overwrite)
"   <A-j/k>              Move line up / down
"   <C-a>                Select all
"   U                    Redo
" ============================================================