set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug '907th/vim-auto-save'
Plug 'bluz71/vim-moonfly-statusline'
Plug 'chaoren/vim-wordmotion'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'OmniSharp/omnisharp-vim'
Plug 'rakr/vim-one'
Plug 'rhysd/clever-f.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'mhinz/vim-startify'
Plug 'wellle/targets.vim'
call plug#end()

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set autoread
set clipboard=unnamed

" Setup the theme
colorscheme one
set background=dark

set relativenumber        " Show line numbers

syntax on                 " Turn on syntax highlighting
syntax sync minlines=256  " Makes big files slow
set synmaxcol=2048        " Also long lines are slow

set autoindent            " try your darndest to keep my indentation
set smartindent           " Be smarter about indenting dummy

set formatoptions=tcqr    " I like smart comments
set encoding=utf-8        " Use UTF8 encoded text
set mousehide             " Hide the mouse when typing
set list                  " Show invisible characters
set backspace=2           " Backspace over eol, indent and insert
set scrolloff=3           " Start scrolling when im 3 lines from the top/bottom

set hlsearch              " highlight my search
set incsearch             " incremental search
set wrapscan              " Set the search scan to wrap around the file
set ignorecase            " when searching
set smartcase             " …unless I use an uppercase character
set gdefault              " Do global replaces by default

set foldmethod=syntax " Fold on indents
set foldnestmax=2

set wrap
set textwidth=79
set colorcolumn=80

" No backup or swap files
set nobackup
set nowritebackup
set noswapfile
if v:version >= 730
    set undofile                " keep a persistent backup file
    set undodir=~/.vim/.undo,~/tmp,/tmp
endif
set directory=~/.vim/.tmp,~/tmp,/tmp

" History stuff
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo

set visualbell           " don't beep
set noerrorbells         " don't beep

set cursorline           " underline the current line, for quick orientation

" Set the leader key
let mapleader=','

" Key mappings

" Damian Conway's Die Blinkënmatchen: highlight matches
nnoremap <silent> n n:call HLNext(0.1)<cr>
nnoremap <silent> N N:call HLNext(0.1)<cr>

function! HLNext (blinktime)
  let target_pat = '\c\%#'.@/
  let ring = matchadd('ErrorMsg', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
  call matchdelete(ring)
  redraw
endfunction

" Make regex sane
nnoremap / /\v
vnoremap / /\v

" Indent highlight stuff
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
let g:indent_guides_auto_colors = 1
let g:indent_guides_space_guides = 1

"Timeout stuff
set timeout
set timeoutlen=2500
set ttimeoutlen=10

" Setup my status line
set laststatus=2

" Syntastic stuff
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']

" Character replacements
set conceallevel=1
set concealcursor=nvic
let g:javascript_conceal_function       = "ƒ"
let g:javascript_conceal_null           = "ø"
let g:javascript_conceal_this           = "@"
let g:javascript_conceal_undefined      = "¿"
let g:javascript_conceal_return         = "«"
let g:javascript_conceal_prototype      = "¶"
let g:javascript_conceal_static         = "•"
let g:javascript_conceal_super          = "Ω"
let g:javascript_conceal_arrow_function = "⇒"

" Ignoring folders in CTRLP
let g:ctrlp_custom_ignore = '\v[\/](\.(git|hg|svn)|(node_modules)|(DS_Store))$'

" Other CTRLP stuff
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'rwa'
let g:ctrlp_max_files = 0
let g:ctrlp_use_caching = 1

try
  unlet g:ctrlp_user_command
catch

endtry

if executable('ag')
  if !has('win32unix')
    let g:ctrlp_use_caching = 0
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  endif
endif

" Toggle auto-indent before clipboard paste
set pastetoggle=<leader>p

" Allow quick swapping of bg
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" Makes w and e work normally with vim-wordmotion installed
nmap cw ce

"Dumb escape
inoremap <leader>j <ESC>
vnoremap <leader>j <ESC>

" un-highlight search results
nnoremap <silent><leader><space> :noh<cr>

" Shortcut to rapidly toggle `set list`
nnoremap <silent><leader>l :set list!<cr>

" Normal/Visual tab for bracket pairs
nnoremap <tab> %
vnoremap <tab> %

"Opens a vertical split and switches over (,v)
nnoremap <leader>v <C-w>v<C-w>l

"Moves around split windows
nnoremap <leader>w <C-w><C-w>

" :q and :wq close buffers
cnoreabbrev wq w<bar>bd
cnoreabbrev q bd
cnoreabbrev qq quit
cnoreabbrev wqq w<bar>quit

" Don't close buffers when swapping buffers
" Lets me change files without saving.
set hidden

" Bindings for swapping buffer next/prev.
nnoremap gt :bnext<CR>
nnoremap gT :bprevious<CR>

" Open a new buffer
nmap <leader>T :enew<CR>
" close a buffer
nmap <leader>bq :bp <BAR> bd #<CR>
" list buffers
nmap <leader>bl :ls<CR>

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Tagbar toggle
nmap <F8> :TagbarToggle<CR>

" Forcing myself to learn to use HJKL. :(
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>

" Forcing down and up to make more sense
nnoremap k gk
nnoremap j gj

" Mappings for syntastic errors.
nmap <leader><space>o :lopen<cr>      " open location window
nmap <leader><space>c :lclose<cr>     " close location window
nmap <leader><space>, :ll<cr>         " go to current error/warning
nmap <leader><space>n :lnext<cr>      " next error/warning
nmap <leader><space>p :lprev<cr>      " previous error/warning

let g:EasyMotion_do_mapping = 0
map <leader>s <plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1
map <leader>j <plug>(easymotion-j)
map <leader>k <plug>(easymition-k)

map <leader>- :Explore<cr> " File explorer

augroup cmdGroup
  autocmd!
  au FocusLost * :wa
  " Setup highlighting for braces
  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces

  au FileType json setlocal conceallevel=0
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
augroup END

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]

let g:clever_f_across_no_line = 1
let g:clever_f_fix_key_direction = 1
let g:clever_f_timeout_ms = 3000

let g:clever_f_across_no_line = 1
let g:clever_f_fix_key_direction = 1
let g:clever_f_timeout_ms = 3000

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_selector_ui = 'fzf'

let g:ale_linters = {
      \ 'cs': ['OmniSharp']
\}

let g:EditorConfig_exclude_patterns = ['fugitive://.*']
