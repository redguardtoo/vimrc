" Chen Bin's vimrc
" shameless copied from Tsung-Hsiang (Sean) Chang <vgod@vgod.tw>
" Fork me on GITHUB git://github.com/redguardtoo/vimrc.git

" {{ For pathogen.vim: auto load all plugins in .vim/bundle
let g:pathogen_disabled = []

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" }}

" == General Settings ==
set nocompatible " not compatible with the old-fashion vi mode
set bs=2  " allow backspacing over everything in insert mode
set history=1024  " command line history
set ruler  " show the cursor position all the time
set autoread  " auto read when file is changed from outside
set number " show line numbers
set ignorecase " ignore case when searching
" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc,*.elc,*.a,*.lib
set autoindent  " auto indentation
set incsearch  " incremental search
set nobackup  " no *~ backup files
set copyindent  " copy the previous indentation on autoindenting
set smartcase  " ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab  " insert tabs on the start of a line according to context

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb= " never flash the screen
set tm=500

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

set hlsearch  " search highlighting
set tags=./tags;

if has("gui_running") " GUI color and font settings
  set background=dark
  set t_Co=256          " 256 color mode
  " NO menu,toolbar ...
  set guioptions-=m
  set guioptions-=T
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R

  if has("win32")
    "start gvim maximized
    if has("autocmd")
      au GUIEnter * simalt ~x
    endif
  endif
  colorscheme molokai
else
  " terminal color settings
  colorscheme evening
endif

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


" syntastic has some performance impact.
" I don't use it because vi should be light weight

set clipboard=unnamed " yank to the system register (*) by default
set showmatch  " Cursor shows matching ) and }
set showmode  " Show current mode
set wildchar=<TAB> " start wild expansion in the command line using <TAB>
set wildmenu            " wild char completion menu

" {{ TAB setting
set expandtab        "replace <TAB> with spaces
set softtabstop=4
set shiftwidth=4
" }}

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

if has("autocmd")
  autocmd BufNewFile,BufRead *.vb set ft=vbnet
  autocmd BufNewFile,BufRead *.{ps1,psm1,psd1} set ft=ps1
  autocmd BufNewFile,BufRead *.{md,markdown} set ft=markdown
  autocmd BufNewFile,BufRead *.json set ft=javascript
  autocmd BufNewFile,BufRead *.{ftl,jsp} set ft=html
  autocmd BufNewFile,BufRead *.build set ft=xml
  " Support Format-Flowed in email (mutt).
  autocmd FileType mail setlocal fo+=aw tw=72
  " Use TAB only in makefile
  autocmd FileType Makefile set noexpandtab
  " C/C++ specific settings
  autocmd FileType c,cpp,cc  set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30
  " auto reload vimrc when editing it
  autocmd! bufwritepost .vimrc source ~/.vimrc
endif

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo

if has("autocmd")
  au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

  " @see https://www.antagonism.org/privacy/gpg-vi.shtml
  " Transparent editing of GnuPG-encrypted files
  " Based on a solution by Wouter Hanegraaff
  augroup encrypted
    au!
    " First make sure nothing is written to ~/.viminfo while editing
    " an encrypted file.
    autocmd BufReadPre,FileReadPre *.gpg,*.asc set viminfo=
    " We don't want a swap file, as it writes unencrypted data to disk.
    autocmd BufReadPre,FileReadPre *.gpg,*.asc set noswapfile
    " Switch to binary mode to read the encrypted file.
    autocmd BufReadPre,FileReadPre *.gpg set bin
    autocmd BufReadPre,FileReadPre *.gpg,*.asc let ch_save = &ch|set ch=2
    autocmd BufReadPost,FileReadPost *.gpg,*.asc
          \ '[,']!sh -c 'gpg --decrypt 2> /dev/null'
    " Switch to normal mode for editing
    autocmd BufReadPost,FileReadPost *.gpg set nobin
    autocmd BufReadPost,FileReadPost *.gpg,*.asc let &ch = ch_save|unlet ch_save
    autocmd BufReadPost,FileReadPost *.gpg,*.asc
          \ execute ":doautocmd BufReadPost " . expand("%:r")

    " Convert all text to encrypted text before writing
    autocmd BufWritePre,FileWritePre *.gpg set bin
    autocmd BufWritePre,FileWritePre *.gpg
          \ '[,']!sh -c 'gpg --default-recipient-self -e 2>/dev/null'
    autocmd BufWritePre,FileWritePre *.asc
          \ '[,']!sh -c 'gpg --default-recipient-self -e -a 2>/dev/null'
    " Undo the encryption so we are back in the normal text, directly
    " after the file has been written.
    autocmd BufWritePost,FileWritePost *.gpg,*.asc u
  augroup END
endif

" {{ go to SCM conflict marker
map ]] ]n
map [[ [n
" }}
"
" set leader to ,
let mapleader = " " " Leader is the space key
let g:mapleader = " "
let maplocalleader = "`"
let g:maplocalleader = "`"
nnoremap <SPACE> <Nop>

" {{ for merge tool
map <silent> <leader>1 :diffget 1<CR>
map <silent> <leader>2 :diffget 2<CR>
map <silent> <leader>3 :diffget 3<CR>
" }}

" grep result window operation alias
" " Do :help cope if you are unsure what cope is. It's super useful!
nmap ,co :botright copen<cr>
" spell check with aspell
nmap ,fb :w!<CR>:!aspell check %<CR>:e! %<CR>

"Switch to current dir
nmap ,cd :cd %:p:h<cr>
" vcscommand.vim : CVS/SVN/SVK/git/hg/bzr integration plugin
nmap ,vv :VCSAnnotate<cr>
nmap ,va :VCSAdd<cr>

" {{ --- Smart way to move window
"  TIPS:
"  C-W +/- increase/descrease window height
"  C-W _ maxmize window height
"  C-W = restore window size
"  C-W | maxmize window width
set wmw=0 " set the min width of a window to 0 so we can maximize others
set wmh=0 " set the min height of a window to 0 so we can maximize others
" }}

" --- Faster window resize {
"  TIPS:
"  C-W </ > resize window width
if bufwinnr(1)
  " recommend using scroll pad
  map + <C-W>+
  map - <C-W>-
endif
"  }

" new tab
map ,tn :tabnew<CR>
" close tab
map ,tc :tabclose<CR>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

" ,pp toggles paste mode
nmap ,tpp :set paste!<BAR>set paste?<CR>

"---------------------------------------------------------------------------
" PROGRAMMING SHORTCUTS
"---------------------------------------------------------------------------

" Ctrl-[ jump out of the tag stack (undo Ctrl-])
map <C-[> <ESC>:po<CR>

" ,gg generates the header guard
map ,gg :call IncludeGuard()<CR>
fun! IncludeGuard()
  let basename = substitute(bufname(""), '.*/', '', '')
  let guard = '_' . substitute(toupper(basename), '\.', '_', "H")
  call append(0, "#ifndef " . guard)
  call append(1, "#define " . guard)
  call append( line("$"), "#endif // for #ifndef " . guard)
endfun

if has("autocmd") && exists("+omnifunc")
  " Enable omni completion. (Ctrl-X Ctrl-O)
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS

  " use syntax complete if nothing else available
  autocmd FileType *
        \ if &omnifunc == "" |
        \  setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
endif

set cot-=preview "disable doc preview in omnicomplete

if has("autocmd")
  " make CSS omnicompletion work for SASS and SCSS
  autocmd BufNewFile,BufRead *.scss             set ft=scss.css
  autocmd BufNewFile,BufRead *.sass             set ft=sass.css
endif

" {{ ENCODING SETTINGS
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1
" }}

" == PLUGIN ==
" {{ -- AutoClose - Inserts matching bracket, paren, brace or quote
" fixed the arrow key problems caused by AutoClose
if !has("gui_running")
  set term=linux
  imap OA <ESC>ki
  imap OB <ESC>ji
  imap OC <ESC>li
  imap OD <ESC>hi
  nmap OA k
  nmap OB j
  nmap OC l
  nmap OD h
endif
" }}

" taglist
map ,ii :TlistToggle<CR>

" NERDTree
map ,nt :NERDTreeToggle<CR>

" leader hotkeys
nmap ,xs :write<CR>
nmap ,s2 :sp<CR>
nmap ,s3 :vs<CR>
nmap ,s1 <C-W>o
nmap ,s0 :close<CR>
nmap ,x2 :sp<CR>
nmap ,x3 :vs<CR>
nmap ,x1 <C-W>o
nmap ,x0 :close<CR>
nmap ,xf :CtrlP<CR>
nmap ,kk :CtrlP<CR>
nmap ,xb :CtrlPBuffer<CR>
nmap ,hr :CtrlPMRU<CR>
nmap ,gt :CtrlPTag<CR>
nmap <leader>n ]n
nmap <leader>p [n
nmap ,dg1 ]nd]n[ndd[ndd
nmap ,dg2 d]ndd]ndd
nmap <leader>nc ]c
nmap <leader>pc [c
" {{
noremap ,wh <C-W>h
noremap ,wj <C-W>j
noremap ,wk <C-W>k
noremap ,wl <C-W>l
" }}"
nmap ,tr :%s/ \+$//g<CR>
nmap ,cg :CtrlPRoot<CR>
nmap ,xc :suspend<CR>
nmap ,ut :UndotreeToggle<CR>

if !hasmapto("<Plug>ZoomWin")
 nmap <unique> ,ff  <Plug>ZoomWin
endif

" For MRU plugin.
let MRU_Max_Entries = 1024
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'
map ,rr :MRU<CR>

if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor
  "use ag in ctrlp for listing files. lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" {{ vim-textobj-user
call textobj#user#plugin('file', {
      \ 'file': {
      \ 'pattern': '\f\+', 'select': ['af', 'if']
      \ }
      \ })
" }}

" {{ set the 81st column of wide lines...
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)
" }}

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======
exec "set listchars=trail:\uB7,nbsp:~"
set list

" Copy/Paste, can only handle lines
" ',aa' => copy
" ',zz' = paste
" Vim always copy lines!
" Stackoverflow doesn't help.
" let s:uname = system("echo -n \"$(uname)\"")
if has('clipboard')
    vnoremap ,aa "+y
                \:echo 'Selection => clipboard'<cr>
    nnoremap ,aa "+yy
                \:echo 'Line(s) => clipboard'<cr>
    nnoremap ,pp "+p
elseif executable('xclip')
  " Linux
  vnoremap ,aa :w !xclip -selection clipboard -in<CR><CR>
        \:echo 'Selection => clipboard'<CR>
  nnoremap ,aa V:w !xclip -selection clipboard -in<CR><CR>
        \:echo 'Line(s) => clipboard'<cr>
  nnoremap ,zz :silent :r!xclip -selection clipboard -out<CR>
elseif executable('pbcopy')
  " OS X
  vnoremap ,aa :w !pbcopy<CR><CR>
        \:echo 'Selection => clipboard'<CR>
  nnoremap ,aa V:w !pbcopy<CR><CR>
        \:echo 'Line(s) => clipboard'<cr>
  nnoremap ,zz :silent :r!pbpaste<CR>
else
  " windows (cygwin)
  vnoremap ,aa :w !putclip<CR><CR>
        \:echo 'Selection => clipboard'<CR>
  nnoremap ,aa V:w !putclip<CR><CR>
        \:echo 'Line(s) => clipboard'<cr>
  nnoremap ,zz :silent :r!getclip<CR>
endif

let g:DiffModeSync = 1
" should be placed at last
syntax on " syntax highlight

" Local Variables:
" coding: utf-8
" indent-tabs-mode: nil
" tab-width: 2
" End:
" vim: set fenc=utf-8 et ts=2 sts=2 sw=2 foldmethod=marker :
