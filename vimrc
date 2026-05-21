" VIM VERSION CHECK (Requires Vim 9.1+)
if v:version < 901
    echohl ErrorMsg
    echom " Your Vim version (" . (v:version / 100) . "." . (v:version % 100) . ") is too old!"
    echom " This vimrc requires Vim 9.1+ to run properly."
    echom " Remaining configuration has been skipped to prevent errors."
    echohl None
    finish
endif

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
  set t_Co=256          " 256 color mode
  " NO menu,toolbar ...
  set guioptions-=m
  set guioptions-=T
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R
  colorscheme molokai
endif

" Force 256-color mode for legacy terminals
set t_Co=256

" Enable true-color (24-bit RGB) in terminal if supported (highly recommended)
if has('termguicolors')
  set termguicolors
endif

" Set background variant before loading the colorscheme
set background=dark

" Safely apply color scheme
if !empty(globpath(&rtp, 'colors/molokai.vim'))
  colorscheme molokai
endif

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
nmap ;; <Plug>(easymotion-s2)
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

" status line {
set laststatus=2
set statusline=%-10.3n  "buffer number
set statusline+=%t       "tail of the filename
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c      "cursor column
set statusline+=\ %P    "percent through file
"}

augroup my_filetypes
  autocmd!
  autocmd FileType make setlocal noexpandtab
augroup END

" set leader to comma key
let mapleader = ","
nnoremap <SPACE> <Nop>

" {{ for merge tool
map <silent> <SPACE>1 :diffget 1<CR>
map <silent> <SPACE>2 :diffget 2<CR>
map <silent> <SPACE>3 :diffget 3<CR>
" }}

" {{ go to SCM conflict marker
map <SPACE>n ]n
map <SPACE>p [n
" }}

" grep result window operation alias
" " Do :help cope if you are unsure what cope is. It's super useful!
nmap <leader>co :botright copen<cr>

" toggle spell check
nmap <leader>fb :setlocal spell!<CR>
nmap <leader>fe ]s
"Switch to current dir
nmap <leader>cd :cd %:p:h<cr>

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
map <leader>tn :tabnew<CR>
" close tab
map <leader>tc :tabclose<CR>

" toggles paste mode
nmap <leader>tpp :set paste!<BAR>set paste?<CR>

" vim-fugitive
nmap <leader>vm :Git blame<cr>
nmap <leader>va :Gwrite<cr>

set encoding=utf-8

" {{ tagbar
map <leader>ii :TagbarToggle<CR>
let g:tagbar_position = 'left'
" }}

" {{ file explorer
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
nmap <leader>nt :Lexplore<CR>
" }}

" leader hotkeys
nmap <leader>xs :write<CR>
nmap <leader>s2 :sp<CR>
nmap <leader>s3 :vs<CR>
nmap <leader>s1 <C-W>o
nmap <leader>s0 :close<CR>
nmap <leader>x2 :sp<CR>
nmap <leader>x3 :vs<CR>
nmap <leader>x1 <C-W>o
nmap <leader>x0 :close<CR>

" search files
nmap <leader>xf :FuzzyFiles<CR>
" search file from project root
nmap <leader>kk :FuzzyFilesRoot<CR>
" switch buffer
nmap <leader>xb :FuzzyBuffers<CR>
" search tag tags file of project root  (Universal Ctags needed)
nmap <leader>ft :FuzzyTagsRoot<CR>
nmap <leader>gf :FuzzyGitFiles<CR>
nmap <leader>gg :FuzzyGitGrep<CR>
nmap <leader>rr :FuzzyMru<CR>
nmap <leader>yy :FuzzyRegisters<CR>

" {{ move focus between sub-windows
noremap <leader>wh <C-W>h
noremap <leader>wj <C-W>j
noremap <leader>wk <C-W>k
noremap <leader>wl <C-W>l
" }}

" remove trailing spaces
nmap <leader>tr :%s/ \+$//g<CR>

" suspend
nmap <leader>xc :suspend<CR>

" undotree
nmap <leader>ut :UndotreeToggle<CR>

if !hasmapto("<Plug>ZoomWin")
 nmap <unique> ,ff  <Plug>ZoomWin
endif

" {{ set the 81st column of wide lines...
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
" }}

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

" should be placed at the very end
syntax on " syntax highlight
