if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'
Plugin 'scrooloose/nerdtree'

call vundle#end()
filetype plugin indent on

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

let python_highlight_all=1

if has('gui_running')
    set background=dark
    colorscheme solarized
else
    colorscheme zenburn
endif

set clipboard=unnamed
set encoding=utf-8
set nu

" turn off automatic line wrapping...one line is one line!
set nowrap
" set auto-indenting for programming
set ai
" turn on the visual bell
set vb
" automatically show matching brackets
set showmatch
" C programming formatting options
set nocp incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent
set ignorecase
set smartcase
set autowrite
set sw=4
set tabstop=4
set expandtab
set backspace=indent,eol,start
set showcmd
set ruler
set synmaxcol=120

vnoremap p <Esc>:let curren_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>
inoremap jk <ESC>
inoremap kj <ESC>
map <F2> @q
map <F3> :noh<CR>

highlight BadWhitespace ctermbg=red guibg=darkred

" Some Abbreviations
iab #b /*************************************************************
iab #e *************************************************************/
iab #l /************************************************************/

iab 'l   '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
iab 'i   '~~~~~~~~~~~~~~~~~~~ Intel Confidential ~~~~~~~~~~~~~~~~~~~~~~
iab 'h   '' 
iab xpg	 public property get
iab xpl	 public property let
iab xps	 public property set
iab xpf  public function
iab xpb  public sub
iab xef  end function
iab xeb  end sub
iab xei  end if
iab xep  end property
iab xec  end class
iab xfn  ^dwifor pi =ea toonext 'p==k==o
iab xif  ^d$iif (pi) thenend if 'p==k==o
iab xife ^d$iif (pi) thenelseend if '(pi)==k==k==o
iab xw   ^d$ido while (pi)loop 'while (pi)==k==o
iab xu   ^d$ido until (pi)loop 'until (pi)==k==o
iab xdw  ^d$idoloop while (pi)==k==o
iab xdu  ^d$idoloop until (pi)==k==o
iab frul 98765432109876543210987654321098765432100yWOpa3333333333222222222211111111110000000000bj
hi Folded guibg=grey20 guifg=Cyan ctermbg=DarkBlue ctermfg=Grey
hi Search ctermfg=black ctermbg=yellow
set foldopen=block,mark,percent,quickfix,search,tag,undo
autocmd BufNewFile,BufRead *.c,*.h,*.cpp,*.cxx,*.vbs,*.vbinc setlocal foldmethod=syntax
autocmd BufWinLeave *.c,*.h,*.cpp,*.cxx,*.v*,*.py mkview
autocmd BufWinEnter *.c,*.h,*.cpp,*.cxx,*.v*,*.py silent loadview
autocmd BufNewFile,BufRead *.m set filetype=matlab
autocmd BufNewFile,BufRead *.gtf,*.tpf,*.vbs,*.vbinc set filetype=vb
autocmd FileType text setlocal textwidth=78
autocmd BufNewFile *.vbinc,*.vbs,*.gtf,*.tpf set fileformat=dos

autocmd BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ match BadWhitespace /\s\+$/

filetype plugin indent on
