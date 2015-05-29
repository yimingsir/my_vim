scriptencoding utf-8

set nocompatible
syntax on
 
call pathogen#infect()
filetype plugin indent on
 
" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd     " Show (partial) command in status line.
"set showmatch      " Show matching brackets.
"set ignorecase     " Do case insensitive matching
set smartcase       " Do smart case matching
"set incsearch      " Incremental search
"set autowrite      " Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
""set mouse=a     " Enable mouse usage (all modes)
set nu
set tabstop=4
set softtabstop=4
"set shiftwidth=4
set expandtab           " use whitespace instead of tab
set autoindent
set smartindent
set cindent shiftwidth=4
"set autoindent shiftwidth=4
"set foldmethod=indent
set backspace=indent,eol,start
set colorcolumn=80
 
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
 
" === tagbar setting =======
nmap <F4> :TagbarToggle<CR>   " shortcut
let g:tagbar_width = 40      " tagbar's width, default 20
autocmd VimEnter * nested :call tagbar#autoopen(1)  "automate to open tagbar
"let g:tagbar_left = 1       " on the left side
let g:tagbar_right = 1     " on the right side
" =======end==================
 
" switch window
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" ===== brace autocompletion =========
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<CR>}<Esc>O
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
 return "\<Right>"
 else
 return a:char
 endif
endf

function CloseBracket()
 if match(getline(line('.') + 1), '\s*}') < 0
 return "\<CR>}"
 else
 return "\<Esc>j0f}a"
 endif
endf

function QuoteDelim(char)
 let line = getline('.')
 let col = col('.')
 if line[col - 2] == "\\"
 "Inserting a quoted quotation mark into the string
 return a:char
 elseif line[col - 1] == a:char
 "Escaping out of the string
 return "\<Right>"
 else
 "Starting a string
 return a:char.a:char."\<Esc>i"
 endif
endf
 
" NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd vimenter * NERDTree
wincmd w
autocmd VimEnter * wincmd w
map <C-m> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore=['\.pyc', '\.pyo', '\.swp', '\~'] " ignore *.py[co], *.swp and *~

" pydiction
let g:pydiction_location = '/home/gbs/.vim/bundle/pydiction/complete-dict'
let g:pydiction_menu_height = 3
 
" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
    source /etc/vim/vimrc.local
endif
