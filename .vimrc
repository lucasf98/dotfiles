set nocompatible
filetype off

" update the runtime path
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/tools/powerline/powerline/bindings/vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'

" install powerline fonts from https://github.com/powerline/fonts
Plugin 'powerline/powerline', { 'rtp' : 'powerline/bindings/vim' }

call vundle#end()

filetype on
filetype plugin indent on

let g:ycm_autoclose_preview_window_after_completion=1
let python_highlight_all=1

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
    set colorcolumn=+1
endif

let g:solarized_termcolors=16
set background=dark
colorscheme solarized

" Use The Silver Searcher (https://github.com/ggreer/the_silver_searcher)
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup
  let g:grep_cmd_opts = '--line-numbers --noheading'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

set clipboard=unnamed
set encoding=utf-8
set number
set title
set wildmenu
set wildmode=full

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

set nowrap                  " turn off automatic line wrapping
set ai                      " set auto-indenting for programming
set noerrorbells            " turn off the bells
set showmatch               " automatically show matching brackets
set incsearch               " enable incremental search
set cindent                 " automatic C program indenting
set ignorecase              " ignore case in searches
set smartcase               " ...unless it contains uppercase letters
set lazyredraw              " do not redraw while executing macros
set shiftwidth=4            " width for auto indent, <<, >>
set tabstop=4               " width for tab stops
set softtabstop=4           " width for soft tab stops tab (tabs while editing)
set expandtab               " uses spaces, not tabs
set backspace=indent,eol,start
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr

set showcmd                 " show command in the last line of the screen
set ruler                   " always show the ruler
set laststatus=2            " always show the status line
set scrolloff=3             " preserve three lines of context

let mapleader=","           " change the leader to be a comma vs slash
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
" Reload Vimrc
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
 " sudo write this
cmap W! w !sudo tee % >/dev/null
" open/close the quickfix window
nmap <leader>c :copen<CR>
nmap <leader>cc :cclose<CR>
vnoremap p <Esc>:let curren_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>
inoremap jk <ESC>
inoremap kj <ESC>
map <F2> @q
map <F3> :noh<CR>

" easier navigation betwen splits - no need for CTRL-W before each
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
imap <c-w> <c-o><c-w>       

" Highlights
hi BadWhitespace ctermbg=red guibg=darkred
hi Folded guibg=grey20 guifg=Cyan ctermbg=DarkBlue ctermfg=Grey
hi Search ctermfg=black ctermbg=yellow

set foldopen=block,mark,percent,quickfix,search,tag,undo

" C/C++ settings
autocmd BufNewFile,BufRead *.c,*.h,*.cpp,*.cxx setlocal foldmethod=syntax
autocmd BufWinLeave *.c,*.h,*.cpp,*.cxx mkview
autocmd BufWinEnter *.c,*.h,*.cpp,*.cxx silent loadview

" Other file type settings
autocmd BufNewFile,BufRead *.m set filetype=matlab
autocmd FileType text setlocal textwidth=79

" Disable long line syntax highlighting for XML files
autocmd BufRead *.xml set synmaxcol=120           

" Python settings
autocmd BufWinLeave *.py mkview
autocmd BufWinEnter *.py silent loadview
autocmd BufNewFile,BufRead *.py
    \ set textwidth=79 |
    \ set autoindent |
    \ set fileformat=unix |
    \ match BadWhitespace /\s\+$/

if filereadable($HOME . "./.vimrc.local")
    source ~/.vimrc.local
endif

