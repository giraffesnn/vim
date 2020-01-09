" 1. Indentation & Tabs

"To automatically align the indentation of a line in a file
set autoindent 

" Smart Indent uses the code syntax and style to align
set smartindent	

" To set the number of spaces to display for a tab
set tabstop=4

" number of spaces in tab when editing
set softtabstop=4

" To set the number of spaces to display for a “shift operation” (such as ‘>>’ or ‘<<’)
set shiftwidth=4

" tabs are spaces
set expandtab

" 2. Display & Format

" To show line numbers
set number " set nonumber

" To wrap text when it crosses the maximum line width
set textwidth=80

" To wrap text based on a number of columns from the right side
set wrapmargin=2

" To identify open and close brace positions when you traverse through the file
set showmatch

" Showing line numbers should need no justification
set showcmd

" highlight current line
"set cursorline

" load filetype-specific indent files
filetype indent on

" visual autocomplete for command menu
set wildmenu

" redraw only when we need to
set lazyredraw

" 3. Search

" To highlight the searched term in a file
set hlsearch

" To perform incremental searches as you type
set incsearch

" 4. Browse & Scroll
" To display a permanent status bar at the bottom of the vim screen showing the
" filename, row number, column number
set laststatus=2
set statusline+=%F

" 5. Spell
" Use the following command to turn on spell-check for the English language
" set spell spelllang=en_us

" 6. Miscellaneous

" Disable creating backup file
set nobackup

" Disable creating a swap file
set noswapfile

" Suppose you need to edit multiple files in the same vim session and switch between them
set autochdir

" Maintains the undo history even after the file is closed
set noundofile

" 7. Bonus

" Short format for the autoindent command
set ai

" Quickest Way to Revert Spaces to TABs in VIM
autocmd FileType make setlocal noexpandtab

" Cscope
set cscopetag
set csto=0
set cscoperelative

if filereadable("cscope.out")
       cs add cscope.out   
   elseif $CSCOPE_DB != ""
           cs add $CSCOPE_DB
       endif
       set cscopeverbose

nmap zs :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap zg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap zc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap zt :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap ze :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap zf :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap zi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap zd :cs find d <C-R>=expand("<cword>")<CR><CR>

