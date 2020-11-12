" 0. VimConfig
" Simple and sane Vim configuration
" https://vimconfig.com/

" General
set number		" Show line numbers
set linebreak		" Break lines at word (requires Wrap lines)
set showbreak=+++	" Wrap-broken line prefix
set textwidth=80	" Line wrap (number of cols)
set wrapmargin=2	" To wrap text based on a number of columns from the right side
set showmatch		" Highlight matching brace
set showcmd		" Showing line numbers should need no justification
set showmode		" always show what mode we're currently editing in
set visualbell		" Use visual bell (no beeping)

set hlsearch		" Highlight all search results
set smartcase		" Enable smart-case search
set ignorecase		" Always case-insensitive
set incsearch		" Searches for strings incrementally

set autoindent		" Auto-indent new lines
set shiftwidth=4	" Number of auto-indent spaces
set smartindent		" Enable smart-indent
set smarttab		" Enable smart-tabs
set softtabstop=4	" Number of spaces per Tab

set laststatus=2        " display the status line always
set statusline+=%F      " get the full path

" Advanced
set ruler		" Show row and column ruler information

set nobackup		" Disable creating backup file
set noswapfile		" Disable creating a swap file

set nocompatible	"

set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour

syntax on               " syntax highlighting
set wildmenu            " make tab completion for files/buffers act like bash
set t_Co=256            " iTerm2 supports 256 color mode.
filetype indent on      " load filetype-specific indent files

colorscheme desert	" /usr/share/vim/vim74/colors/desert/*.vim to  ~/.vim/*.vim
set cursorline          " Highlight the current line
hi CursorLine term=bold cterm=bold guibg=Grey40
hi Pmenu ctermbg=darkgrey
hi PmenuSel ctermbg=lightblue ctermfg=white

" 1. linuxsty.vim : Vim plugin to respect the Linux kernel coding style
" https://www.vim.org/scripts/index.php
" https://github.com/vivien/vim-linux-coding-style

" Vim plugin to fit the Linux kernel coding style and help kernel development
" Maintainer:   Vivien Didelot <vivien.didelot@savoirfairelinux.com>
" License:      Distributed under the same terms as Vim itself.
"
" This script is inspired from an article written by Bart:
" http://www.jukie.net/bart/blog/vim-and-linux-coding-style
" and various user comments.
"
" For those who want to apply these options conditionally, you can define an
" array of patterns in your vimrc and these options will be applied only if
" the buffer's path matches one of the pattern. In the following example,
" options will be applied only if "/linux/" or "/kernel" is in buffer's path.
"
"   let g:linuxsty_patterns = [ "/linux/", "/kernel/" ]
let g:linuxsty_patterns = ["/home/zhangyb/work/kernel-source/mainline/"]

if exists("g:loaded_linuxsty")
    finish
endif
let g:loaded_linuxsty = 1

set wildignore+=*.ko,*.mod.c,*.order,modules.builtin

augroup linuxsty
    autocmd!

    autocmd FileType c,cpp call s:LinuxConfigure()
    autocmd FileType diff setlocal ts=8
    autocmd FileType rst setlocal ts=8 sw=8 sts=8 noet
    autocmd FileType kconfig setlocal ts=8 sw=8 sts=8 noet
    autocmd FileType dts setlocal ts=8 sw=8 sts=8 noet
augroup END

function s:LinuxConfigure()
    let apply_style = 0

    if exists("g:linuxsty_patterns")
        let path = expand('%:p')
        for p in g:linuxsty_patterns
            if path =~ p
                let apply_style = 1
                break
            endif
        endfor
    else
        let apply_style = 1
    endif

    if apply_style
        call s:LinuxCodingStyle()
    endif
endfunction

command! LinuxCodingStyle call s:LinuxCodingStyle()

function! s:LinuxCodingStyle()
    call s:LinuxFormatting()
    call s:LinuxKeywords()
    call s:LinuxHighlighting()
endfunction

function s:LinuxFormatting()
    setlocal tabstop=8
    setlocal shiftwidth=8
    setlocal softtabstop=8
    setlocal textwidth=100
    setlocal noexpandtab

    setlocal cindent
    setlocal cinoptions=:0,l1,t0,g0,(0
endfunction

function s:LinuxKeywords()
    syn keyword cOperator likely unlikely
    syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64
    syn keyword cType __u8 __u16 __u32 __u64 __s8 __s16 __s32 __s64
endfunction

function s:LinuxHighlighting()
    highlight default link LinuxError ErrorMsg

    syn match LinuxError / \+\ze\t/     " spaces before tab
    syn match LinuxError /\%>100v[^()\{\}\[\]<>]\+/ " virtual column 101 and more

    " Highlight trailing whitespace, unless we're in insert mode and the
    " cursor's placed right after the whitespace. This prevents us from having
    " to put up with whitespace being highlighted in the middle of typing
    " something
    autocmd InsertEnter * match LinuxError /\s\+\%#\@<!$/
    autocmd InsertLeave * match LinuxError /\s\+$/
endfunction

" vim: ts=4 et sw=4

" 2. cscope_macros.vim : basic cscope settings and key mappings
" https://www.vim.org/scripts/index.php

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE:
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE:
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     9/12/2001
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim...
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0
    cs kill 0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add the database pointed to by environment variable
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
	endif

    " show msg when any other cscope db added
	set cscopeverbose


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.
    "

    "nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    "nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    "nmap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
    "nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
    nmap zs :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap zg :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap zc :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap zt :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap ze :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap zf :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap zi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap zd :cs find d <C-R>=expand("<cword>")<CR><CR>


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@>i :scs find i <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>


    " Hitting CTRL-space *twice* before the search type does a vertical
    " split instead of a horizontal one (vim 6 and up only)

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@><C-@>i :vert scs find i <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or
    " network connection, set it higher.  If you don't set ttimeoutlen, the
    " value for timeoutlent (default: 1000) is used.
    "
    "set ttimeoutlen=100

endif

" Vim Better Whitespace Plugin
" git clone https://github.com/ntpeters/vim-better-whitespace.git ~/.vim/pack/vendor/start/vim-better-whitespace
" To enable highlighting and stripping whitespace on save by default, use respectively
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
let g:strip_whitelines_at_eof=1
let g:show_spaces_that_precede_tabs=1

" NERDTree plugin: https://github.com/preservim/nerdtree
" Vim 8+ packages
" git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
" vim -u NONE -c "helptags ~/.vim/pack/vendor/start/nerdtree/doc" -c q
map <F2> :NERDTreeToggle<CR>

" taglist plugin
" https://www.swapreference.com/vim-vim-plugins/
" git clone https://github.com/yegappan/taglist.git ~/.vim/pack/vendor/start/taglist

" it depends on catgs
" $ctags -R
set tags=./tags,tags;

map <F3> <Esc>:TlistToggle<Cr>
" required configuration of taglist
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1

" vim-gitgutter
" mkdir -p ~/.vim/pack/airblade/start
" cd ~/.vim/pack/airblade/start
" git clone https://github.com/airblade/vim-gitgutter.git
" vim -u NONE -c "helptags vim-gitgutter/doc" -c q
set updatetime=100
let g:gitgutter_grep=''
let g:gitgutter_terminal_reports_focus=0
