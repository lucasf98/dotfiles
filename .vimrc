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

set nowrap                              " turn off automatic line wrapping
set ai                                  " set auto-indenting for programming
set vb                                  " turn on the visual bell
set showmatch                           " automatically show matching brackets
set nocp 
set incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent
set ignorecase
set smartcase
set autowrite
set shiftwidth=4
set tabstop=4
set softtabstop=4
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

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
inoremap <C-w> <C-o><C-w>

highlight BadWhitespace ctermbg=red guibg=darkred

" Some Abbreviations
iab 'h   '' 
hi Folded guibg=grey20 guifg=Cyan ctermbg=DarkBlue ctermfg=Grey
hi Search ctermfg=black ctermbg=yellow
set foldopen=block,mark,percent,quickfix,search,tag,undo

" C/C++ settings
autocmd BufNewFile,BufRead *.c,*.h,*.cpp,*.cxx setlocal foldmethod=syntax
autocmd BufWinLeave *.c,*.h,*.cpp,*.cxx mkview
autocmd BufWinEnter *.c,*.h,*.cpp,*.cxx silent loadview

autocmd BufNewFile,BufRead *.m set filetype=matlab
autocmd BufNewFile,BufRead *.gtf,*.tpf,*.vbs,*.vbinc set filetype=vb
autocmd FileType text setlocal textwidth=78
autocmd BufNewFile *.vbinc,*.vbs,*.gtf,*.tpf set fileformat=dos

" Python settings
autocmd BufWinLeave *.py mkview
autocmd BufWinEnter *.py silent loadview
autocmd BufNewFile,BufRead *.py
    \ set textwidth=79 |
    \ set autoindent |
    \ set fileformat=unix |
    \ match BadWhitespace /\s\+$/
