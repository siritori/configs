" ENCODING
set encoding=utf8 "default encoding is UTF-8
set fileformats=unix,dos,mac
set fileencodings=iso-2022-jp,utf-8,euc-jp,default,latin

" SYNTAX
set list
set listchars=eol:\ ,trail:\$,tab:>-,
set number      "show line number

" STATUS LINE
set cmdheight=1
set laststatus=2
set showmode    "show current mode
set ruler       "show the cursor position all the time
highlight LineNr ctermfg=green ctermbg=black

" LINE
set number
set wildmenu

" SEARCH
set smartcase incsearch
set hlsearch
set display=uhex
set history=50  "keep 50 lines of command line history
syntax enable

" TAB
set smarttab expandtab
set smartindent autoindent
set ts=3
set sw=3
set sts=0

" BACKSPACE
set backspace=indent,eol,start

" BACKUP
set nobackup    "don't create backup file
set writebackup "create backup file before overwriting

" MOUSE
set mouse=a

"for syntax toggle
function! ToggleSyntax()
   if exists("g:syntax_on")
      syntax off "Not 'syntax clear' (which does something else)
      echo "syntax off"
   else
      syntax enable "Not 'syntax on' (which overrides colorscheme)
      echo "syntax on"
   endif
endfunction
nmap <silent> ;s :call ToggleSyntax()<CR>

