""" Vi IMproved
set nocompatible

""" ENCODING
set encoding=utf8 " default encoding is UTF-8
set fileformats=unix,dos,mac
set fileencodings=utf-8,euc-jp,iso-2022-jp,default,latin

""" SYNTAX
syntax enable
set modeline " use modeline
set number   " show line number
set list     " show unvisible chars
set listchars=eol:\ ,trail:\-,tab:>-,
hi Type ctermfg=blue cterm=bold

""" STATUS LINE
set cmdheight=1
set laststatus=2
set ruler       "show the cursor position all the time
highlight LineNr ctermfg=green ctermbg=black

""" LINE
set number
set wildmenu
set wildmode=list,full

""" SEARCH
set smartcase incsearch
set hlsearch
set display=uhex
set history=50  "keep 50 lines of command line history

""" TAB
set tabstop=2
set shiftwidth=2
set softtabstop=0
set smarttab expandtab
set smartindent autoindent

""" BACKSPACE
set backspace=indent,eol,start

""" LINE-BREAK
set textwidth=0 "don't break automatically

""" BACKUP
set writebackup "create backup file before overwriting

""" MOUSE
set mouse=n

""" SYNTAX TOGGLE
function! ToggleSyntax()
   if exists("g:syntax_on")
      syntax off "Not 'syntax clear' (which does something else)
      echo "SYNTAX OFF"
   else
      syntax enable "Not 'syntax on' (which overrides colorscheme)
      echo "SYNTAX ON"
   endif
endfunction
nnoremap <silent> ;s :call ToggleSyntax()<CR>

""" BUFFER MANAGEMENT
nnoremap <silent> [ :ls<CR>:b
nnoremap <silent> ] :bn<CR>

""" SUPPLEMENTATION
inoremap <silent> __ <C-p>
inoremap <silent> ]] <C-x><C-k>

""" SEARCH CLEAR
nnoremap <silent> ;c :noh<CR>

""" PASTEMODE
function! PasteModeOn()
  set mouse=
  set paste
  set nolist
  set nonumber
  echo "PASTE MODE ON"
endfunction
function! PasteModeOff()
  set mouse=n
  set nopaste
  set list
  set number
  echo "PASTE MODE OFF"
endfunction
nnoremap <silent> <C-i> :call PasteModeOn()<CR>
nnoremap <silent> ;; :call PasteModeOff()<CR>

""" ZENKAKU HIGHLIGHT
highlight ZenkakuSpace cterm=underline ctermfg=lightblue ctermbg=white
match ZenkakuSpace /　/

""" TEMPLATE
augroup SkeletonAu
    autocmd!
    autocmd BufNewFile *.html 0r $HOME/.vim/templates/skel.html
    autocmd BufNewFile *.tex  0r $HOME/.vim/templates/skel.tex
augroup END

autocmd FileType ruby setlocal tabstop=3 shiftwidth=3 softtabstop=3 expandtab
autocmd FileType make setlocal noexpandtab

"" SWITCH EISU on NORMAL MODE

" if executable('osascript')
"   let s:keycode_jis_eisuu = 102
"   let g:force_alphanumeric_input_command = "osascript -e 'tell application \"System Events\" to key code " . s:keycode_jis_eisuu . "' &"
" 
"   inoremap <silent> <Esc> <Esc>:call system(g:force_alphanumeric_input_command)<CR>
" 
"   autocmd! FocusGained *
"     \ call system(g:force_alphanumeric_input_command)
" endif

""" NEOBUNDLE
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
" let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
" originalrepos on github
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'wting/rust.vim'
NeoBundle 'derekwyatt/vim-scala.git'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tomasr/molokai'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundleLazy 'mattn/emmet-vim', {"autoload": {"filetypes": ['css','scss','html']}}
NeoBundleLazy 'Blackrush/vim-gocode', {"autoload": {"filetypes": ['go']}}
NeoBundleCheck
filetype plugin indent on

""" PLUGIN SETTINGS

" emmet-vim
let g:user_emmet_settings = {
  \ 'variables': {
  \     'lang' : 'ja',
  \   }
  \ }

" lightline
if !has('gui_running')
  set t_Co=256
endif
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ }
augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost * call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

" colorscheme molokai
colorscheme molokai

" neocomplete
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

imap <expr><CR> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"

