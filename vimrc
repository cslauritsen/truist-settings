" reload changes automatically when saved
autocmd! bufwritepost .vimrc source ~/.vimrc

set nocompatible

set runtimepath+=~/.vim

if has("multi_byte")
	if &termencoding == ""
		let &termencoding = &encoding
	endif
	set encoding=utf-8
	setglobal fileencoding=utf-8
	"setglobal bomb
	set fileencodings=ucs-bom,utf-8,latin1
endif

" pathogen (https://github.com/tpope/vim-pathogen)
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

"general ui
set showmatch
set ruler
set showmode
"show e.g. number of lines selected
set showcmd
set title
" turn off beeps
set vb
" margin while scrolling
set scrolloff=3

" search settings
set incsearch
set ignorecase
set smartcase
set hlsearch
"clear search highlighting by hitting enter
nnoremap <cr> :noh<CR><CR>:<backspace>

if has('mouse')
  set mouse=a
  " use with <alt> on OSX; set cursor position; scroll
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" syntax highlight and indentation settings
syntax on
autocmd BufRead,BufNewFile *.t set filetype=perl
autocmd BufRead,BufNewFile *.mdwn set filetype=ikiwiki

" vim-gitgutter
highlight clear SignColumn

" indentation / tabbing
set autoindent
filetype plugin indent on
set cindent
" make the backspace key work with autoindent
set backspace=indent,eol,start

au BufEnter * set nowrap tabstop=4 shiftwidth=4
au BufEnter *.sh set nowrap tabstop=4 shiftwidth=4
au BufEnter *.tt set nowrap tabstop=4 shiftwidth=4
au BufEnter *.mdwn set expandtab nowrap tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
"au BufEnter *.md set expandtab nowrap tabstop=4 shiftwidth=4 softtabstop=4
au BufEnter *.js set expandtab nowrap tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
au BufEnter *.ep set nowrap tabstop=4 shiftwidth=4
au BufEnter *.html set nowrap tabstop=4 shiftwidth=4
au BufEnter *.css set nowrap tabstop=4 shiftwidth=4
au BufEnter *.xml set nowrap tabstop=4 shiftwidth=4

" indent/unindent selected lines in visual mode
vmap <tab> >gv
vmap <s-tab> <gv

" sudo write
ca w!! w !sudo tee >/dev/null "%"

" turn off all code folding
autocmd BufEnter * set nofoldenable

" shortcuts for paste mode in normal and insert modes
" DON'T REMEMBER WHAT THIS DOES, AND IT CAUSES A ONE-SECOND DELAY AFTER
" HITTING :
"nnoremap  :set invpaste paste?<CR>
"set pastetoggle=

" highlight text past 80 columns
au BufWinEnter *.t let w:m2=matchadd('Search', '\%>80v.\+', -1)
au BufWinEnter *.p? let w:m2=matchadd('Search', '\%>80v.\+', -1)
au BufWinEnter *.sh let w:m2=matchadd('Search', '\%>80v.\+', -1)

" shortcuts to comment/uncomment lines
map ,# :s/^/#<CR>
map ,## :s/^#<CR>

" shortcut to wrap text to 75 columns
map ,w !fmt<CR>

" delete/change/etc text between parentheseis
" to use: type 'dp' or 'cp' (etc.) while in normal mode
onoremap p i(


" configure Supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabMidWordCompletion = "0"

" make the tmux status line show the currently-edited file
if &term == "screen" || &term == "screen-256color"
        set t_ts=
endif
"if &term == "screen" || &term == "screen-256color" || &term == "xterm" || &term == "xterm-color" || &term == "xterm-256color"
        set title
"endif
autocmd BufEnter * let &titlestring = "vim " . expand("%:h") . "/" . expand("%:t")

