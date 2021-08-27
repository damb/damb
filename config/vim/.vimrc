set nocompatible              " be iMproved, required
filetype off                  " required

" configure the `Leader` key
nnoremap <SPACE> <Nop>
let mapleader="\<space>"
let maplocalleader="\\"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"
" Keep Plugin commands between vundle#begin/end.

Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-commentary'
"Plugin 'vim-latex/vim-latex'
Plugin 'nvie/vim-flake8'
"Plugin 'plytophogy/vim-virtualenv'
"Plugin 'jceb/vim-orgmode'
Plugin 'christoomey/vim-system-copy'
Plugin 'morhetz/gruvbox'
" Plugin 'fatih/vim-go'
" Plugin 'psf/black'

Plugin 'ycm-core/YouCompleteMe'

"Plugin 'scrooloose/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
" the glaive#Install() should go after the 'call vundle#end()'
" call glaive#Install()
" Glaive codefmt plugin[mappings]
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
"                     :PluginUpdate 
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
"                     auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
" -----------------------------------------------------------------------------
" Switch syntax highlighting on, when the terminal has colors.
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

set incsearch

set encoding=utf8
" spell languages
set spelllang=en,de,es,pl

" converting tabs to spaces  
set showmatch
set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2
set autoindent
      
" maximum linewidth
set tw=79
set wrapmargin=10

" allow per-project .vimrc 
set exrc
set secure

" disable cursor in escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" disable Arrow keys in insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" folding
set foldlevel=1
set foldmethod=indent

" mouse (normal mode, only)
set mouse=n

" increase history size
set history=1000

" ----
" fuzzy file search
"
" - search down into subdirs
" - provides tab-completion for all file-related tasks
set path+=**
" display all matching files when I tab complete
set wildmenu

" Tag jumping
command! MakeTags !ctags -R .

" netrw configuration
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 10
let g:netrw_list_hide=netrw_gitignore#Hide().'.*\.swp$'

" row numbering
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

" ----
" colorscheme
colorscheme gruvbox
set background=dark

" ----
" vim-latex configuration
" set grepprg=grep\ -nH\ $*
" let g:tex_flavor='latex'
" let g:Tex_DefaultTargetFormat='pdf'
" let g:Tex_ViewRule_pdf='zathura --fork'

" ----
" black
" let g:black_linelength=79
" let g:black_virtualenv=expand($HOME)."/.local/pipx/venvs/black"

" ----
" flake8
let g:flake8_cmd=expand($HOME)."/.local/bin/flake8"

" ----
" YCM
" ------
" clangd
"
" References: 
" - https://releases.llvm.org/9.0.0/tools/clang/tools/extra/docs/clangd/Installation.html
"
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
" let g:ycm_clangd_binary_path = exepath("clangd")
