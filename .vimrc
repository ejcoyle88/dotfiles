set nocompatible " be iMproved, required

"--------- VUNDLE PLUGINS
filetype off   " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'morhetz/gruvbox'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mhinz/vim-startify'
Plugin 'tpope/vim-obsession'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'PProvost/vim-ps1'
Plugin 'rking/ag.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-surround'
Plugin 'majutsushi/tagbar'
Plugin 'derekwyatt/vim-scala'

filetype plugin indent on " Required
"-------- VUNDLE PLUGINS

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
let g:jsx_ext_required = 0

set autoread
set clipboard=unnamed

" Setup the theme
set background=dark
let g:gruvbox_termcolors =256
set t_Co=256
set t_ut=
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_contrast_light = 'medium'

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

set foldmethod=indent " Fold on indents
set foldnestmax=2
"set nofoldenable "But turn it off initially

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

" Allow quick swapping of bg
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" Explorer
map <leader>- :Texplore<CR>

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

"Dumb escape
inoremap <leader>j <ESC>
vnoremap <leader>j <ESC>

" un-highlight search results
nnoremap <silent><leader><space> :noh<cr>

" Toggle auto-indent before clipboard paste
set pastetoggle=<leader>p

" Shortcut to rapidly toggle `set list`
nnoremap <silent><leader>l :set list!<cr>

" Normal/Visual tab for bracket pairs
nnoremap <tab> %
vnoremap <tab> %

map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

"Opens a vertical split and switches over (,v)
nnoremap <leader>v <C-w>v<C-w>l

"Moves around split windows
nnoremap <leader>w <C-w><C-w>

" Save easier because im clumsy
nnoremap <silent><leader>s :w<cr>

"Close a window
nnoremap <silent><leader>q :q<cr>

" Close buffer
noremap <silent><leader>d :bd<cr>

" Buffer previous
noremap <silent><leader>z :bp<CR>

" Buffer next
noremap <silent><leader>x :bn<CR>

nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew %<CR>

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Tagbar toggle
nmap <F8> :TagbarToggle<CR>

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
set statusline=%f\ %h%w%m%r\ 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%=%(%l,%c%V\ %=\ %P%)

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

" Forcing myself to learn to use HJKL. :(
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <up> <nop>

" Mappings for syntastic errors.
nmap <leader><space>o :lopen<cr>      " open location window
nmap <leader><space>c :lclose<cr>     " close location window
nmap <leader><space>, :ll<cr>         " go to current error/warning
nmap <leader><space>n :lnext<cr>      " next error/warning
nmap <leader><space>p :lprev<cr>      " previous error/warning

map <leader>- :Texplore<cr> " File explorer

augroup cmdGroup
  autocmd!
  au FocusLost * :wa
  " Setup highlighting for braces
  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces

  au FileType json setlocal conceallevel=0
augroup END
