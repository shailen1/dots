execute pathogen#infect()

set nocompatible
" Tabs/spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set clipboard+=unnamed

" keep blocks selected when indenting
vnoremap < <gv
vnoremap > >gv

" no fold by default
" set nofoldenable

" ,a to search
map <leader>a :Ack 

" ,<space> clears search result highlights etc
map <leader><space> :let @/=''<cr>

" add beams etc to useless file list
set wildignore+=*.beam,*.dump,*~,*.o,.git,*.png,*.jpg,*.gif,_rel*
set encoding=utf-8

augroup myfiletypes
  autocmd!
  autocmd BufNewFile,BufRead *.jinja        set filetype=jinja
  autocmd BufNewFile,BufRead *.sql          set filetype=psql
  autocmd BufNewFile,BufRead *.migration    set filetype=psql
  autocmd BufNewFile,BufRead *.vcl          set filetype=vcl
  autocmd BufNewFile,BufRead *.json         set filetype=json
  autocmd BufNewFile,BufRead *.mkd,*.md     set filetype=mkd ai formatoptions=tcroqn2
  autocmd BufNewFile,BufRead *.erl          set filetype=erlang
  autocmd BufNewFile,BufRead *.md           set filetype=markdown

  " go to beginning, insert boilerplate, then line 2
  autocmd BufNewFile *.py                   0r ~/.janus/python-boilerplate.py
  autocmd BufNewFile *.py                   2

  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml          set ai sw=2 sts=2 et
  " Over-length highlighting (110 chars)
  autocmd FileType python highlight link OverLength SpellBad
  autocmd FileType python match OverLength /\%111v.\+/
  autocmd FileType python set ai sw=4 sts=4 et
  autocmd FileType erlang set ai sw=4 sts=4 et
augroup END

" Python stuff
let python_highlight_all=1
let g:syntastic_python_flake8_args='--max-complexity=10 --max-line-length=110 --ignore=W191'
let g:syntastic_python_checkers=['flake8']
let g:syntastic_check_on_open=0
let g:syntastic_enable_signs=0
let g:syntastic_enable_erlang_checker = 1
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_erlang_checkers = ['syntaxerl']
let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_aggregate_errors = 1

set viminfo='20,\"1000

augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
"let g:airline_symbols.linenr = '¶'
"let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
"let g:airline_symbols.whitespace = 'Ξ'

" Easier buffer navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Use the same symbols as TextMate for tabstops and EOLs
"set list
set listchars=tab:▸\ ,eol:¬

" Color scheme (terminal)
set background=light
colorscheme rainbow_neon
"colorscheme blueshift
"colorscheme google
"colorscheme simple256
"colorscheme smyck
"colorscheme bubblegum
"colorscheme delek

"map <F2> :NERDTreeToggle<cr>
"let NERDTreeIgnore=['\.beam$', '\.dump$', '\.pyc', '\~$', '^\.', '^_rel']
syntax on
filetype plugin indent on

"set runtimepath^=~/.vim/bundle/vim-erlang-tags,~/.vim/bundle/vim-erlang-compiler,~/bundle/ctrlp.vim,~/.vim/bundle/vimshell.vim,~/.vim/bundle/vimproc.vim
set runtimepath^=~/.vim/bundle/vim-erlang-runtime,~/.vim/bundle/vim-erlang-tags,~/.vim/bundle/vim-erlang-omnicomplete,~/.vim/bundle/vim-erlang-compiler,~/bundle/ctrlp.vim,~/.vim/bundle/vimshell.vim,~/.vim/bundle/vimproc.vim

" git gutter settings
let g:gitgutter_highlight_lines = 1

set showmode
set mouse=a

set foldenable
set ic
set incsearch
set cursorline
hi CursorLine   cterm=NONE ctermbg=black ctermfg=white

"airline all the time
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#checks = []
set laststatus=2

set undodir=~/.vim/.undodir/
set undofile
set undolevels=10000
set undoreload=1000


" neocompletecache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"


" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType erlang setlocal omnifunc=erlangcomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'


" ctrl-p
let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'


let g:ctrlp_map = '<c-a>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

autocmd QuickFixCmdPost *grep* cwindow

"NerdTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"Tagbar
nnoremap <F1> :TagbarToggle<cr>
"Undo-tree
nnoremap <F2> :GundoToggle<cr>
nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>
set nonumber
nnoremap <F4> :set number! number?<CR>
nnoremap <F5> :NERDTreeToggle<CR>
nnoremap <F10> :VimShell<cr>

set tags^=~/ejabberd/prod,~/sunEd/c_a/tags,~/dev/etags,~/dev/ctags,~/devj/jtags,~/devp/ptags,~/devr/rtags

autocmd BufWritePost *.erl :silent !(~/.vim/bundle/vim-erlang-tags/bin/vim-erlang-tags.erl )
autocmd BufWritePost *.c :silent !(cd ~/dev:ctags -R -f ~/dev/ctags . ):
autocmd BufWritePost *.java :silent !(cd ~/devj:ctags -R -f ~/devj/jtags . ):
autocmd BufWritePost *.py :silent !(cd ~/devp:ctags -R -f ~/devp/ptags . ):
autocmd BufWritePost *.rb :silent !(cd ~/devr:ctags -R -f ~/devr/rtags . ):

"autocmd BufWinEnter * :silent !(tmux source-file ~/.tmux.conf)
"autocmd BufWinLeave * :silent !(tmux source-file ~/.tmux.conf)
" If you want to auto compile (erlc) upon saving a file, then add that one as well
" Run erlc on the file being saved
autocmd BufWritePost *.erl :!erlc <afile>

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif
endif


