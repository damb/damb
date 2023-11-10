scriptencoding utf-8

set autoindent
set backupcopy=yes

set nobackup
set nowritebackup

" But in case backups ever get turned on ...
" keep backup files out of the way
set backupdir=~/.vim/backup//
set backupdir+=.

" highlight current line
set cursorline

set noswapfile
" But in case swapfiles ever get turned on ...
" keep swap files out of the way
set directory=~/.vim/swap//
set directory+=.

if has('persistent_undo')
  if exists('$SUDO_USER')
  " don't create root-owned files
    set noundofile
  else
   " keep undo files out of the way
    set undodir=~/.vim/undo//
    set undodir+=.
    " actually use undo files
    set undofile
  endif
endif

" convert tabs to spaces
" --
set expandtab
" spaces per tab (when shifting)
set shiftwidth=2
set softtabstop=2
" spaces per tab
set tabstop=2

set encoding=utf8

" folding
if has('folding')
  set foldlevel=1
  set foldmethod=indent
endif

" increase history size
set history=10000

set hidden

set incsearch

" always enable the status line
set laststatus=2

" mouse (normal mode, only)
set mouse=n

if exists('+pumblend')
  " pseudo-transparency for popup-menu
  set pumblend=10
endif

if has('termguicolors')
  " use guifg/guibg instead of ctermfg/ctermbg in terminal
  set termguicolors
endif

if has('wildignore')
  " patterns to ignore during file-navigation
  set wildignore+=*.o,*.so
endif
if has('wildmenu')
  " fuzzy file search
  set wildmenu
  set path+=**
endif

set number
if exists('+relativenumber')
  " show relative numbers in the gutter
  set relativenumber
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
  augroup END
endif

set shell=sh
set showmatch
set sidescroll=0
set sidescrolloff=3
set smarttab
" spell languages
set spelllang=en,de,es,pl

if has('windows')
  " open horizontal splits below current window
  set splitbelow
  " open vertical splits to the right of the current window
  set splitright
endif

" maximum linewidth
set textwidth=80

" update swapfiles every 80 typed chars
set updatecount=80

" faster completion
set updatetime=50

set wrapmargin=10
