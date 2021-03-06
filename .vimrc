set nocompatible
filetype off

" Plugins {{{
" 
" First, install Vundle:
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/tools/powerline/powerline/bindings/vim

call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'vim-scripts/indentpython.vim'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
"Plugin 'kien/ctrlp.vim'

" install powerline fonts from https://github.com/powerline/fonts
Plugin 'powerline/powerline', { 'rtp' : 'powerline/bindings/vim' }

call vundle#end()

filetype on
filetype plugin indent on
" }}}

" Highlights and Colors {{{
autocmd ColorScheme * hi BadWhitespace ctermbg=red guibg=darkred
hi Folded guibg=grey20 guifg=Cyan ctermbg=DarkBlue ctermfg=Grey
hi Search ctermfg=black ctermbg=yellow

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
" }}}

" Use The Silver Searcher (https://github.com/ggreer/the_silver_searcher) {{{
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup
  let g:grep_cmd_opts = '--line-numbers --noheading'

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
" }}}

" Basic Settings {{{
set clipboard=unnamed
set encoding=utf-8
set number
set relativenumber
set numberwidth=5
set title
set wildmenu
set wildmode=full

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

set nowrap                  " turn off automatic line wrapping
set autoindent              " set auto-indenting for programming
set noerrorbells            " turn off the bells
set showmatch               " automatically show matching brackets
set incsearch               " enable incremental search
set cindent                 " automatic C program indenting
set ignorecase              " ignore case in searches
set smartcase               " ...unless it contains uppercase letters
set lazyredraw              " do not redraw while executing macros
set shiftwidth=4            " width for auto indent, <<, >>
set smarttab                " insert blanks at line start
set tabstop=4               " width for tab stops
set softtabstop=4           " width for soft tab stops tab (tabs while editing)
set expandtab               " uses spaces, not tabs
set backspace=indent,eol,start
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set listchars=tab:>-,trail:.,extends:>,precedes:<
set formatoptions=tcqr

set showcmd                 " show command in the last line of the screen
set ruler                   " always show the ruler
set laststatus=2            " always show the status line
set scrolloff=3             " preserve three lines of context

set diffopt=iwhite,icase,vertical,filler,context:4

set foldopen=block,mark,percent,quickfix,search,tag,undo
" }}}

" General Mappings {{{
let mapleader=","           " change the leader to be a comma vs slash
let maplocalleader="\\"     " change the leader to be a comma vs slash
" sudo write this
cnoremap W! w !sudo tee % >/dev/null
" open/close the quickfix window
nnoremap <leader>c :copen<CR>
nnoremap <leader>cc :cclose<CR>
vnoremap p <Esc>:let curren_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

nnoremap <leader>d :execute 'NERDTreeToggle'<CR>
nnoremap <leader><leader> <c-^>

" function keys {{{
nnoremap <F2> @q
nnoremap <F3> :noh<CR>
nnoremap <F4> :%s///g<CR>''
nnoremap <F5> :set list!<CR>:set list?<CR>
nnoremap <F6> :set number!<CR>:set number?<CR>
nnoremap <F12> :YcmCompleter GoToDefinitionElseDeclaration<CR>
" }}}

" easier navigation betwen splits - no need for CTRL-W before each
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
inoremap <c-w> <c-o><c-w>       
" capitalize the a word in insert mode/normal mode
inoremap <c-u> <esc>gUiw`]a
nnoremap <c-u> gUiw`]
" page up/page down
nmap <c-@> <c-space>
nnoremap <c-space> <c-b>
nnoremap <space> <c-f>
" edit and source vimrc
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" surround with double quotes/single quotes
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
" }}}

" Abbreviations {{{
iabbrev adn and
" }}}

" C/C++ settings {{{
augroup filetype_c_cpp
    autocmd BufNewFile,BufRead *.c,*.h,*.cpp,*.cxx setlocal foldmethod=syntax
    autocmd BufWinLeave *.c,*.h,*.cpp,*.cxx mkview
    autocmd BufWinEnter *.c,*.h,*.cpp,*.cxx silent loadview
augroup END
" }}}

"vim file settings {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim nnoremap <buffer> <localleader>c I"<esc>
augroup END
" }}}

" XML file settings {{{
augroup filetype_xml
    autocmd!
    autocmd BufRead *.xml set synmaxcol=200           
augroup END
" }}}

" Python settings {{{
augroup filetype_python
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType python :iabbrev <buffer> iff if:<left>
    autocmd BufWinLeave *.py mkview
    autocmd BufWinEnter *.py silent loadview
    autocmd BufNewFile,BufRead *.py
        \ set textwidth=79 |
        \ set autoindent |
        \ set fileformat=unix |
        \ match BadWhitespace /\s\+$/
augroup END
" }}}

" Other file type settings {{{
augroup misc
    autocmd!
    autocmd BufNewFile,BufRead *.m set filetype=matlab
    autocmd FileType text setlocal textwidth=79
augroup END
" }}}

" Windows Specific Settings {{{
"let g:my_vim_dir=expand("$HOME/Documents/.vim")
"if has("win16") || has("win32") || has("win64")
"    execute "set rtp^=".g:my_vim_dir
"    execute "set rtp+=".g:my_vim_dir."\\after"
"    let &rtp=substitute(&rtp,"[/]","\\","g")
"
"    if &shell=~#'bash$'
"        set shell=$COMSPEC
"    endif
"endif
" }}}

if filereadable($HOME . "./.vimrc.local")
    source ~/.vimrc.local
endif
