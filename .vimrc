" 0. VimConfig
" Simple and sane Vim configuration
" https://vimconfig.com/

" General
set number		" Show line numbers
set linebreak		" Break lines at word (requires Wrap lines)
set showbreak=+++	" Wrap-broken line prefix
set textwidth=100	" Line wrap (number of cols)
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
set smartindent		" Enable smart-indent
set smarttab		" Enable smart-tabs
set tabstop=8
set shiftwidth=8
set softtabstop=8
set noexpandtab

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
" https://github.com/vivien/vim-linux-coding-style
" Installation:
"    You can just drop the linuxsty.vim file in your ~/.vim/plugin directory.

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
map <C-n> :NERDTreeToggle<CR>

" taglist plugin
" https://www.swapreference.com/vim-vim-plugins/
" git clone https://github.com/yegappan/taglist.git ~/.vim/pack/vendor/start/taglist

" it depends on catgs
" $ctags -R
set tags=./tags,tags;

map <C-t> <Esc>:TlistToggle<Cr>
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

" lightline
" git clone https://github.com/itchyny/lightline.vim ~/.vim/pack/vendor/start/lightline

" ftrace: function_graph
" https://www.kernel.org/doc/Documentation/trace/function-graph-fold.vim
" ~/.vim/pack/ftrace/start/function_graph
" To use, :source this file while viewing a function_graph trace, or use vim's
" -S option to load from the command-line together with a trace.

" YouComPleteMe
" git clone https://github.com/ycm-core/YouCompleteMe ~/.vim/pack/vendor/start/YouCompleteMe
" cd ~/.vim/pack/vendor/start/YouCompleteMe
" sudo apt install build-essential cmake vim python3-dev
" Minimum compiler versions have been increased:
" https://github.com/ycm-core/YouCompleteMe#readme
" git submodule update --init --recursive
" python ./install.py --clangd-completer or python ./install.py --all
set completeopt=menu,menuone,noinsert,noselect
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" |
set ttimeout
set ttimeoutlen=20

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
	\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
	\ 'cs,lua,javascript': ['re!\w{2}'],
	\ }

let g:ycm_filetype_whitelist = {
	\ "c":1,
	\ "cpp":1,
	\ "dts":1,
	\ "dtsi":1,
	\ "sh":1,
	\ "rst":1,
	\ }

" YCM-Generator
" git clone https://github.com/rdnetto/YCM-Generator ~/.vim/pack/vendor/start/YCM-Generator
noremap <C-I> :YcmGenerateConfig -c g++ -v -x c++ -f -b make .<CR>

" ripgrep
" git clone https://github.com/jremmen/vim-ripgrep.git
" cp vim-ripgrep/plugin/vim-ripgrep.vim ~/.vim/plugin/
" Ubuntu: sudo apt-get install ripgrep

" LeaderF
" git clone https://github.com/Yggdroot/LeaderF.git ~/.vim/pack/vendor/start/LeaderF
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_UseCache = 0
let g:Lf_UseMemoryCache = 0
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

" search word under cursor, the pattern is treated as regex, and enter normal mode directly
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>

" search word under cursor, the pattern is treated as regex,
" append the result to previous search results.
noremap <C-G> :<C-U><C-R>=printf("Leaderf! rg --append -e %s ", expand("<cword>"))<CR>

" search word under cursor literally only in current buffer
noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg -F --current-buffer -e %s ", expand("<cword>"))<CR>

" search word under cursor literally in all listed buffers
noremap <C-D> :<C-U><C-R>=printf("Leaderf! rg -F --all-buffers -e %s ", expand("<cword>"))<CR>

" search visually selected text literally, don't quit LeaderF after accepting an entry
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F --stayOpen -e %s ", leaderf#Rg#visual())<CR>

" recall last search. If the result window is closed, reopen it.
noremap go :<C-U>Leaderf! rg --recall<CR>


" search word under cursor in *.h and *.cpp files.
noremap <Leader>a :<C-U><C-R>=printf("Leaderf! rg -e %s -g *.h -g *.cpp", expand("<cword>"))<CR>
" the same as above
noremap <Leader>a :<C-U><C-R>=printf("Leaderf! rg -e %s -g *.{h,cpp}", expand("<cword>"))<CR>

" search word under cursor in cpp and java files.
noremap <Leader>b :<C-U><C-R>=printf("Leaderf! rg -e %s -t cpp -t java", expand("<cword>"))<CR>

" search word under cursor in cpp files, exclude the *.hpp files
noremap <Leader>c :<C-U><C-R>=printf("Leaderf! rg -e %s -t cpp -g !*.hpp", expand("<cword>"))<CR>
