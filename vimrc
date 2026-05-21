" VIM VERSION CHECK (Requires Vim 9.1+)
if v:version < 901
  echohl ErrorMsg
  echom " Your Vim version (" . (v:version / 100) . "." . (v:version % 100) . ") is too old!"
  echom " This vimrc requires Vim 9.1+ to run properly."
  echom " Remaining configuration has been skipped to prevent errors."
  echohl None
  finish
endif

" set leader to comma key
let mapleader = ","
nnoremap <SPACE> <Nop>

"  not compatible with the old-fashion vi mode
set nocompatible
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" command line history
set history=1024
" show the cursor position all the time
set ruler
" auto read when file is changed from outside
set autoread
" show line numbers
set number
" ignore case when searching
set ignorecase
" ignore directories
set wildignore+=*/node_modules/*,*/tmp/*
" auto indentation
set autoindent
" copy the previous indentation
set copyindent
" incremental search
set incsearch
" no *~ backup files
set nobackup
" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smartcase
" insert tabs on the start of a line according to context
set smarttab

filetype plugin indent on

if has("gui_running")
  set background=dark
  " NO menu,toolbar ...
  set guioptions-=m
  set guioptions-=T
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R
endif


" Enable true-color (24-bit RGB) in terminal if supported (highly recommended)
if has('termguicolors')
  set termguicolors
else
  " Force 256-color mode for legacy terminals
  set t_Co=256
endif

" {{ RANDOM COLORCOLOUR VARIANT LOADER
" Define your pre-installed pool of colorschemes
let s:my_themes = ['molokai', 'moria', 'peaksea', 'vgod', 'wombat256']
let s:seconds = split(reltimestr(reltime()), '\.')[1]
let s:rand_index = str2nr(s:seconds) % len(s:my_themes)
let s:chosen_theme = s:my_themes[s:rand_index]
" Ensure background flavor is established before the colorscheme kicks in
set background=dark
" Defensive execution: Only apply if the chosen theme file actually exists
if !empty(globpath(&rtp, 'colors/' . s:chosen_theme . '.vim'))
  execute 'colorscheme ' . s:chosen_theme
else
  " Emergency fallback if the directory layout is completely missing
  colorscheme default
endif
" }}

" GUI-Only Settings (Clean up menu, toolbar, and scrollbars in gVim)
if has("gui_running")
  set guioptions-=m  " Remove menu bar
  set guioptions-=T  " Remove toolbar
  set guioptions-=l  " Remove left scrollbar
  set guioptions-=L  " Remove left scrollbar (with vertical split)
  set guioptions-=r  " Remove right scrollbar
  set guioptions-=R  " Remove right scrollbar (with vertical split)
endif

" enable vim9.1+ built in plugin, gcc or gc{motion}
packadd comment

" {{ vim-easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nnoremap ;; <Plug>(easymotion-s2)
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
" type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1
" }}

" Cursor shows matching ) and }
set showmatch
" Show current mode
set showmode
" start wild expansion in the command line using <TAB>
set wildchar=<TAB>
" wild char completion menu
set wildmenu

" {{ status line
set laststatus=2
" window-number file-name encoding format
set statusline=W:%{winnr()}\ %t\ [%{&fenc!=''?&fenc:'none'},%{&ff}]
" help file flag
set statusline+=%h
" modified flag
set statusline+=%m
" read only flag
set statusline+=%r
" filetype
set statusline+=%y
" left/right separator
set statusline+=%=
" cursor column
set statusline+=%c
" }}

augroup my_filetypes
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd FileType vim setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
augroup END

" {{ for merge tool
nnoremap <silent> <SPACE>1 :diffget 1<CR>
nnoremap <silent> <SPACE>2 :diffget 2<CR>
nnoremap <silent> <SPACE>3 :diffget 3<CR>
" }}

" {{ go to SCM conflict marker
nnoremap <SPACE>n ]n
nnoremap <SPACE>p [n
" }}

" grep result window operation alias
" " Do :help cope if you are unsure what cope is. It's super useful!
nnoremap <leader>co :botright copen<cr>

" toggle spell check
nnoremap <leader>fb :setlocal spell!<CR>
nnoremap <leader>fe ]s
"Switch to current dir
nnoremap <leader>cd :cd %:p:h<cr>

" {{ --- Smart way to move window
"  TIPS:
"  C-W +/- increase/decrease window height
"  C-W _ maxmize window height
"  C-W = restore window size
"  C-W | maxmize window width
" set the min width of a window to 0 so we can maximize others
set wmw=0
" set the min height of a window to 0 so we can maximize others
set wmh=0
" }}

" new tab
nnoremap <leader>tn :tabnew<CR>
" close tab
nnoremap <leader>tc :tabclose<CR>

" toggles paste mode
nnoremap <leader>tpp :set paste!<BAR>set paste?<CR>

" vim-fugitive
nnoremap <leader>vm :Git blame<cr>
nnoremap <leader>va :Gwrite<cr>

set encoding=utf-8

" {{ tagbar
nnoremap <leader>ii :TagbarToggle<CR>
let g:tagbar_position = 'left'
" }}

" {{ file explorer
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
nnoremap <leader>nt :Lexplore<CR>
" }}

" leader hotkeys
nnoremap <leader>xs :write<CR>
nnoremap <leader>s2 :sp<CR>
nnoremap <leader>s3 :vs<CR>
nnoremap <leader>s1 <C-W>o
nnoremap <leader>s0 :close<CR>
nnoremap <leader>x2 :sp<CR>
nnoremap <leader>x3 :vs<CR>
nnoremap <leader>x1 <C-W>o
nnoremap <leader>x0 :close<CR>

" search files
nnoremap <leader>xf :FuzzyFiles<CR>
" search file from project root
nnoremap <leader>kk :FuzzyFilesRoot<CR>
" switch buffer
nnoremap <leader>xb :FuzzyBuffers<CR>
" search tag tags file of project root  (Universal Ctags needed)
nnoremap <leader>ft :FuzzyTagsRoot<CR>
nnoremap <leader>gf :FuzzyGitFiles<CR>
nnoremap <leader>gg :FuzzyGitGrep<CR>
nnoremap <leader>rr :FuzzyMru<CR>
nnoremap <leader>yy :FuzzyRegisters<CR>

" {{ move focus between sub-windows
noremap <leader>wh <C-W>h
noremap <leader>wj <C-W>j
noremap <leader>wk <C-W>k
noremap <leader>wl <C-W>l
" }}

" remove trailing spaces
nnoremap <leader>tr :%s/ \+$//g<CR>

" suspend
nnoremap <leader>xc :suspend<CR>

" save&quit
nnoremap <SPACE>xc :xa<CR>

if !hasmapto("<Plug>ZoomWin")
  nmap <unique> ,ff  <Plug>ZoomWin
endif

" set the 81st column of wide lines...
set colorcolumn=81

set wrap
set linebreak
nnoremap j gj
nnoremap k gk

" {{ Cross-Platform Clipboard (Optimized for 64-bit Windows, WSL, Linux, macOS)
" Fixes the old bug where only entire lines could be copied.
" Supports precise character, visual block, and line selection.
if has('win64')
  " 1. Native Windows 64-bit environment (32-bit ignored)
  set clipboard=unnamed,unnamedplus
  vnoremap <leader>aa "+y:echo 'Selection => Windows Clipboard'<CR>
  nnoremap <leader>aa "+yy:echo 'Line => Windows Clipboard'<CR>
  nnoremap <leader>pp "+p

elseif executable('clip.exe')
  " 2. WSL (Windows Subsystem for Linux) environment
  " Copy: Yank to unnamed register first, then pipe exact selection to clip.exe
  vnoremap <leader>aa y:call system('clip.exe', @")<CR>:echo 'Selection => Win Clipboard via WSL'<CR>
  nnoremap <leader>aa yy:call system('clip.exe', @")<CR>:echo 'Line => Win Clipboard via WSL'<CR>
  " Paste: Retrieve Windows clipboard via powershell safely to preserve indentation
  nnoremap <leader>pp :set paste<CR>:let @" = system('powershell.exe -NoProfile -Command "Get-Clipboard"')<CR>p:set nopaste<CR>

elseif has('clipboard')
  " 3. Linux/macOS environments with native +clipboard support
  vnoremap <leader>aa "+y:echo 'Selection => Clipboard'<CR>
  nnoremap <leader>aa "+yy:echo 'Line => Clipboard'<CR>
  nnoremap <leader>pp "+p

elseif executable('xclip')
  " 4. Linux terminal fallback (No native +clipboard feature)
  vnoremap <leader>aa y:call system('xclip -selection clipboard -in', @")<CR>:echo 'Selection => Clipboard'<CR>
  nnoremap <leader>aa yy:call system('xclip -selection clipboard -in', @")<CR>:echo 'Line => Clipboard'<CR>
  nnoremap <leader>pp :set paste<CR>:let @" = system('xclip -selection clipboard -out')<CR>p:set nopaste<CR>

elseif executable('pbcopy')
  " 5. macOS terminal fallback
  vnoremap <leader>aa y:call system('pbcopy', @")<CR>:echo 'Selection => Clipboard'<CR>
  nnoremap <leader>aa yy:call system('pbcopy', @")<CR>:echo 'Line => Clipboard'<CR>
  nnoremap <leader>pp :set paste<CR>:let @" = system('pbpaste')<CR>p:set nopaste<CR>
endif
" }}

" toggle highlighted items
nnoremap <expr> <SPACE>hl v:hlsearch ? ':nohlsearch<CR>' : ':set hlsearch<CR>'

" {{ADVANCED DIFF SETTINGS
let g:DiffModeSync = 1
" Force vertical layouts for diffsplit
set diffopt+=vertical
" Enable superior Xdiff algorithms (Native in Vim 8.1.0360+ & Neovim)
" - algorithm:histogram  -> Smarter block matching (less chaotic alignment)
" - indent-heuristic     -> Aligns diffs based on code indent structures
set diffopt+=algorithm:histogram
set diffopt+=indent-heuristic
" }}

" {{ vim-expand-region
vmap v <Plug>(expand_region_expand)
" }}

" {{ move between sub-window
nnoremap <leader>1 :execute "1wincmd w"<CR>
nnoremap <leader>2 :execute "2wincmd w"<CR>
nnoremap <leader>3 :execute "3wincmd w"<CR>
nnoremap <leader>4 :execute "4wincmd w"<CR>
nnoremap <leader>5 :execute "5wincmd w"<CR>
nnoremap <leader>6 :execute "6wincmd w"<CR>
nnoremap <leader>7 :execute "7wincmd w"<CR>
nnoremap <leader>8 :execute "8wincmd w"<CR>
nnoremap <leader>9 :execute "9wincmd w"<CR>
nnoremap <leader>xo <Plug>(choosewin)
" }}

" should be placed at the very end
syntax on " syntax highlight
