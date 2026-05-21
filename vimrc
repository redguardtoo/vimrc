" {{ For pathogen.vim: auto load all plugins in .vim/bundle
execute pathogen#infect()
" }}

" not compatible with the old-fashion vi mode
set nocompatible
 "allow backspacing over everything in insert mode
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

" {{ vim-expand-region
map <leader>xx <Plug>(expand_region_expand)
" }}

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

" yank to the system register (*) by default
set clipboard=unnamed
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
" spell check with aspell
nmap <leader>fb :setlocal spell spelllang=en_us
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

" {{ ENCODING SETTINGS
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1
" }}

" {{ tagbar
map <leader>ii :TagbarToggle<CR>
let g:tagbar_position = 'left'
" }}

" NERDTree
map <leader>nt :NERDTreeToggle<CR>

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
nmap <leader>xf :CtrlP<CR>
" search file from project root
nmap <leader>kk :CtrlPRoot<CR>
" switch buffer
nmap <leader>xb :CtrlPBuffer<CR>
nmap <leader>gt :CtrlPTag<CR>

" {{ move focus between sub-windows
noremap <leader>wh <C-W>h
noremap <leader>wj <C-W>j
noremap <leader>wk <C-W>k
noremap <leader>wl <C-W>l
" }}

" YankRing
nmap <leader>yy :YRShow<CR>
let g:yankring_replace_n_pkey = ''
let g:yankring_replace_n_nkey = ''
" @see https://github.com/neovim/neovim/issues/2642#issuecomment-218232937
let g:yankring_clipboard_monitor = 0

" remove trailing spaces
nmap <leader>tr :%s/ \+$//g<CR>


" suspend
nmap <leader>xc :suspend<CR>

" undotree
nmap <leader>ut :UndotreeToggle<CR>

if !hasmapto("<Plug>ZoomWin")
 nmap <unique> ,ff  <Plug>ZoomWin
endif

" MRU (recent files)
let MRU_Max_Entries = 1024
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*\|.*/.git/.*'
map <leader>rr :MRU<CR>

" {{ set the 81st column of wide lines...
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
" }}

" Copy/Paste, can only handle lines
" ',aa' => copy
" ',zz' = paste
" Vim always copy lines!
" Stackoverflow doesn't help.
" let s:uname = system("echo -n \"$(uname)\"")
if has('clipboard')
    vnoremap <leader>aa "+y
                \:echo 'Selection => clipboard'<cr>
    nnoremap <leader>aa "+yy
                \:echo 'Line(s) => clipboard'<cr>
    nnoremap <leader>pp "+p
elseif executable('xclip')
  " Linux
  vnoremap <leader>aa :w !xclip -selection clipboard -in<CR><CR>
        \:echo 'Selection => clipboard'<CR>
  nnoremap <leader>aa V:w !xclip -selection clipboard -in<CR><CR>
        \:echo 'Line(s) => clipboard'<cr>
  nnoremap <leader>pp :silent :r!xclip -selection clipboard -out<CR>
elseif executable('pbcopy')
  " OS X
  vnoremap <leader>aa :w !pbcopy<CR><CR>
        \:echo 'Selection => clipboard'<CR>
  nnoremap <leader>aa V:w !pbcopy<CR><CR>
        \:echo 'Line(s) => clipboard'<cr>
  nnoremap <leader>pp :silent :r!pbpaste<CR>
endif

let g:DiffModeSync = 1
" should be placed at last
syntax on " syntax highlight

" vertical diffsplit
set diffopt+=vertical
" better diff algorithm from xdiff
" code checked into vim repo in c93262b2e
" @see https://vimways.org/2018/the-power-of-diff/
" @see https://raw.githubusercontent.com/ashfinal/vimrc-config/master/.vimrc
if has("nvim-0.3.5")
  set diffopt+=algorithm:histogram
  set diffopt+=indent-heuristic
endif

" {{ vim-expand-region
vmap v <Plug>(expand_region_expand)
" }}
