if v:progname == 'vi'
  set noloadplugins
endif

nnoremap <SPACE> <Nop>
let mapleader="\<Space>"
let maplocalleader="\\"

if &loadplugins
  if has('packages')
    packadd! vim-commentary
    packadd! gruvbox
    packadd! termdebug
  else
    source $HOME/.vim/pack/bundle/opt/vim-pathogen/autoload/pathogen.vim
    call pathogen#infect('pack/bundle/opt/{}')
  endif
endif


" Automatic, language-dependent indentation, syntax coloring and other
" functionality.
"
" Must come *after* the `:packadd!` calls above otherwise the contents of
" package "ftdetect" directories won't be evaluated.
filetype indent plugin on
if &t_Co > 2 || has("gui_running")
  " Syntax highlighting
  syntax on
  " Highlighting the last used search pattern
  set hlsearch
endif

" colorscheme
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark
